require "httparty"
require "date"
require "bigdecimal"

class SteamImporter
  APP_LIST_URL =
    "https://api.steampowered.com/IStoreService/GetAppList/v1/".freeze

  APP_DETAILS_URL =
    "https://store.steampowered.com/api/appdetails".freeze

  REQUEST_DELAY = 0.35

  def initialize
    @steam_api_key =
      Rails.application.credentials.dig(:steam, :api_key)

    raise "Steam API key is missing." if @steam_api_key.blank?

    @base_game_category = Category.find_by!(name: "Base Game")
    @free_game_category = Category.find_by!(name: "Free-to-Play")
    @dlc_category = Category.find_by!(name: "DLC")
    @bundle_category = Category.find_by!(name: "Bundle")
  end

  def import_products(base_games:, free_games:, dlcs:, bundles:)
    puts "Steam importer started."

    import_steam_products(
     target_base_games: base_games,
      target_free_games: free_games,
      target_dlcs: dlcs
    )

    create_bundles(target_bundles: bundles)

    print_summary
  end

  private

  def import_steam_products(target_base_games:, target_free_games:, target_dlcs:)
  base_game_count =
    Game.where(category: @base_game_category).count

  free_game_count =
    Game.where(category: @free_game_category).count

  dlc_count =
    Game.where(category: @dlc_category).count

puts "Current paid games: #{base_game_count}/#{target_base_games}"
puts "Current free games: #{free_game_count}/#{target_free_games}"
puts "Current DLCs: #{dlc_count}/#{target_dlcs}"

return if base_game_count >= target_base_games &&
          free_game_count >= target_free_games &&
          dlc_count >= target_dlcs

    steam_apps = fetch_app_list.shuffle

steam_apps.each do |steam_app|
  break if base_game_count >= target_base_games &&
           free_game_count >= target_free_games &&
           dlc_count >= target_dlcs

      app_id = steam_app["appid"]

      next if app_id.blank?
      next if Game.exists?(steam_app_id: app_id)

      data = fetch_app_details(app_id)

      next if data.blank?

      steam_type = data["type"]

    category =
      case steam_type
      when "game"
          if data["is_free"]
            next if free_game_count >= target_free_games

            @free_game_category
          else
            next if base_game_count >= target_base_games

            @base_game_category
          end
      when "dlc"
          next if dlc_count >= target_dlcs

            @dlc_category
      else
          next
      end
      game = build_game(
        app_id: app_id,
        data: data,
        category: category
      )

      next if game.nil?

      game.save!
      assign_genres(game, data)

      case category
      when @base_game_category
        base_game_count += 1
      when @free_game_category
        free_game_count += 1
      when @dlc_category
        dlc_count += 1
      end

      puts(
        "Imported #{steam_type}: #{game.title} " \
        "(#{base_game_count}/#{target_base_games} paid games, " \
        "#{free_game_count}/#{target_free_games} free games, " \
        "#{dlc_count}/#{target_dlcs} DLCs)"
      )

      sleep REQUEST_DELAY
    rescue StandardError => error
      puts(
        "Skipped Steam App ID #{app_id}: " \
        "#{error.class} - #{error.message}"
      )
    end

    if base_game_count < target_base_games
      puts "Warning: only #{base_game_count} base games were imported."
    end

    if free_game_count < target_free_games
      puts "Warning: only #{free_game_count} free games were imported."
    end

    if dlc_count < target_dlcs
      puts "Warning: only #{dlc_count} DLCs were imported."
    end
  end

  def fetch_app_list
    puts "Downloading Steam application list..."

    response = HTTParty.get(
      APP_LIST_URL,
      query: {
        key: @steam_api_key,
        include_games: true,
        include_dlc: true,
        include_software: false,
        include_videos: false,
        include_hardware: false,
        max_results: 50_000
      },
      timeout: 60
    )

    unless response.success?
      raise(
        "Steam application list request failed. " \
        "HTTP #{response.code}: #{response.body.to_s.first(200)}"
      )
    end

    apps =
      response
        .parsed_response
        .dig("response", "apps")
        .to_a

    raise "Steam returned an empty application list." if apps.empty?

    puts "Retrieved #{apps.count} Steam applications."

    apps
  end

  def fetch_app_details(app_id)
    response = HTTParty.get(
      APP_DETAILS_URL,
      query: {
        appids: app_id,
        cc: "ca",
        l: "english"
      },
      timeout: 15
    )

    return nil unless response.success?

    result =
      response
        .parsed_response
        .dig(app_id.to_s)

    return nil unless result&.dig("success")

    result["data"]
  rescue StandardError => error
    puts "Could not retrieve details for #{app_id}: #{error.message}"
    nil
  end

  def build_game(app_id:, data:, category:)
    return nil if data["name"].blank?

    price = extract_price(data)

    return nil if price.nil?

    description =
      data["short_description"].presence ||
      data["detailed_description"].presence ||
      "No description is currently available."

    description =
      ActionView::Base.full_sanitizer
        .sanitize(description)
        .strip

    developer =
      Array(data["developers"])
        .reject(&:blank?)
        .join(", ")
        .presence ||
      "Unknown Developer"

    publisher =
      Array(data["publishers"])
        .reject(&:blank?)
        .join(", ")
        .presence ||
      "Unknown Publisher"

    Game.new(
      steam_app_id: app_id,
      title: data["name"],
      description: description,
      developer: developer,
      publisher: publisher,
      release_date: parse_release_date(data),
      price: price,
      header_image_url: data["header_image"],
      active: true,
      featured: false,
      category: category
    )
  end

  def extract_price(data)
    return BigDecimal("0.00") if data["is_free"]

    price_information = data["price_overview"]

    return nil if price_information.blank?

    cents = price_information["final"].to_i

    BigDecimal(cents.to_s) / 100
  end

  def parse_release_date(data)
    release_date_text =
      data.dig("release_date", "date")

    return nil if release_date_text.blank?

    Date.parse(release_date_text)
  rescue Date::Error
    nil
  end

  def assign_genres(game, data)
    genres =
      Array(data["genres"]).filter_map do |steam_genre|
        genre_name =
          steam_genre["description"].to_s.strip

        next if genre_name.blank?

        Genre.find_or_create_by!(name: genre_name) do |genre|
          genre.description =
            "Genre information imported from Steam."
        end
      end

    game.genres = genres
  end

  def create_bundles(target_bundles:)
    puts "Creating bundles..."

    current_bundle_count =
      Game.where(category: @bundle_category).count

    bundles_needed =
      target_bundles - current_bundle_count

    if bundles_needed <= 0
      puts "Bundle target already reached."
      return
    end

    base_games =
      Game.where(
        category: @base_game_category,
        active: true
      )
        .order(:id)
        .to_a

    if base_games.length < 3
      puts "Not enough base games to create bundles."
      return
    end

    bundles_needed.times do |index|
      bundle_number =
        current_bundle_count + index + 1

      bundle_title =
        "TAG Keys Bundle #{bundle_number}"

      selected_games =
        base_games
          .rotate(index * 3)
          .first(3)

      regular_total =
        selected_games.sum do |game|
          game.current_price.to_d
        end

      bundle_price =
        (regular_total * BigDecimal("0.85")).round(2)

      bundle =
        Game.find_or_initialize_by(
          title: bundle_title,
          category: @bundle_category
        )

      bundle.assign_attributes(
        steam_app_id: nil,
        description:
          "Includes #{selected_games.map(&:title).join(', ')}.",
        developer: "Multiple Developers",
        publisher: "TAG Keys",
        release_date: Date.current,
        price: bundle_price,
        header_image_url:
          selected_games.first.header_image_url,
        active: true,
        featured: false
      )

      bundle.save!

      bundle.genres =
        selected_games
          .flat_map(&:genres)
          .uniq

      puts "Created bundle: #{bundle.title}"
    end
  end

def print_summary
  base_games =
    Game.where(category: @base_game_category).count

  free_games =
    Game.where(category: @free_game_category).count

  dlcs =
    Game.where(category: @dlc_category).count

  bundles =
    Game.where(category: @bundle_category).count

  puts
  puts "Steam import complete."
  puts "Base games: #{base_games}"
  puts "Free-to-Play games: #{free_games}"
  puts "DLCs: #{dlcs}"
  puts "Bundles: #{bundles}"
  puts "Total products: #{Game.count}"
end
end

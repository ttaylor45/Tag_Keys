class GamesController < ApplicationController
def index
  @categories = Category.order(:name)

  @games = Game.includes(:category, :genres)
               .where(active: true)

  if params[:category_id].present?
    @selected_category = Category.find_by(id: params[:category_id])

    if @selected_category
      @games = @games.where(category_id: @selected_category.id)
    end
  end

if params[:query].present?
  @query = params[:query].strip

  @games = @games.where("games.title ILIKE :query OR games.description ILIKE :query",
  query: "%#{Game.sanitize_sql_like(@query)}%")
end

  @games = @games.order(:title)
end

  def show
    @game = Game.includes(:category, :genres)
    .where(active: true)
    .find(params[:id])
  end
end

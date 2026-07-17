class GamesController < ApplicationController
def index
  @categories = Category.order(:name)

  @games = Game.includes(:category, :genres)
               .where(active: true)

  if params[:category_id].present?
    @selected_category = Category.find_by(id: params[:category_id])

    @games = @games.where(category_id: @selected_category.id) if @selected_category
  end

  @games = @games.order(:title)
end

  def show
    @game = Game.includes(:category, :genres)
    .where(active: true)
    .find(params[:id])
  end
end

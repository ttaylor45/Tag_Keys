class GamesController < ApplicationController
  def index
    @games = Game.includes(:category, :genres)
    .where(active: true)
    .order(:title)
  end

  def show
    @game = Game.includes(:category, :genres)
    .where(active: true)
    .find(params[:id])
  end
end

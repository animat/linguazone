class GamesController < ApplicationController
  def create
    game = Game.new(params[:game])
    game.save
  end
end

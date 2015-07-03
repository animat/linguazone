class  Api::V2::AvailableGamesController < ApplicationController
  def index
    @course = Course.find(params[:course_id])
    @ags = @course.available_games.includes(:game => :activity).where(hidden: false).order(:ordering)
    render json: @ags
  end
  def show
    @game = AvailableGame.find(params[:id])
    render json: @game
  end
end

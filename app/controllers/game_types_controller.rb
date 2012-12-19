class GameTypesController < ApplicationController
  def index
    activity  = Activity.find(params[:activity_id])
    @language = Language.find(params[:language_id])
    @game_type = GameType.for(activity)
  end
end

class GameTypesController < ApplicationController
  def index
    activity  = Activity.find(params[:activity_id])
    #@language = Language.find(params[:language_id])
    # TODO: language_id parameter not being passed in
    @language = Language.first
    @game_type = GameType.for(activity)
  end
end

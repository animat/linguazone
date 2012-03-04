class Api::V1::AvailableGamesController < ApplicationController
  
  # TODO: This will only list the courses where the game is active... not sure how to list the courses where the game is inactive
  def search
    if params[:gameid].blank? or params[:userid].blank? or params[:userid].to_i == 0
      render :text => '<?xml version="1.0" encoding="utf-8"?><class classname="You have not created any classes yet" classid="0" />'
    else
      @ags = AvailableGame.where(:user_id => params[:userid], :game_id => params[:gameid])
      respond_to do |format|
        format.xml
      end
    end
  end
  
end

class Api::V1::AvailableGamesController < ApplicationController
  
  def search
    if params[:gameid].blank? or params[:userid].blank? or params[:userid].to_i == 0
      render :text => '<?xml version="1.0" encoding="utf-8"?><class classname="You have not created any classes yet" classid="0" />'
    else
      @available_courses = AvailableGame.where(:game_id => params[:gameid], :user_id => params[:userid]).map{|g| g.course}
      @all_courses = Course.where(:user_id => params[:userid])
    end
  end
  
end

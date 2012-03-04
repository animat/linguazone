class  Api::V1::AudioClipsController < ApplicationController
  def create
    @ac = AudioClip.new
    @ac.user_id = params[:user_id] || 0
    @ac.post_id = params[:post_id] || 0
    @ac.comment_id = params[:comment_id] || 0
    @ac.used_in_games_tally = 0
    @ac.created_at = Time.now
    @ac.updated_at = Time.now
    
    if @ac.save
      render :text => '<?xml version="1.0" encoding="utf-8"?><xml><id>'+String(@ac.id)+'</id></xml>'
    else
      render :text => '<?xml version="1.0" encoding="utf-8"?><xml><id>0</id></xml>'
    end
  end
end

class AudioClipsController < ApplicationController
  
  def index
  end
  
  def next_id
    @new_clip = AudioClip.new
    @new_clip.save
    
    render :text => '<?xml version="1.0" encoding="utf-8" ?><id>'+String(@new_clip.id)+'</id>'
  end
  
  def create
    @clip = AudioClip.new
  end
  
  def destroy
    @clip = AudioClip.find(params[:id])
    @clip.used_in_games_tally -= 1
    @clip.save
  end
  
end

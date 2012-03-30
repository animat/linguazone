class Api::V1::GamesWordListsController < ApplicationController
  
  def search
    @all_convertible_games = Activity.where(:convertable => true)
    if params[:list_id].nil?
      @linked_activity_ids = []
    else
      @linked_activities = GamesWordList.all(:conditions => ["word_list_id = ?", params[:list_id]], :include => :game)
      @linked_activity_ids = @linked_activities.map {|g| g.game.activity.id unless g.game.nil?}
    end
  end
    
end

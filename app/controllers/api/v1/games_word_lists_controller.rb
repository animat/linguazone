class Api::V1::GamesWordListsController < ApplicationController
  
  # TODO: Finish testing API
  def search
    unless params[:list_id].nil?
      @games = GamesWordList.where(:word_list_id => params[:list_id])
    end
    @games ||= []
  end
    
end

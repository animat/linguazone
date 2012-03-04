class Api::V1::GamesWordListsController < ApplicationController
  
  def search
    unless params[:list_id].nil?
      @games = GamesWordList.where(:word_list_id => params[:list_id])
    end

    if @games.nil?
      @games = []
      # TODO: Is this syntax correct?
      # @games ||= []
    end

    respond_to do |format|
      format.xml
    end
  end
    
end

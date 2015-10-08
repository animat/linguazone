class Api::V2::WordListsController < ApplicationController
  def show
    @awl = AvailableWordList.find(params[:id])
    @list = @awl.word_list
    render json: @list
  end
end

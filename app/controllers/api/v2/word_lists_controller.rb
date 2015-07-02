class  Api::V2::WordListsController < ApplicationController
  def index
    @course = Course.find(params[:course_id])
    @awls = @course.available_word_lists.include(:word_list).where(hidden: false).order(:ordering)
    render json: @awls
  end
  def show
    @word_list = AvailableWordList.find(params[:id])
    render json: @word_list
  end
end

class MyWordListsController < ApplicationController
  before_filter :check_expired
  
  def index
    @search = AvailableWordList.search(params[:search])
  end
  
  def show
    @word_list = WordList.find(params[:id])
  end

  def all
    @all_word_lists = WordList.search(:updated_by_id_equals => current_user.id)
    @word_lists = @all_word_lists.all(:order => "updated_at DESC")
    @word_lists = @word_lists.paginate(:page => params[:page])
    @search = AvailableWordList.search(:user_id_equals => 0)
  end
  
  def search
    if params[:search].nil? or params[:search].empty?
      @search = AvailableWordList.search(:user_id_equals => 0)
    else
      if params[:search][:course_id_equals].nil? or params[:search][:course_id_equals] == ""
        params[:search][:course_id_equals] = 0
      else
        @course = Course.find(params['search']['course_id_equals'])
      end
      @search = AvailableWordList.search(params[:search])
      @available_lists, @available_lists_count = @search.all, @search.count
    end    
  end
  
  def destroy
    @word_list = WordList.find(params[:id])
    if @word_list.updated_by_id == current_user.id
      @available_listings = AvailableWordList.all(:conditions => ["word_list_id = ?", params[:id]])
      @available_listings.each do |al|
        al.destroy
      end
      
      @linked_to_games = GameWordList.all(:conditions => ["word_list_id = ?", params[:id]])
      unless @linked_to_games.nil?
        @linked_to_games.each do |lg|
          lg.destroy
        end
      end
      
      @word_list.destroy
    
      flash[:notice] = "The word list has been deleted."
      redirect_to :action => "all"
    else
      flash[:error] = "You do not have access to that word list."
      redirect_to :action => "all"
    end
  end
  
end

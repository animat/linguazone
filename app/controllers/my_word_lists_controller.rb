class MyWordListsController < CourseItemsController
  before_filter :check_expired
  
  def index
    @search = AvailableWordList.search(params[:search])
    
    @word_lists = AvailableWordList.includes(:word_list).where(:user_id => current_user.id, :course_id => 0).order("word_lists.updated_at DESC").page(params[:page])
    @total_word_lists_count = AvailableWordList.where(:user_id => current_user.id, :course_id => 0).length
  end
  
  def show
    @word_list = WordList.find(params[:id])
  end
  
  def destroy
    @word_list = WordList.find(params[:id])
    if @word_list.updated_by_id == current_user.id
      @available_listings = AvailableWordList.all(:conditions => ["word_list_id = ?", params[:id]])
      @available_listings.each do |al|
        al.destroy
      end
      
      @linked_to_games = GamesWordList.all(:conditions => ["word_list_id = ?", params[:id]])
      unless @linked_to_games.nil?
        @linked_to_games.each do |lg|
          lg.destroy
        end
      end
      
      @word_list.destroy
    
      flash[:notice] = "The word list has been deleted."
      redirect_to my_word_lists_path
    else
      flash[:error] = "You do not have access to that word list."
      redirect_to my_word_lists_path
    end
  end
  
  def joining_table
    AvailableWordList
  end
  
end

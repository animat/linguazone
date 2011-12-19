class MyGamesController < ApplicationController
  before_filter :check_expired
  
  def index
    @search = AvailableGame.search(params[:search])
    @all_games = Game.search(:updated_by_id_equals => current_user.id).order(:updated_at).page params[:page]
    @total_games_count = Game.where(:updated_by_id => current_user.id).length
  end
  
  def show
    @game = Game.find(params[:id], :include => ["activity"])
  end
  
  # TODO @Len: Would it be possible to abstract search/ adopt into one piece for games, word lists, and audio posts?
  # =>        Then potentially the same thing for available_games/ word_lists/ posts as a nested resource of courses?
  def adopt
    @search = Game.search(params[:search])
    unless params[:search].nil?
      @games = @search.paginate(:page => params[:page])
    end
  end
    
  def search
    if params[:search].nil? or params[:search].empty?
      @search = AvailableGame.search(:user_id_equals => 0)
    else
      if params[:search][:course_id_equals].nil? or params[:search][:course_id_equals] == ""
        params[:search][:course_id_equals] = 0
      else
        @course = Course.find(params['search']['course_id_equals'])
      end
      @available_games = AvailableGame.search(params[:search]).page(params[:page])
      @available_games_count = @available_games.count
    end    
  end
  
  def destroy
    @game = Game.find(params[:id])
    if @game.updated_by_id == current_user.id
      @available_listings = AvailableGame.all(:conditions => ["game_id = ?", params[:id]])
      @available_listings.each do |al|
        al.destroy
      end
      
      @linked_to_list = GamesWordList.all(:conditions => ["game_id = ?", @game.id])
      @linked_to_list.each do |ltl|
        ltl.destroy unless ltl.nil?
      end
      
      @game.destroy
    
      flash[:notice] = "The game has been deleted."
      redirect_to :action => "all"
    else
      flash[:error] = "You do not have access to that game."
      redirect_to :action => "all"
    end
  end
end

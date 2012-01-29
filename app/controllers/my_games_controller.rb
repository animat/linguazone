class MyGamesController < CourseItemsController
  before_filter :check_expired
  
  def index
    @search = AvailableGame.search(params[:search])
    @hidden_equals_val = ""
    @all_games = AvailableGame.includes(:game).where(:user_id => current_user.id).order("games.updated_at").page(params[:page])
    @total_games = AvailableGame.where(:user_id => current_user.id).length
  end
  
  def show
    @game = Game.find(params[:id], :include => ["activity"])
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
  
  def joining_table
    AvailableGame
  end
end

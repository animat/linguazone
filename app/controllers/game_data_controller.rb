require 'lib/game_data'
class GameDataController < ApplicationController

  #TODO: refactor
  def create

    game = Game.new :created_by => current_user, :updated_by => current_user
    game.activity = Activity.find params[:activity_id]

    game_data = GameData.new()
    params[:nodes].each do |node_hash|
      game_data.add_node(GameData::Node.new node_hash[:question], node_hash[:response])
    end
    #
    # TODO: get real description
    game.description = game.activity.name
    game.language = Language.find params[:language_id]
    game.xml = game_data.to_xml
    game.save!

    #TODO: is this the right thing todo here?
    AvailableGame.create(:user_id => current_user.id, :game => game, :course_id => 0)
    head :no_content
  end

  def show
   @game = Game.find params[:id]
   render :json => @game.to_json
  end
end

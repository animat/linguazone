require 'lib/game_data'
class GameDataController < ApplicationController

  #TODO: refactor
  def create

    game = Game.new :created_by => current_user, :updated_by => current_user
    game.activity = Activity.find params[:activity_id]

    # TODO: get real description
    game.description = game.activity.name
    game.language = Language.find params[:language_id]
    game.save!

    game_data = GameData.new()
    params[:nodes].each do |node_hash|
      game_data.add_node(GameData::Node.new node_hash[:question], node_hash[:response])
    end

    template = Template.new
    template.game = game
    template.activity = game.activity
    template.xml = game_data.to_xml
    template.save!


    #TODO: is this the right thing todo here?
    AvailableGame.create(:user_id => current_user.id, :game => game, :course_id => 0)
    head :no_content
  end
end

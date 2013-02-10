require 'lib/game_data'
require 'lib/template_data'

class GameDataController < ApplicationController
  def update
    @game = Game.find params[:id]
    @game_data = get_game_data(@game)
    @game.xml = @game_data.to_xml
    @game.save!
  end

  #TODO: refactor
  def create
    game = Game.new :created_by => current_user, :updated_by => current_user
    game.activity = Activity.find params[:activity_id]

    game_data = get_game_data(game)

    # TODO: get real description
    game.description = game.activity.name

    # TODO: the language id was not being passed along by the customizer; @CA hardcoded in the language ID for now
    #game.language = Language.find params[:language_id]
    game.language = Language.find(2)
    game.template = Template.create(:activity => game.activity, :language_id => game.language,
                              :description => "", :name => "", :admin => 0, :user_id => game.updated_by,
                              :xml => game_data.template_data_xml)
    game.xml = game_data.to_xml
    game.save!

    #TODO: is this the right thing todo here?
    AvailableGame.create(:user_id => current_user.id, :game => game, :course_id => 0)
    head :no_content
  end

  def show
   @game = Game.find params[:id]
   render :json => @game.game_data.to_json
  end

  private

    def get_game_data(game)
      game_data = GameData.new(game.game_type)
      params[:nodes].each do |node_hash|
        game_data.add_node(game_data.node_constant.from_hash node_hash)
      end
      add_word_lists_to(game_data)
      game_data
    end

    def add_word_lists_to(game_data)
      return unless params[:word_list]
      params[:word_list].each do |list|
        list.keys.each do |key|
          list[key].each do |word|
            game_data.add_word(key, word)
          end
        end
      end
    end
end

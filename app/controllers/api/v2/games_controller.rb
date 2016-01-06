class  Api::V2::GamesController < ApplicationController
  def show
    @ag = AvailableGame.find(params[:id])
    @game = Game.find(@ag.game_id, :include => [:activity, :template, :language])
    doc = REXML::Document.new(@game.xml)
    @nodes = REXML::XPath.match(doc, "/gamedata/node")
    @nodes.shuffle!
    @nodes = "<gamedata>"+@nodes.join(" ")+"</gamedata>"
  end
end

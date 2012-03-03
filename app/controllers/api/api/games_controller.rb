class Api::GamesController < ApplicationController
  
  def show
    @game = Game.find(params[:id], :include => [:activity, :template, :language])
    # TODO @Len: Do I need a respond to in order to use the .xml.builder view?
    respond_to do |format|
      format.xml
    end
  end
  
  def create
    @game = Game.new params[:game]

    if @game.save
      render :xml => @game.to_xml
    else
      render :xml => @game.errors.to_xml, :status => :unprocessable_entity
    end
  end

  def update
    @game = Game.find params[:id]

    if @game.update_attributes params[:game]
      render :xml => @game.to_xml
    else
      render :xml => @game.errors.to_xml, :status => :unprocessable_entity
    end
  end
end

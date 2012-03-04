class Api::V1::GamesController < ApplicationController
  
  def show
    @game = Game.find(params[:id], :include => [:activity, :template, :language])
    # TODO @Len: Do I need a respond to in order to use the .xml.builder view?
    respond_to do |format|
      format.xml
    end
  end
  
  def create
    
    @template = Template.new(:activity_id => params[:gameinfoid], :language_id => params[:languageid])
    @template.user_id = params[:userid]
    
    #@template.save
    
    @game = Game.new(:template_id => @template.id, :xml => params[:gamedatabranch], :description => params[:descriptext],
              :activity_id => params[:gameinfoid], :language_id => params[:languageid],
              :created_at => Time.now, :updated_at => Time.now,
              :created_by_id => params[:userid], :updated_by_id => params[:userid])
    
    #update available classes
    
    render :text => '<?xml version="1.0" encoding="utf-8"?><msg>1500</msg>'
    
    #if @game.save
    #  render :xml => @game.to_xml
    #else
    #  render :xml => @game.errors.to_xml, :status => :unprocessable_entity
    #end
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

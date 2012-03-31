class CourseItemsController < ApplicationController
  
  # TODO: Adopt any kind of course item.
  # => Update the language of choice to the user's default language, if it exists
  def copy_item
    @game = Game.find(params[:id])
    @template = Template.find(@game.template_id)
    @new_template = Template.new(:xml => @template.xml, :name => @template.name, :description => @template.description, :admin => @template.admin, :activity_id => @template.activity_id, :language_id => @template.language_id, :user_id => current_user.id, :created_at => @template.created_at, :updated_at => Time.now)
    unless params[:language_id].nil?
      @new_template.language_id = params[:language_id]
    end
    @new_template.save
    @new_game = Game.new(:xml => @game.xml, :description => @game.description, :audio_ids => @game.audio_ids, :template_id => @new_template.id, :language_id => @game.language_id, :activity_id => @game.activity_id, :created_by_id => @game.created_by_id, :updated_by_id => current_user.id, :created_at => @game.created_at, :updated_at => Time.now)
    unless params[:language_id].nil?
      @new_game.language_id = params[:language_id]
      @new_game.description = "My first LinguaZone game"
    end
    @new_game.save
    
    flash[:notice] = "This game has been added to your account.<br />Make changes and save to your class pages.".html_safe
    redirect_to :controller => "customize", :action => "edit", :cmzr_type => "game", :id => @new_game.id
  end
  
  def adopt
    @search = joining_table.search(params[:search])
    @search_type = "adopt"
  end
  
  def search
    if params[:search].nil?
      redirect_to :action => :index
    else
      @search = joining_table.search(params[:search])
      @course = Course.find(params[:search][:course_id_equals]) unless params[:search][:course_id_equals].blank?
      @available_items = joining_table.search(params[:search]).page(params[:page])
      @available_items_count = joining_table.search(params[:search]).length
      
      @hidden_equals_val = params[:search][:hidden_equals]
      
      @search_type = "default"
      @search_type = "hidden" if @course && params[:search][:hidden_equals].to_i == 1
      if joining_table == AvailableGame
        @search_type = "adopt" if params[:search][:game_updated_by_id_does_not_equal]
      elsif joining_table == AvailableWordList
        @search_type = "adopt" if params[:search][:word_list_updated_by_id_does_not_equal]
      end
    end
  end
  
  #def hide_item
  
  #def show_item
    
end
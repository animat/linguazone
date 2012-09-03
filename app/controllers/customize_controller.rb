class CustomizeController < ApplicationController
  def new
    if current_user.nil?
      flash[:error] = "You need to login before accessing that page"
      redirect_to teachers_login_path
    else
      @lang_id = current_user.default_language_id
      if @lang_id == 0 or @lang_id.nil?
        @lang_id = params[:language]
      end
    
      if @lang_id.nil? or @lang_id == 0
        redirect_to :action => "select_language", :cmzr_type => params[:cmzr_type]
      else
        @language = Language.find(@lang_id)
        @embed_vars = "userid="+String(current_user.id)+"&gamelanguage="+@language.name+"&cmzrtype="+params[:cmzr_type]+"&path=../../../"
      end
    end
  end
  
  def create
  end
  
  def edit
    if current_user.nil?
      flash[:error] = "You need to login before accessing that page"
      redirect_to login_teachers_path
    else
      if params[:cmzr_type] == "game"
        @ag = AvailableGame.find(params[:id])
        # TODO: Add administrative options... this is a hack!
        if current_user.id == @ag.user_id or current_user.id == 30
          @embed_vars = "gameid="+params[:id]+"&userid="+String(current_user.id)+"&cmzrtype="+params[:cmzr_type]+"&path=../../../"
        else
          flash[:error] = "You do not have permission to edit that game"
          redirect_to teachers_path and return
        end
      elsif params[:cmzr_type] == "list"
        @awl = AvailableWordList.find(params[:id])
        # TODO: Add administrative options... this is a hack!
        if current_user.id == @awl.user_id or current_user.id == 30
          @embed_vars = "listid="+params[:id]+"&userid="+String(current_user.id)+"&cmzrtype="+params[:cmzr_type]+"&path=../../../"
        else
          flash[:error] = "You do not have permission to edit that word list"
          redirect_to teachers_path and return
        end
      end
    end
  end

  def delete
  end

  def adopt
    @game = Game.find(params[:id])
    @template = Template.find(@game.template_id)
    
    @new_template = Template.new(:xml => @template.xml, :name => @template.name, :description => @template.description, :admin => @template.admin, :activity_id => @template.activity_id, :language_id => @template.language_id, :user_id => current_user.id)
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
    
    # TODO: CREATE ARRAY OF AUDIO IDS
    # ITERATE THROUGH EACH, ADD TO TALLY IN AUDIO_CLIPS TABLE
    
    flash[:success] = "This game has been added to your account.<br />Make changes and save to your class pages.".html_safe
    redirect_to :controller => "customize", :action => "edit", :cmzr_type => "game", :id => @new_game.id
  end

  def inspect
  end
  
  def select_language
    @languages = Language.all(:order => "name")
    @cmzr_type = params[:cmzr_type]
  end

end

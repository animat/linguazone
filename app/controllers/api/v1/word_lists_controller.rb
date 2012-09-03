class Api::V1::WordListsController < ApplicationController
  def show
    if params[:action] == "edit"
      @word_list = WordList.find(params[:id], :include => [:activity, :template, :language])
    else
      @awl = AvailableWordList.find(params[:id])
      @word_list = WordList.find(@awl.word_list_id, :include => :language)
    end
  end
  
  def create
    unless current_user.nil?
      @word_list = WordList.create!(:xml => params[:gamedatabranch], :description => params[:descriptext], :language_id => params[:languageid],
                :created_at => Time.now, :updated_at => Time.now,
                :created_by_id => params[:userid], :updated_by_id => params[:userid])
      AvailableWordList.create!(:word_list_id => @word_list.id, :user_id => current_user.id, :course_id => 0, :order => 0, :hidden => 0)
      update_classes(@word_list.id, params[:userid], params[:classes])
      update_linked_games(@word_list.id, params[:gamedatabranch], params[:descriptext], params[:activatenewgames], 
                            params[:languageid], params[:userid], params[:classes])
    
      render :text => '<?xml version="1.0" encoding="utf-8"?><msg>'+String(@word_list.id)+'</msg>'
    end
  end

  def update
    @word_list = WordList.find(params[:id])
    @word_list.xml = params[:gamedatabranch]
    @word_list.description = params[:descriptext]
    @word_list.updated_at = Time.now
    
    update_classes(params[:id], params[:userid], params[:classes])
    update_linked_games(params[:id], params[:gamedatabranch], params[:descriptext], params[:activatenewgames], 
                          @word_list.language_id, params[:userid], params[:classes])
    
    if @word_list.save
      render :text => '<?xml version="1.0" encoding="utf-8"?><msg>'+String(@word_list.id)+'</msg>'
    else
      render :xml => @word_list.errors.to_xml, :status => :unprocessable_entity
    end
  end
  
  private
    def update_classes(list_id, user_id, active_classes_string)
      classes_array = active_classes_string.split("_").map {|n| n.to_i}
      @ags = AvailableWordList.all(:conditions => ["word_list_id = ? AND user_id = ? AND course_id != ?", list_id, user_id, 0])
      @ag_course_ids = @ags.map { |ag| ag.course_id.to_i }
      
      # Destroy any old AGs that should no longer be available
      @ags.each do |ag|
        unless classes_array.include?(ag.course_id)
          ag.destroy
        end
      end
      # Create any new AGs that do not yet exist (not making any new items for course 0)
      classes_array.each do |c|
        unless @ag_course_ids.include?(c)
          unless c == 0
            AvailableWordList.create!(:word_list_id => list_id, :user_id => user_id, :course_id => c, :order => 0, :hidden => 0)
          end
        end
      end
    end
    
    def update_classes_for_linked_game(game_id, user_id, active_classes_string)
      classes_array = active_classes_string.split("_").map {|n| n.to_i}
      @ags = AvailableGame.all(:conditions => ["game_id = ? AND user_id = ? AND course_id != ?", game_id, user_id, 0])
      @ag_course_ids = @ags.map { |ag| ag.course_id.to_i }
      
      # Destroy any old AGs that should no longer be available
      @ags.each do |ag|
        unless classes_array.include?(ag.course_id)
          ag.destroy
        end
      end
      # Create any new AGs that do not yet exist
      classes_array.each do |c|
        unless @ag_course_ids.include?(c)
          unless c == 0
            AvailableGame.create!(:game_id => game_id, :user_id => user_id, :course_id => c, :ordering => 0, :hidden => 0)
          end
        end
      end
    end
    
    def create_linked_game(new_xml, descr, act, lang, uid, cls)
      @template = Template.create(:activity_id => act, :language_id => lang, :xml => "<templatedata></templatedata>",
                                :description => "", :name => "", :admin => 0, :user_id => uid)
      @game = Game.create(:template_id => @template.id, :xml => new_xml, :description => descr,
                :audio_ids => "",
                :activity_id => act, :language_id => lang,
                :created_at => Time.now, :updated_at => Time.now,
                :created_by_id => uid, :updated_by_id => uid)
      AvailableGame.create(:game_id => @game.id, :user_id => uid, :course_id => 0, :ordering => 0, :hidden => 0)
      update_classes_for_linked_game(@game.id, uid, cls)
      @game.id
    end
    
    def modify_linked_game(id, x, d)
      @g = Game.all(:conditions => {:id => id}).first
      if @g.nil?
        
      else
        @g.xml = x
        @g.description = d
        @g.updated_at = Time.now
        @g.save
      end
    end
    
    def update_linked_games(list_id, updated_xml, descrip, new_activity_ids, lang_id, user_id, cls)
      @wl_games_linker = GamesWordList.all(:conditions => ["word_list_id = ?", list_id])
      @wl_games_linker.each do |wlg|
        modify_linked_game(wlg.game_id, updated_xml, descrip)
      end
      @activity_ids = new_activity_ids.split("_").map {|s| s.to_i}
      @activity_ids.each do |a|
        unless a == 0
          @new_game_id = create_linked_game(updated_xml, descrip, a, lang_id, user_id, cls)
          GamesWordList.create(:game_id => @new_game_id, :word_list_id => list_id)
        end
      end
    end
end

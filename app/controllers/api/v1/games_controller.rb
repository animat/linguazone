class Api::V1::GamesController < ApplicationController
  def show
    @game = Game.find(params[:id], :include => [:activity, :template, :language])
  end
  
  # TODO: This is used by LZContainer.fla. This should eventually be subsumed by show action.
  def info
    @game = Game.find(params[:id], :include => [:activity, :template, :language])
  end
  
  def create
    @template = Template.new(:activity_id => params[:gameinfoid], :language_id => params[:languageid], 
                              :description => "", :name => "", :admin => 0, :user_id => params[:userid],
                              :xml => params[:templatebranch])
    @template.save
    @game = Game.new(:template_id => @template.id, :xml => params[:gamedatabranch], :description => params[:descriptext],
              :audio_ids => params[:activeaudiofiles],
              :activity_id => params[:gameinfoid], :language_id => params[:languageid],
              :created_at => Time.now, :updated_at => Time.now,
              :created_by_id => params[:userid], :updated_by_id => params[:userid])
    @game.save
    update_classes(@game.id, params[:userid], params[:classes])
    
    render :text => '<?xml version="1.0" encoding="utf-8"?><msg>'+String(@game.id)+'</msg>'
  end

  def update
    @game = Game.find params[:id]
    @game.xml = params[:gamedatabranch]
    @game.description = params[:descriptext]
    @game.audio_ids = params[:activeaudiofiles]
    @game.updated_at = Time.now
    @game.save
    
    # Update any changes to the XML of the template
    @t = Template.find(@game.template_id)
    @t.xml = params[:templatebranch]
    @t.save
    
    # Update which classes have this game available
    update_classes(params[:id], params[:userid], params[:classes])
    
    render :text => '<?xml version="1.0" encoding="utf-8"?><msg>'+String(@game.id)+'</msg>'
  end
  
  private
    def update_classes(game_id, user_id, active_classes_string)
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
          AvailableGame.create!(:game_id => game_id, :user_id => user_id, :course_id => c, :ordering => 0, :hidden => 0)
        end
      end
    end
end

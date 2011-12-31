class MediaController < ApplicationController
  
  def index
    @to_dos = Media.all(:conditions => "published = 0", :order => "id DESC", :include => "media_keywords")
    @assets = Media.all(:conditions => "published = 1", :order => "id DESC", :include => "media_keywords")
    @assets = @assets.page(params[:page])
    @user_session = UserSession.new
  end
  
  def new
    unless current_user.nil?
      if current_user.id == 30 || current_user.id == 31
        @asset = Media.new
      else
        redirect_to :action => "index"
      end
    else 
      redirect_to :action => "index"
    end
  end
  
  def create
    @asset = Media.new(params[:media])
    if @asset.save
      flash[:notice] = "Added your media item"
      redirect_to :action => "index"
    else
      flash[:notice] = "There was an error creating your media item"
      render :action => "edit"
    end
  end
  
  def show
    @asset = Media.find(params[:id])
  end
  
  def edit
    if current_user.nil?
      redirect_to :action => "index"
    end
    @asset = Media.find(params[:id])
  end
  
  
  def update
    @asset = Media.find(params[:id])
    respond_to do |format|
      if @asset.update_attributes(params[:media])
        if params[:media][:notes] != nil and params[:media][:notes] != ""
          if params[:media][:assigned_to] == "Francis"
            @email_addr = "'Francis Boncales' <fboncale@g.risd.edu>"
          elsif params[:media][:assigned_to] == "Orissa"
            @email_addr = "'Orissa Jenkins' <ojenkins@g.risd.edu>"
          elsif params[:media][:assigned_to] == "Chris"
            @email_addr = "'Chris Cyr' <cjcyr@charter.net>"
          else
            @email_addr = "'Colin Angevine' <colinangevine@gmail.com>"
          end
          ContactMailer.deliver_updated_media_notify_artist(@email_addr, @asset.id, @asset.descrip, @asset.assigned_to, @asset.notes)
          flash[:notice] = "Sent an email to "+@email_addr+" about the new note."
        elsif params[:media][:swf] != nil or params[:media][:fla] != nil
          ContactMailer.deliver_updated_media_notify_admin(params[:media], @asset.descrip, @asset.notes, @asset.id)
          flash[:notice] = "Saved your artwork and notified admins."
        else
          flash[:notice] = 'Media item was successfully updated.'
        end
        format.html { redirect_to(:controller => "media", :action => "index") }
      else
        format.html { render :action => "edit" }
      end
    end
  end
    
  def delete
    @asset = Media.find(params[:id])
    @asset.destroy
    redirect_to :action => "index"
  end
  
end

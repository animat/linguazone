class  Api::V1::MediasController < ApplicationController
  def search
    unless params[:cat].nil?
      @medias = Media.search(:media_category_name_like => params[:cat])
    end
    unless params[:find].nil?
      # TODO: This can return duplicates because of media keywords... needs to select unique media ID
      @medias = Media.search(:descrip_or_media_keywords_name_like => params[:find])
    end
    
    if @medias.nil?
      @medias = []
    end
    
    respond_to do |format|
      format.xml
    end
  end
  
  def index
    @medias = Media.all
    respond_to do |format|
      format.xml
    end
  end
end

class  Api::V1::CoursesController < ApplicationController
  def search
    unless params[:userid].nil?
      @medias = Course.search(:user_id_equals => params[:userid])
    end
    
    if @medias.nil?
      @medias = []
    end
    
    respond_to do |format|
      format.xml
    end
  end
  
  def index
    @courses = Course.all
    respond_to do |format|
      format.xml
    end
  end
end

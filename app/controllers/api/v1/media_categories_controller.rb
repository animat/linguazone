class  Api::V1::MediaCategoriesController < ApplicationController
  respond_to :xml
  
  def index
    #@media_categories = MediaCategory.active #TODO: This query does not work on postgres
    @media_categories = MediaCategory.all
    # TODO @Len: Isn't there a better way to force an XML response on the index?
    render :template => "api/v1/media_categories/index.xml.builder", :layout => false
  end
end

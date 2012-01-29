class  Api::MediaCategoriesController < ApplicationController
  def index
    @media_categories = MediaCategory.active
    render :xml => @media_categories.to_xml
  end
end

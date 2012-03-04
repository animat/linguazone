class  Api::V1::MediaCategoriesController < ApplicationController
  def index
    @media_categories = MediaCategory.active
    respond_to do |format|
      format.xml
    end
  end
end

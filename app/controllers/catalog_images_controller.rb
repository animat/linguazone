class CatalogImagesController < ApplicationController
  def index
    query = params[:q]
    images = CatalogImage.find_by_name(query)
    render :json => images.to_json
  end
end

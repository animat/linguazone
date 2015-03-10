require './lib/flickr_search'

class FlickrPhotosController < ApplicationController
  def index
    render :json => FlickrSearch.search(params[:q].to_json).map{ |photo| {
      :url           => photo.url,
      :photo_url     => photo.photo_url,
      :title         => photo.title,
      :thumbnail_url => photo.square_url } }.to_json
  end
end

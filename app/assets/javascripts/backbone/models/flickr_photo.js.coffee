class Linguazone.Models.FlickrPhoto extends Backbone.Model
  url: "/flickr_photos"

class Linguazone.Models.FlickrPhotoCollection extends Backbone.Collection
  url: "/flickr_photos"

  model: Linguazone.Models.FlickrPhoto

  initialize: (term) -> @url = "#{@url}?q=#{term}"

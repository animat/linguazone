class Linguazone.Models.FlickrPhoto extends Backbone.Model
  url: "/flickr_photos"

class Linguazone.Models.FlickrPhotoCollection extends Backbone.Collection
  url: "/flickr_photos"

  model: Linguazone.Models.FlickrPhoto

  initialize: (term) -> @url = "#{@url}?q=#{term}"

class Linguazone.Models.CatalogPhoto extends Backbone.Model
  url: "/catalog_images"

class Linguazone.Models.CatalogPhotoCollection extends Backbone.Collection
  url: "/catalog_images"

  model: Linguazone.Models.CatalogPhoto

  initialize: (term) -> @url = "#{@url}?q=#{term}"

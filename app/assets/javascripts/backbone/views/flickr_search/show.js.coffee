Linguazone.Views.FlickrSearch ||= {}

class Linguazone.Views.FlickrSearch.Show extends Backbone.Marionette.ItemView
  template: """
    <h2>Search for Images</h2>
    <input class="search"/>
    <button type="submit">Go</button>
    <div class="results"></div>
"""
  events:
    "click button" : "loadResults"

  class: "flickr-search"

  render: =>
    attributes = @model.attributes
    attributes or= @model
    html = _.template(@template)(attributes)
    @$el.html(html)
    @

  select: (photo) =>
    @trigger("select", photo.get("photo_url"))

  loadResults: =>
    query = @$el.find("input").val()
    @$results ||= @$el.find(".results")
    @$results.html("<img src='/assets/spinner.gif' alt='loading' title='loading' class='spinner'/>")
    @loadFlickrResults(query)
    @loadMediaResults(query)

  loadMediaResults: (query) =>
    photos = new Linguazone.Models.FlickrPhotoCollection(query)
    photos.url = "/media/images?q=#{query}"
    photos.fetch().success =>
      @$results.find(".spinner").remove()
      @$results.append("<hr/>")
      @$results.append("<h1>LinguaZone Results</h1>")
      _.each photos.models, (photo) =>
        photo.on("select", => @select(photo))
        view = new Linguazone.Views.FlickrImage model: photo
        @$results.append view.render().el

  loadFlickrResults: (query) =>
    photos = new Linguazone.Models.FlickrPhotoCollection(query)
    photos.fetch().success =>
      @$results.find(".spinner").remove()
      @$results.append("<hr/>")
      @$results.append("<h1>Flickr Results</h1>")
      _.each photos.models, (photo) =>
        photo.on("select", => @select(photo))
        view = new Linguazone.Views.FlickrImage model: photo
        @$results.append view.render().el

class Linguazone.Views.FlickrImage extends Backbone.Marionette.ItemView
  template: """
  <div class="small-thumb">
    <img src="<%= thumbnail_url %>" alt="<%= title %>" title="<%= title %>"/>
  </div>
"""

  events:
    "click img" : "select"

  select: =>
    @model.trigger("select")

  render: =>
    html = _.template(@template)(@model.toJSON())
    @$el.html(html)
    @

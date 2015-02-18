class Linguazone.Collections.ClassCollection extends Backbone.Collection
  #TODO: make this dynamic, add in userid
  url: 'http://localhost:3000/api/v1/available_games/search.xml?userid=30&type=game&gameid=0'

  parse: (data) ->
    parsed = []
    $(data).find("class").each (index) ->
      n = $(this).attr("classname")
      i = $(this).attr("classid")
      a = $(this).attr("classactive")
      x = {name: n, id: i, active: a}
      parsed.push(x)
      return
    return parsed

  fetch: (options) ->
    options = options or {}
    options.dataType = "xml"
    Backbone.Collection::fetch.call this, options

class Linguazone.Views.ClassCollectionView extends Backbone.View
  initialize: ->
    this.render()
    #_.bindAll this, "render"
    #this.collection.on("reset sync add remove", this.render);
    #@listenTo @collection, "reset sync add remove", @render

  render: ->
    if @collection.length == 0
      # TODO @Len: For some reason @$el is not retaining the jQuery selector. Hardcoding it below.
      #             Also, sometimes this view is being rendered twice
      $("#classes_metadata").append("<label><input type='checkbox' name='0' disabled/> You have not yet created any classes</label>")
    else
      i = 0
      while i < @collection.length
        id = @collection.models[i].attributes.id
        n = @collection.models[i].attributes.name
        a = (@collection.models[i].attributes.active == "true") ? "checked" : ""
        $("#classes_metadata").append("<label><input type='checkbox' name='"+id+"' "+a+"/> "+n+"</label>")
        i++

  template: """
    <form></form>
    """

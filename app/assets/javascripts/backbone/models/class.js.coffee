class Linguazone.Collections.ClassCollection extends Backbone.Collection
  model: Linguazone.Models.Class
  #TODO: make this dynamic, add in userid
  url: 'http://localhost:3000/api/v1/available_games/search.xml?userid=30&type=game&gameid=0'
  initialize: ->
    console.log("class collection init")

  parse: (data) ->
    parsed = []
    $(data).find("class").each (index) ->
      console.log($(this).attr("classname"))
      parsed.push 
        name: $(this).attr("classname")
        id: $(this).attr("classid")
        active: $(this).attr("classactive")
      return

    parsed

  fetch: (options) ->
    options = options or {}
    options.dataType = "xml"
    Backbone.Collection::fetch.call this, options

class Linguazone.Views.ClassCollectionView extends Backbone.View
  initialize: ->
    _.bindAll this, "render"
    
    #this.collection.on("reset sync add remove", this.render);
    @listenTo @collection, "reset sync add remove", @render
    return

  render: ->
    console.log @collection.toJSON()
    return

 ### template: """
    <form>


    </form>
    """
###
class Linguazone.Collections.ClassCollection extends Backbone.Collection
  #TODO: make this dynamic, add in userid
  url: 'http://localhost:3000/api/v1/available_games/search.xml?userid=30&type=game&gameid=0'
  initialize: ->
    #console.log("class collection init")

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
    console.log("init Class Collection View")
    this.render()
    #_.bindAll this, "render"
    
    #this.collection.on("reset sync add remove", this.render);
    #@listenTo @collection, "reset sync add remove", @render
    return

  render: ->
    console.log('console loggin collection')
    console.log(@collection)
    i = 0
    while i < @collection.length
      console.log(@$el)
      @$el.append("<input type='checkbox' name='"+@collection.models[i].name+"'/>"+@collection.models[i].name)
      i++
    return
  
  template: """
    <form>


    </form>
    """
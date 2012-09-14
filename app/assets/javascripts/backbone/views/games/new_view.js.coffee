Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NewView extends Backbone.View
  template: JST["backbone/templates/games/new"]
  events:
    "submit #new-game": "save"
    "click .addNode": "addNode"

  constructor: (options) ->
    @model ||= new Linguazone.Models.Game
      activity_id: options.activity_id
      language_id: options.language_id
    super(options)
    @model.bind "change:errors", @render

  createNode: =>
    @model.get("nodes").add(new Linguazone.Models.Node )

  addNode: (e) =>
    e.preventDefault()
    @createNode()
    @render()

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.save()
    @$el.find("form").hide()
    @$el.find("#confirmation").show()
    return

  render: =>
    html = @template(@model.toJSON() )
    $(@el).html html
    $nodeDiv = $(@el).find("#nodes")
    $nodeDiv.html("")
    _.each @model.get("nodes").models, (node) ->
      view = new Linguazone.Views.Games.NodeView
        node: node
      $nodeDiv.append(view.render().el)
    @

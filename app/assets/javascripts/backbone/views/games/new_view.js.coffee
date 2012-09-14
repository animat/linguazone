Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NewView extends Backbone.View
  template: JST["backbone/templates/games/new"]
  nodes: []
  events:
    "submit #new-game": "save"
    "click .addNode": "addNode"

  constructor: (options) ->
    super(options)
    @model = new Linguazone.Models.Game
    @createNode()
    @model.bind "change:errors", @render

  createNode: ->
    @nodes.push(new Linguazone.Views.Games.NodeView)

  addNode: (e) =>
    e.preventDefault()
    @createNode()
    @render()

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
    alert("soon")
    return

  render: =>
    html = @template(@model.toJSON() )
    $(@el).html html
    nodeDiv = $(@el).find("#nodes")
    _.each @nodes, (node) ->
      nodeDiv.append(node.render().el)
    @

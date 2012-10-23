Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.GameFormBaseView extends Backbone.View
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

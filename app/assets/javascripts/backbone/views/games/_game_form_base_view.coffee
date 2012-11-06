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

  render: =>
    html = @template(@model.toJSON() )
    $(@el).html html
    $nodeDiv = $(@el).find("#nodes")
    $nodeDiv.html("")

    _.each @model.get("nodes").models, (node) =>
      view = new Linguazone.Views.Games[@model.get("game_type")]
        node: node
      view.on "remove", =>
        @model.get("nodes").remove(node)
      $nodeDiv.append(view.render().el)
    @

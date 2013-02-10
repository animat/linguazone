Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.GameFormBaseView extends Backbone.View
  createNode: =>
    @model.get("nodes").add(new Linguazone.Models["#{@model.get("game_type")}Node"] )

  addNode: (e) =>
    e.preventDefault()
    @createNode()
    @render()

  save: (e) ->
    $errors = @$el.find(".errors")
    $errors.hide()
    e.preventDefault()
    e.stopPropagation()
    _.each @model.get("nodes").models, (node) =>
      $errors.html(node.validation_errors()).show() if node.validation_errors()
    return if @$el.find(".errors:visible").length

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

Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.GameFormBaseView extends Backbone.Marionette.ItemView
  className: "game-form backbone"

  createNode: =>
    node = new Linguazone.Models["#{@model.get("game_type")}Node"]
    @model.get("nodes").add node
    return node

  addNode: (e) =>
    e.preventDefault()
    @addNodeView @createNode(), @model.get("nodes").length - 1 # 0 index

  ui:
    form: "form"
    confirmation: "#confirmation"
    metadata: "#metadata"


  save: (e) ->
    @setOptionLists()
    e.preventDefault()

    $errors = @$el.find(".errors")
    $errors.hide()

    _.each @model.get("nodes").models, (node) =>
      $errors.html(node.validation_errors()).show() if node.validation_errors()
    return if @$el.find(".errors:visible").length

    @model.save()
    @ui.form.hide()
    @ui.confirmation.show()

  metadataStep: (e) ->
    e.preventDefault()
    @ui.form.hide()
    @ui.metadata.show()

  #TODO: get this out of the view
  setOptionLists: => @model.set("option_list", Linguazone.OptionLists())

  onRender: =>
    @$nodeDiv = $(@el).find("#nodes")
    @$nodeDiv.html("")
    _.each @model.get("nodes").models, @addNodeView

  addNodeView: (node, index) =>
    console.log(Linguazone.Models)
    view = new Linguazone.Views.Games[@model.get("game_type")]
      node_options: @options.options
      node: node

    view.$el.addClass("node-#{index}")

    view.on "remove", => @model.get("nodes").remove(node)
    @$nodeDiv.append(view.render().el)

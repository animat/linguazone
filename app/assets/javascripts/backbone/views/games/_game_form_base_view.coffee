Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.GameFormBaseView extends Backbone.Marionette.ItemView
  className: "game-form backbone"

  createNode: =>
    node = new Linguazone.Models["#{@model.get("game_type")}Node"]
    @model.get("nodes").add node
    return node

  addNode: (e) =>
    e?.preventDefault?()
    @addNodeView @createNode(), @model.get("nodes").length - 1 # 0 index
    $(".node").last().find("input").first().focus()

  ui:
    form: "form"
    nodes: "#nodes"
    addButton: ".addNode"
    nextButton: "#metadata-step"
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

    @model.save().success =>
      @trigger "save"
    @ui.nodes.hide()

    @ui.confirmation.show()

  questionsStep: (e) ->
    e.preventDefault()
    $("#step_title").html("Step 2: Customize your game")
    e.preventDefault()
    @ui.metadata.hide()
    @ui.form.show()
    @ui.nodes.show()
    @ui.nextButton.show()

  metadataStep: (e) ->
    e.preventDefault()
    # TODO Toggle in a summary view. e.g. Number of nodes, other relevant info
    @ui.nodes.hide()
    @ui.addButton.hide()
    @ui.nextButton.hide()
    @ui.metadata.show()

  #TODO: get this out of the view
  setOptionLists: => @model.set("option_list", Linguazone.OptionLists())

  onRender: ->
    $("#step_title").html("Step 2: Customize your game")
    @$nodeDiv = $(@el).find("#nodes")
    @$nodeDiv.html("")
    _.each @model.get("nodes").models, @addNodeView

  initialize: ->
    Linguazone.App.vent.on "node:new", =>
      @addNode()

  addNodeView: (node, index) =>
    view = new Linguazone.Views.Games[@model.get("game_type")]
      node_options: @options.options
      node: node

    view.$el.addClass("node-#{index}")

    view.on "remove", => @model.get("nodes").remove(node)
    @$nodeDiv.append(view.render().el)

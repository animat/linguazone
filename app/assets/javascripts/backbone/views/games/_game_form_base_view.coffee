Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.GameFormBaseView extends Backbone.Marionette.ItemView
  createNode: =>
    @model.get("nodes").add(new Linguazone.Models["#{@model.get("game_type")}Node"] )

  addNode: (e) =>
    e.preventDefault()
    @createNode()
    @render()

  ui:
    form: "form"
    confirmation: "#confirmation"

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

  #TODO: get this out of the view
  setOptionLists: => @model.set("word_list", Linguazone.OptionLists())

  onRender: =>
    $nodeDiv = $(@el).find("#nodes")
    $nodeDiv.html("")
    _.each @model.get("nodes").models, (node) =>
      view = new Linguazone.Views.Games[@model.get("game_type")]
        node: node
      view.on "remove", =>
        @model.get("nodes").remove(node)
      $nodeDiv.append(view.render().el)

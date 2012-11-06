Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NodeBaseView extends Backbone.View
  events:
    "change input" : "updateModel",
    "click .delete" : "delete",

  delete: =>
    @trigger("remove")
    @$el.remove()
    @options.node = undefined

  updateModel: (e) =>
    @options.node.set
      question: @getQuestion(),
      response: @getResponse()

  getQuestion: ->
    @$el.find(".question input").val()

  getResponse: ->
    @$el.find(".response input").val()

  render: ->
    @options.node ||= new Linguazone.Models.Node
    @$el.html _.template(@template, @options.node.attributes)
    @


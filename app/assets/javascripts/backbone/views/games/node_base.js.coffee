Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NodeBaseView extends Backbone.Marionette.ItemView
  className: "node backbone"

  events:
    "click .delete"         : "delete",
    "focus .question input" : "highlightQuestion"
    "blur .question input"  : "dimQuestion"
    "focus .response input" : "highlightResponse"
    "blur .response input"  : "dimResponse"

  highlightQuestion: => $(".node-example").find(".question input").addClass("highlight")
  dimQuestion: => $(".node-example").find(".question input").removeClass("highlight")
  highlightResponse: => $(".node-example").find(".response input").addClass("highlight")
  dimResponse: => $(".node-example").find(".response input").removeClass("highlight")

  initialize: =>
    @model = @options.node

  delete: =>
    @trigger("remove")
    @$el.remove()
    @options.node = undefined

  render: =>
    @options.node ||= new Linguazone.Models[@game_type]
    @$el.html _.template(@template, @options.node.attributes)
    @onRender() if @onRender
    this

  updateModel: (e) =>
    $target = $(e.target)
    @model.set($target.attr("name"), $target.val())


  disable: =>
    @$el.find('.controls_wrapper').remove()
    @$el.find('input').attr("disabled", true)
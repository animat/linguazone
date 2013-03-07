Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NodeBaseView extends Backbone.Marionette.ItemView
  events:
    "change input"          : "updateModel",
    "change select"         : "updateModel",
    "click .delete"         : "delete",
    "focus .question input" : "showQuestion"
    "blur .question input"  : "hideQuestion"
    "focus .response input" : "showResponse"
    "blur .response input"  : "hideResponse"

  showQuestion: => $(".question-example").show()
  hideQuestion: => $(".question-example").hide()
  showResponse: => $(".response-example").show()
  hideResponse: => $(".response-example").hide()

  initialize: =>
    @model = @options.node

  delete: =>
    @trigger("remove")
    @$el.remove()
    @options.node = undefined

  updateModel: (e) =>
    $target = $(e.currentTarget)
    @options.node.set $target.attr("name"), $target.val()

  render: =>
    @options.node ||= new Linguazone.Models[@game_type]
    @$el.html _.template(@template, @options.node.attributes)
    @onRender()
    this

  disable: =>
    @$el.find('.controls_wrapper').remove()
    @$el.find('input').attr("disabled", true)

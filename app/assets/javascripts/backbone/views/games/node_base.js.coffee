Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NodeBaseView extends Backbone.View
  events:
    "change input"          : "updateModel",
    "click .delete"         : "delete",
    "mouseover"             : "showControls"
    "mouseout"              : "hideControls"
    "load"                  : "hideControls"
    "focus .question input" : "showQuestion"
    "blur .question input"  : "hideQuestion"
    "focus .response input" : "showResponse"
    "blur .response input"  : "hideResponse"

  showQuestion: => $(".question-example").show()
  hideQuestion: => $(".question-example").hide()
  showResponse: => $(".response-example").show()
  hideResponse: => $(".response-example").hide()

  initialize: =>
    # TODO: Can it have the tabs added in as soon as it initializes? Not sure why this is failing.
    @$el.find(".question").tabs()
    @$el.find(".response").tabs()
    @$el.find(".tabs-bottom .ui-tabs-nav, .tabs-bottom .ui-tabs-nav > *").removeClass("ui-corner-all ui-corner-top").addClass("ui-corner-bottom")
    @$el.removeClass("ui-widget, ui-widget-content")

  delete: =>
    @trigger("remove")
    @$el.remove()
    @options.node = undefined

  updateModel: (e) =>
    @options.node.set
      question: @getQuestion(),
      response: @getResponse()

  showControls: (e) =>
    @$el.find("ul.lz_input_toggle").show()
    # Only here while it doesn't work in initialize
    @$el.find(".question").tabs()
    @$el.find(".response").tabs()
    @$el.find(".tabs-bottom .ui-tabs-nav, .tabs-bottom .ui-tabs-nav > *").removeClass("ui-corner-all ui-corner-top").addClass("ui-corner-bottom")
    @$el.removeClass("ui-widget, ui-widget-content")

  hideControls: (e) =>
    @$el.find("ul.lz_input_toggle").hide()

  getQuestion: ->
    @$el.find(".question input").val()

  getResponse: ->
    @$el.find(".response input").val()

  render: ->
    @options.node ||= new Linguazone.Models[@game_type]
    @$el.html _.template(@template, @options.node.attributes)
    @disable() if @options.exampleNode

    # TODO @Len: Is there a way to trigger the hideControls method when the view renders?
    this.hideControls()
    @

  disable: =>
    @$el.find('.controls_wrapper').remove()
    @$el.find('input').attr("disabled", true)


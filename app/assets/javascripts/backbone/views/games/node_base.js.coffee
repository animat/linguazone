Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NodeBaseView extends Backbone.View
  events:
    "change input" : "updateModel",
    "click .delete" : "delete",
    "mouseover" : "showControls"
    "mouseout" : "hideControls",
		"load" : "hideControls",

  delete: =>
    @trigger("remove")
    @$el.remove()
    @options.node = undefined

  updateModel: (e) =>
    @options.node.set
      question: @getQuestion(),
      response: @getResponse()
	
  showControls: (e) =>
    @$el.find(".question").tabs()
    @$el.find(".response").tabs()
    @$el.find(".tabs-bottom .ui-tabs-nav, .tabs-bottom .ui-tabs-nav > *").removeClass("ui-corner-all ui-corner-top").addClass("ui-corner-bottom")
    @$el.removeClass("ui-widget, ui-widget-content")
    @$el.find("ul.lz_input_toggle").show()
	
  hideControls: (e) =>
    @$el.find("ul.lz_input_toggle").hide()
	
  getQuestion: ->
    @$el.find(".question input").val()

  getResponse: ->
    @$el.find(".response input").val()

  render: ->
    @options.node ||= new Linguazone.Models.Node
    @$el.html _.template(@template, @options.node.attributes)
    # TODO @Len: Is there a way to trigger the hideControls method when the view renders?
    this.hideControls()
    @


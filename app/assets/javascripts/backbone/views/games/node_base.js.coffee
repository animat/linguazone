Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NodeBaseView extends Backbone.Marionette.ItemView
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
      question: @ui.question.val()
      response: @ui.response.val()

  showControls: (e) =>
    @$el.find("ul.lz_input_toggle").show()
    # Only here while it doesn't work in initialize
    @$el.find(".question").tabs()
    @$el.find(".response").tabs()
    @$el.find(".tabs-bottom .ui-tabs-nav, .tabs-bottom .ui-tabs-nav > *").removeClass("ui-corner-all ui-corner-top").addClass("ui-corner-bottom")
    @$el.removeClass("ui-widget, ui-widget-content")

  ui: {
    question: ".question input"
    response: ".response input"
  }

  hideControls: (e) =>
    @$el.find("ul.lz_input_toggle").hide()

  onRender: ->
    @options.node ||= new Linguazone.Models[@game_type]
    @$el.html _.template(@template, @options.node.attributes)
    @disable() if @options.exampleNode
    @hideControls()
    @

  disable: =>
    @$el.find('.controls_wrapper').remove()
    @$el.find('input').attr("disabled", true)

class Linguazone.Views.Games.DoubleWordMatch extends Linguazone.Views.Games.NodeBaseView
  game_type: "DoubleWordMatch",

  template: """
  <div class="question lz_input">
    <label>Question:</label>
    <input type="text" name="question"/>

    <label>LTarget:</label>
    <input type="hidden" class="ltarget" name="ltarget"></input>

    <label>RTarget:</label>
    <input type="hidden" class="rtarget" name="rtarget"></input>
  </div>
  """

  render: =>
    ldata = [ {id: 1, text: 'el'}, {id: 5, text: 'las'}, {id: 2, text: 'la'}, {id: 3, text: 'los'}]
    rdata = [ {id: 1, text: 'gato'}, {id: 5, text: 'gata'}, {id: 2, text: 'pero'}, {id: 3, text: 'cassa'}]

    addLWord = (a, b) => { id: 99, text: a}
    format = (item) -> item.text

    super
    if Linguazone.Words.ltarget
      ldata = Linguazone.Words.ltarget.to_select_to()

    if Linguazone.Words.rtarget
      rdata = Linguazone.Words.rtarget.to_select_to()

    @$el.find(".ltarget").select2
      data: ldata
      createSearchChoice: addLWord
      placeholder: "Select Left Target"

    @$el.find(".rtarget").select2
      data: rdata
      createSearchChoice: addLWord
      placeholder: "Select Right Target"
    this

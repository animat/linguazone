#= require ./node_base

class Linguazone.Views.Games.SingleWordMatch extends Linguazone.Views.Games.NodeBaseView
  initialize: ->
    Linguazone.Views.Games.Nodes ||= []
    Linguazone.Views.Games.Nodes.push(@)
    super

  events:
    "click .delete"          : "delete",
    "focus .question input"  : "showQuestion"
    "blur .question input"   : "hideQuestion"
    "focus .response input"  : "showResponse"
    "blur .response input"   : "hideResponse"
    "change .ltarget"        : "updateModel"
    "change .question input" : "updateModel"

  game_type: "SingleWordMatch",

  template: """
  <div class="no-results">
    <h3>Enter Some Words Before Continuing</h3>
  </div>
  <div style-"display:none" class="question lz_input">
    <label>Question:</label>
    <input type="text" name="question" value="<%= question %>"/>

    <label>LTarget:</label>
    <select class="ltarget" name="ltarget">
    </select>
  </div>
  """

  render: =>
    super
    Linguazone.App.vent.off "wordlist:update"
    Linguazone.App.vent.on "wordlist:update", @updateAllOptionLists
    @$ltarget = @$el.find(".ltarget")
    @$ltarget.select2({placeholder: "Select the answer"})

    @$el.find(".lz_input").hide()
    @updateOptionLists()

    if @model.get("ltarget")
      @$ltarget.val(@model.get("ltarget"))

    this

  hasEnoughOptions: => Linguazone.Options.ltarget and Linguazone.Options.ltarget.models.length

  updateAllOptionLists: => _.each(Linguazone.Views.Games.Nodes, (node) -> node.updateOptionLists())

  updateOptionLists: =>
    return unless @hasEnoughOptions()

    @$el.find(".no-results").hide()
    @$el.find(".lz_input").css('display', 'inline-block')

    @loadData("ltarget")
    @$ltarget.select2({placeholder: "Select the answer"})

  loadData: (dataType) ->
    $elem = @$el.find(".#{dataType}")
    data = Linguazone.Options[dataType].to_select_to()
    val = $elem.val()
    $elem.html("")
    _.each data, (datum) => $elem.append("<option value='#{datum.text}'>#{datum.text}</option>")
    $elem.val(val)

class Linguazone.Views.Games.DoubleWordMatch extends Linguazone.Views.Games.NodeBaseView
  initialize: ->
    Linguazone.Views.Games.Nodes ||= []
    Linguazone.Views.Games.Nodes.push(@)
    super

  events:
    "click .delete"          : "delete",
    "focus .question input"  : "showQuestion"
    "blur .question input"   : "hideQuestion"
    "focus .response input"  : "showResponse"
    "blur .response input"   : "hideResponse"
    "change .rtarget"        : "updateModel"
    "change .ltarget"        : "updateModel"
    "change .question input" : "updateModel"

  game_type: "DoubleWordMatch",

  template: """
  <div class="no-results">
    <h3>Enter Some Words Before Continuing</h3>
  </div>

  <div style-"display:none" class="question lz_input">
    <div class="question">
      <label>Question:</label>
      <input type="text" name="question" value="<%= question %>"/>
    </div>

    <label>LTarget:</label>
    <select class="ltarget" name="ltarget">
    </select>

    <label>RTarget:</label>
    <select class="rtarget" name="rtarget">
    </select>
  </div>
  <div class="controls_wrapper">
    <div class="delete" tabindex="-1"><img src="/images/customizer/remove_btn.png" alt="X">
  </div>
  """

  onRender: =>
    Linguazone.App.vent.off "wordlist:update"
    Linguazone.App.vent.on "wordlist:update", @updateAllOptionLists
    @$ltarget = @$el.find(".ltarget")
    @$rtarget = @$el.find(".rtarget")
    @$ltarget.select2({placeholder: "Select first match"})
    @$rtarget.select2({placeholder: "Select second match"})

    @$el.find(".lz_input").hide()
    @updateOptionLists()

    if @model.get("ltarget")
      @$ltarget.val(@model.get("ltarget"))

    if @model.get("ltarget")
      @$rtarget.val(@model.get("rtarget"))
    this

  hasEnoughOptions: => Linguazone.Options.ltarget and Linguazone.Options.ltarget.models.length and Linguazone.Options.rtarget.models.length

  updateAllOptionLists: => _.each(Linguazone.Views.Games.Nodes, (node) -> node.updateOptionLists())

  updateOptionLists: =>
    return unless @hasEnoughOptions()

    @$el.find(".no-results").hide()
    @$el.find(".lz_input").css('display', 'inline-block')

    @loadData("ltarget")
    @loadData("rtarget")
    @$ltarget.select2({placeholder: "Select first match"})
    @$rtarget.select2({placeholder: "Select second match"})

  loadData: (dataType) ->
    $elem = @$el.find(".#{dataType}")
    data = Linguazone.Options[dataType].to_select_to()
    val = $elem.val()
    $elem.html("")
    _.each data, (datum) => $elem.append("<option>#{datum.text}</option>")
    $elem.val(val)

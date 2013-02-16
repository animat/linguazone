#= require ./node_base

class Linguazone.Views.Games.DoubleWordMatch extends Linguazone.Views.Games.NodeBaseView
  initialize: ->
    Linguazone.Views.Games.Nodes ||= []
    Linguazone.Views.Games.Nodes.push(@)
    super

  game_type: "DoubleWordMatch",

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

    <label>RTarget:</label>
    <select class="rtarget" name="rtarget">
    </select>
  </div>
  """

  render: =>
    super
    Linguazone.App.vent.off "wordlist:update"
    Linguazone.App.vent.on "wordlist:update", @updateAllWordLists
    @$ltarget = @$el.find(".ltarget")
    @$rtarget = @$el.find(".rtarget")

    @$el.find(".lz_input").hide()
    @updateWordLists()

    if @model.get("ltarget")
      @$ltarget.val(@model.get("ltarget"))

    if @model.get("ltarget")
      @$rtarget.val(@model.get("rtarget"))
    this

  hasEnoughWords: => Linguazone.Words.ltarget and Linguazone.Words.ltarget.models.length and Linguazone.Words.rtarget.models.length

  updateAllWordLists: => _.each(Linguazone.Views.Games.Nodes, (node) -> node.updateWordLists())

  updateWordLists: =>
    return unless @hasEnoughWords()

    @$el.find(".no-results").hide()
    @$el.find(".lz_input").show()

    @loadData("ltarget")
    @loadData("rtarget")

  loadData: (dataType) ->
    $elem = @$el.find(".#{dataType}")
    data = Linguazone.Words[dataType].to_select_to()
    val = $elem.val()
    $elem.html("")
    _.each data, (datum) => $elem.append("<option>#{datum.text}</option>")
    $elem.val(val)

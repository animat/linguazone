class Linguazone.Views.Games.MultipleAnswer extends Linguazone.Views.Games.NodeBaseView

  # TODO: remove duplication:
  events:
    "click .delete"           : "delete",
    "focus .question input"   : "showQuestion"
    "blur .question input"    : "hideQuestion"
    "focus .response input"   : "showResponse"
    "blur .response input"    : "hideResponse"
    "change .question input"  : "updateModel"
    "change .response select" : "updateModel"

  template: """
    <div class="step-1 step">
      <label>Correct Responses</label>

      <div class="optionlist">
      </div>

      <p/>
      <a class="next">Next</a>
    </div>

    <div class="step-2 step">
      <div class="question">
        <label>Question:</label>
        <input type="text" name="question" value="<%= question %>"/>
      </div>

      <div class="response">
        <label>Responses:</label>
        <select name="response" class="response"></select>
      </div>

      <a clas="previous">Previous</a>
    </div>
  """

  onRender: =>
    @optionList = new Linguazone.Views.Games.OptionListView
      name: "response"
      list: []

    @$el.find(".optionlist").append(@optionList.render().el)

    @optionList.on("wordlist:update", @updateWordList)
    @$el.wizardify()

  updateModel: (e) =>
    $target = $(e.target)
    @model.set($target.attr("name"), $target.val())

  updateWordList: =>
    @$el.find("select.response").html("")
    _.each @optionList.collection().models, (word) =>
      @$el.find("select.response").append("<option>#{word.get("text")}</option>")
    window.model = @model
    window.optionList = @optionList
    @model.set "options", @optionList.collection().to_a()

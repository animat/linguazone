class Linguazone.Views.Games.MultipleAnswer extends Linguazone.Views.Games.NodeBaseView

  template: """
    <div class="step-1 step">
      <label>Correct Responses</label>

      <div class="optionlist">
      </div>

      <p/>
      <a class="next">Next</a>
    </div>

    <div class="step-2 step">
      <label>Question:</label>
      <input type="text" name="question" value="<%= question %>"/>

      <label>Responses:</label>
      <select name="response" class="response">
      </select>

      <p/>
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
    super
    @setOptions() if $target.attr("name") is "response"

  setOptions: =>
    @options.node.get("response").options = @optionList.collection().to_a()

  updateWordList: =>
    @$el.find("select.response").html("")
    _.each @optionList.collection().models, (word) =>
      @$el.find("select.response").append("<option>#{word.get("text")}</option>")

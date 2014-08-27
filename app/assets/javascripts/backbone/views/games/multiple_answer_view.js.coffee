class Linguazone.Views.Games.MultipleAnswer extends Linguazone.Views.Games.NodeBaseView

  game_type: "MultipleAnswer",

  # TODO: remove duplication:
  events:
    "click .delete"           : "delete",
    "focus .question input"   : "showQuestion"
    "blur .question input"    : "hideQuestion"
    "focus .response input"   : "showResponse"
    "blur .response input"    : "hideResponse"
    "change .question input"  : "updateModel"
    "click .next"             : "updateQuestion"
    "change .response select" : "updateModel"

  template: """
    <div class="step-1 step">
      <label class="wizard">Step 1: Enter Your Question</label>
      <div class="question">
        <label>Question:</label>
        <input type="text" name="question" value="<%= question %>"/>
      </div>
      <br />
      <a class="next">Next</a>
    </div>
    <div class="step-2 step">
      <label class="wizard">Step 2: Add Possible Responses to "<span class="question_text"></span>"</label>
      <div class="optionlist">
      </div>
      <br />
      <a class="previous">Previous</a>
      <a class="next">Next</a>
    </div>
    <div class="step-3 step">
      <label class="wizard">Step 3: Select the Correct Response</label>
      <div class="response">
        <label>Which Response is Correct?</label>
        <select name="response" class="response">
          <option selected="selected" disabled="disabled">Select a correct answer</option>
        </select>
      </div>
      <br />
      <a class="previous">Previous</a>
      <a class="next">Next</a>
    </div>
    <div class="step-4 step">
      <label class="wizard">Step 4: Preview your Question</label>
      <div style="margin-left: 20px;">
        <label class="preview_question"></label>
        <div class="answer_list_preview">
      
        </div>
      </div>
      <br />
      <a class="previous">Previous</a>
    </div>
  """

  onRender: =>
    @optionList = new Linguazone.Views.Games.OptionListView
      name: "response"
      list: []

    @$el.find(".optionlist").append(@optionList.render().el)

    @optionList.on("wordlist:update", @updateWordList)
    @$el.wizardify()

  updateWordList: =>
    @$el.find("select.response").html("<option disabled='true' selected='true'>Select an Option</option>")
    _.each @optionList.collection().models, (word) =>
      @$el.find("select.response").append("<option>#{word.get("text")}</option>")
    window.model = @model
    window.optionList = @optionList
    @model.set "options", @optionList.collection().to_a()

  updateQuestion: =>
    @$el.find(".question_text").html(@$el.find(".question input").val())
    @$el.find(".preview_question").html(@model.get("question"))
    optionsArray = @model.get("options").split(",")
    @$el.find(".answer_list_preview").html("")
    for element, index in optionsArray
        @$el.find(".answer_list_preview").append('<div class="answer_preview '+"value_"+optionsArray[index]+'"><span></span>'+optionsArray[index]+'</div>')
    @$el.find(".value_"+@model.get("response")).addClass("correct_answer")
    


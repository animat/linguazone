class Linguazone.Views.Games.MultipleAnswer extends Linguazone.Views.Games.NodeBaseView
  game_type: "MultipleAnswer"

  # TODO: remove duplication:
  events:
    "click .delete"           : "delete"
    "focus .question input"   : "highlightQuestion"
    "blur .question input"    : "dimQuestion"
    "focus .response input"   : "highlightResponse"
    "blur .response input"    : "dimResponse"
    "click .previous"         : "previousStep"
    "click .step-1 .next"     : "setQuestion"
    "click .step-2 .next"     : "setWordOptions"
    "click .step-3 .next"     : "setResponse"

  template: """
    <div class="step-1 step" style="display:none">
      <label class="wizard">Step 1: Enter Your Question</label>
      <div class="question">
        <label>Question:</label>
        <input type="text" class="question" name="question" value="<%= getQuestion() %>"/>
      </div>
      <br />
      <a class="next">Next</a>
    </div>

    <div class="step-2 step" style="display:none">
      <label class="wizard">Step 2: Add Possible Responses to "<span class="question_text"></span>"</label>
      <div class="optionlist">
      </div>
      <br />
      <a class="previous">Previous</a>
      <a class="next">Next</a>
    </div>

    <div class="step-3 step" style="display:none">
      <label class="wizard">Step 3: Select the Correct Response</label>
      <div class="response">
        <label>Which Response is Correct?</label>

        <select name="response" class="response">
          <option selected="selected">Select a correct answer</option>
        </select>
        <hr/>
      </div>
      <br />
      <a class="previous">Previous</a>
      <a class="next">Next</a>
    </div>

    <div class="step-4 step">
      <label class="wizard">Step 4: Preview your Question</label>
      <div class="answer_list_wrapper">

      </div>
      <br />
      <a class="previous">Previous</a>
    </div>
  """

  templateHelpers: =>
    getQuestion: =>
      @model.get("question")?.content?.content

  onRender: =>
    @currentStep = 1
    @optionList = new Linguazone.Views.Games.OptionListView
      name: "response"
      list: @model.get("options") || []

    @$el.find(".optionlist").append(@optionList.render().el)

    #@optionList.on("wordlist:update", @updateWordList)

    @showCurrentStep()

  showCurrentStep: ->
    @$(".step").hide()
    @$(".step-#{@currentStep}").show()

  nextStep: ->
    @currentStep++
    @showCurrentStep()

  previousStep: =>
    @currentStep--
    @showCurrentStep()

  setWordOptions: =>
    return Linguazone.App.execute("message", "Responses required") unless @optionList.collection().length > 0
    @model.set "options", @optionList.collection().to_a()
    @$el.find("select.response").html("<option disabled='true' selected='true'>Select an Option</option>")
    _.each @optionList.collection().models, (word) =>
      @$el.find("select.response").append("<option value=\"#{word.get("text")}\">#{word.get("text")}</option>")
    @nextStep()

  setQuestion: =>
    question = @$el.find(".question input").val()
    return Linguazone.App.execute("message", "Question required") unless question
    @model.set("question", question)
    @$(".question_text").html question
    @nextStep()

  setResponse: =>
    response = @$el.find("select.response").val()
    return Linguazone.App.execute("message", "Correct Answer required") unless response
    @model.set("response", response)
    @nextStep()
    view = new Linguazone.Views.Games.Preview
      model: @model

    # TODO: make this a region
    @$el.find(".answer_list_wrapper").html("").append view.render().$el

class Linguazone.Views.Games.Preview extends Backbone.Marionette.ItemView
  template: """
      <div style="margin-left: 20px;">
        <label class="preview_question"><%= question %></label>
        <div class="answer_list_preview"></div>
      </div>
  """

  onRender: ->
    throw "options must be a string" unless _.isString(@model.get("options"))

    options = @model.get("options").split(",")
    for element, index in options
      div = "<div class='answer_preview value_#{options[index]}'><span></span>#{options[index]}</div>"
      @$(".answer_list_preview").append div

    @$(".value_#{@model.get('response')}").addClass("correct_answer")

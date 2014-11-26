##= require ./node_base.js

class Linguazone.Views.Games.AnswerAndMatch extends Linguazone.Views.Games.NodeBaseView
  game_type: "AnswerAndMatch",

  #TODO: remove duplication:
  events:
    "click .delete"           : "delete",
    "focus .question input"   : "highlightQuestion"
    "blur .question input"    : "dimQuestion"
    "focus .response input"   : "highlightResponse"
    "blur .response input"    : "dimResponse"
    "change .question input"  : "updateModel"
    "click .next"             : "updateQuestion"
    "change .response select" : "updateModel"

  template: """
    <div class="optionlist">
      </div>
    <div class="step-1 step">
      <label class="wizard">Step 1: Enter a Term</label>
      <div class="question">
        <label>Question:</label>
        
      </div>
      <br />
      <a class="next">Next</a>
    </div>
    <div class="step-2 step">
      <label class="wizard">Step 2: Enter the Correct Student Response for "<span class="question_text"></span>"</label>
      <div class="response">

      </div>
      <br />
      <a class="previous">Previous</a>
      <a class="next">Next</a>
    </div>
    <div class="step-3 step">
      <label class="wizard">Step 3: Select the Correct Group</label>
      <label>Which Response is Correct?</label>
      <select name="response" class="response">
        <option selected="selected" disabled="disabled">Select a correct answer</option>
      </select>
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
    ## just appended
    Linguazone.App.vent.off "wordlist:update"
    Linguazone.App.vent.on "wordlist:update", @updateAllOptionLists
    
    #@optionList = new Linguazone.Views.Games.OptionListView
    #  name: "response"
    #  list: []

    #@$el.find(".optionlist").append(@optionList.render().el)

    #@optionList.on("wordlist:update", @updateWordList)

    @updateOptionLists()
    @$el.wizardify()

    question = new Linguazone.Models.NodeOption
      content: @model.get("question")
      name: "question"

    questionView = new Linguazone.Views.Games.NodeOption
      model: question
      node_options: @options.node_options?.question

    question.on "change", => @model.set("question", question.get("content"))

    response = new Linguazone.Models.NodeOption
      content: @model.get("response")
      name: "response"

    responseView = new Linguazone.Views.Games.NodeOption
      model: response
      node_options: @options.node_options?.response

    response.on "change", => @model.set("response", response.get("content"))

    @$el.find(".question").append(questionView.render().el)
    @$el.find(".response").append(responseView.render().el)


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

  updateQuestion: =>
    @$el.find(".question_text").html(@$el.find(".question input").val())
    @$el.find(".preview_question").html(@model.get("question"))
    optionsArray = @model.get("options").split(",")
    @$el.find(".answer_list_preview").html("")
    for element, index in optionsArray
        @$el.find(".answer_list_preview").append('<div class="answer_preview '+"value_"+optionsArray[index]+'"><span></span>'+optionsArray[index]+'</div>')
    @$el.find(".value_"+@model.get("response")).addClass("correct_answer")


class Linguazone.Views.Games.TwoAnswerAndMatch extends Linguazone.Views.Games.NodeBaseView
  game_type: "TwoAnswerAndMatch",

  #TODO: remove duplication:
  events:
    "click .delete"           : "delete",
    "focus .question input"   : "highlightQuestion"
    "blur .question input"    : "dimQuestion"
    "focus .response input"   : "highlightResponse"
    "blur .response input"    : "dimResponse"
    "change .question input"  : "updateModel"
    "click .next"             : "updateQuestion"
    "change .response select" : "updateModel"

  template: """
    <div class="optionlist">
      </div>
    <div class="step-1 step">
      <label class="wizard">Step 1: Enter a Term</label>
      <div class="question">
        <label>Question:</label>
        <input type="text" name="question" value="<%= question %>"/>
      </div>
      <br />
      <a class="next">Next</a>
    </div>
    <div class="step-2 step">
      <label class="wizard">Step 2: Enter the Correct Student Response for "<span class="question_text"></span>"</label>
       <input type="text" name="response" />
      <br />
      <a class="previous">Previous</a>
      <a class="next">Next</a>
    </div>
    <div class="step-3 step">
      <label class="wizard">Step 3: Select the Correct Match</label>
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
      <label class="wizard">Step 4: Enter the complete sentence</label>
      <input type="text" name="response" />
      <br />
      <a class="previous">Previous</a>
      <a class="next">Next</a>
    </div>
    <div class="step-5 step">
      <label class="wizard">Step 5: Preview your Question</label>
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
    ## just appended
    Linguazone.App.vent.off "wordlist:update"
    Linguazone.App.vent.on "wordlist:update", @updateAllOptionLists
    
    #@optionList = new Linguazone.Views.Games.OptionListView
    #  name: "response"
    #  list: []

    #@$el.find(".optionlist").append(@optionList.render().el)

    #@optionList.on("wordlist:update", @updateWordList)

    @updateOptionLists()
    @$el.wizardify()

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

  #updateWordList: =>
  #  @$el.find("select.response").html("<option disabled='true' selected='true'>Select an Option</option>")
  #  _.each @optionList.collection().models, (word) =>
  #    @$el.find("select.response").append("<option>#{word.get("text")}</option>")
  #  window.model = @model
  #  window.optionList = @optionList
  #  @model.set "options", @optionList.collection().to_a()

  updateQuestion: =>
    @$el.find(".question_text").html(@$el.find(".question input").val())
    @$el.find(".preview_question").html(@model.get("question"))
    optionsArray = @model.get("options").split(",")
    @$el.find(".answer_list_preview").html("")
    for element, index in optionsArray
        @$el.find(".answer_list_preview").append('<div class="answer_preview '+"value_"+optionsArray[index]+'"><span></span>'+optionsArray[index]+'</div>')
    @$el.find(".value_"+@model.get("response")).addClass("correct_answer")
    


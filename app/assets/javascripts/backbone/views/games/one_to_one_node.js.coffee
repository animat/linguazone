Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.OneToOne extends Linguazone.Views.Games.NodeBaseView
  game_type: "OneToOne",

  template: """
    <div class='question-label'></div>
    <div class='response-label'></div>

    <div class="clearFloat"></div>

    <div class="question"></div>
    <div class="response"></div>

    <div class="controls_wrapper">
      <div class="delete" tabIndex="-1"><img src="/images/customizer/remove_btn.png" alt="X" /></d>
    </div>

    <div class="clearFloat"></div>
  """

  loadExamples: (examples) ->
    # HACK, undo what we did on render, set the model and go again.
    @model.set(examples.getExampleHash())
    @onRender()
    examples.each (example) =>
      selector = ".#{example.get('node_key_name')}-label"
      @$el.find(selector).text(example.get "input_description")
    @disable()

  getQuestion: ->
    @question = new Linguazone.Models.NodeOption
      content: @model.get("question")
      name: "question"

    questionView = new Linguazone.Views.Games.NodeOption
      model: @question
      node_options: @options.node_options?.question

    @question.on "change", =>
      @model.set("question", @question.get("content"))

    @$el.find(".question").html questionView.render().el

  getResponse: ->
    @response = new Linguazone.Models.NodeOption
      content: @model.get("response")
      name: "response"

    responseView = new Linguazone.Views.Games.NodeOption
      model: @response
      node_options: @options.node_options?.response

    @response.on "change", =>
      @model.set("response", @response.get("content"))

    @$el.find(".response").html responseView.render().el

  onRender: =>
    @getQuestion()
    @getResponse()


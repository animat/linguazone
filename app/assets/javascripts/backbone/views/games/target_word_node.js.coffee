Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.TargetWord extends Linguazone.Views.Games.NodeBaseView
  game_type: "TargetWord",

  template: """
    <div class="question"></div>

    <div class="controls_wrapper">
      <a href="#" class="delete" tabIndex="-1"><img src="/images/customizer/remove_btn.png" alt="X" /></a>
    </div>

    <div class="clearFloat"></div>

    <div class='question-label'></div>
  """

  onRender: =>
    question = new Linguazone.Models.NodeOption
      content: @model.get("question")
      name: "question"

    nodeOptionDefaults =
      prompt: "Enter a word:"
      allowImage: false
      multiple: false

    questionView = new Linguazone.Views.Games.NodeOption
      model: question
      node_options: _.defaults(nodeOptionDefaults, @options.node_options)

    @listenTo questionView, "enter:pressed", ->
      Linguazone.App.vent.trigger("node:new")

    question.on "change", =>
      @model.set("question", question.get("content"))

    @$el.find(".question").html questionView.render().el

Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.OneToOne extends Linguazone.Views.Games.NodeBaseView
  game_type: "OneToOne",
  template: """
  <div class="question">
  </div>

  <div class="response">
  </div>

  <div class="controls_wrapper">
    <a href="#" class="delete" tabIndex="-1"><img src="/images/customizer/remove_btn.png" alt="X" /></a>
  </div>
  <div class="clearFloat"></div>
  """

  onRender: =>
    question = new Linguazone.Models.NodeOption
      content: @model.get("question")
      name: "question"

    questionView = new Linguazone.Views.Games.NodeOption
      model: question

    question.on "change", => @model.set("question", question.get("content"))

    response = new Linguazone.Models.NodeOption
        content: @model.get("response")
        name: "response"

    responseView = new Linguazone.Views.Games.NodeOption
      model: response

    response.on "change", => @model.set("response", response.get("content"))

    @$el.find(".question").html questionView.render().el
    @$el.find(".response").html responseView.render().el

    unless _.contains(@options.node_options.question, "image")
      @$el.find(".question .image-link").hide()

    unless _.contains(@options.node_options.response, "image")
      @$el.find(".response .image-link").hide()

    #    @getQuestionRegion().show responseView
    #    @getResponseRegion().show questionView
    #
    #  getQuestionRegion: =>
    #    @questionRegion ||= new Backbone.Marionette.Region
    #      el: 
    #  getResponseRegion: =>
    #    @responseRegion ||= new Backbone.Marionette.Region
    #      el: @$el.find(".response")

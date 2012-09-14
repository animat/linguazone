Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NodeView extends Backbone.View
  events:
    "change input" : "updateModel",

  template: """
  <div class="question">
    <label>
      Your Input
      <input type="text" value="<%= question %>">
    </label>
  </div>

  <div class="response">
    <label>
      Student Answer
      <input type="text" value="<%= response %>">
    </label>
  </div>
  """

  updateModel: (e) =>
    @options.node.set
      question: @getQuestion(),
      response: @getResponse()

  getQuestion: ->
    @$el.find(".question input").val()

  getResponse: ->
    @$el.find(".response input").val()

  render: ->
    @options.node ||= new Linguazone.Models.Node
    @$el.html _.template(@template, @options.node.attributes)
    @

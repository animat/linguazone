Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NodeView extends Backbone.View
  template: """
  <div class="question">
    Your Input
    <input type="text">
  </div>

  <div class="answer">
    Student Answer
    <input type="text">
  </div>
  """

  render: ->
    @$el.html _.template(@template)
    @


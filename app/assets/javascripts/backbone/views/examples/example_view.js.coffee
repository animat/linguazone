Linguazone.Views.Examples ||= {}

class Linguazone.Views.Examples.ExampleView extends Backbone.View
  template: """
    <div id="example_images">
      <img src="<%= example.get("image_url")%>">
    </div>
  """

  initialize: ->
    @example = @options.example
    @nodeView = new Linguazone.Views.Games.NodeView model: @options.node, exampleNode: true

  render: =>
    @$el.html(_.template(@template, { example: @example }))
    view = @nodeView.render()
    view.$el.find("input").prop("disabled", true)
    @$el.append(view.el)
    this

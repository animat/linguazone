Linguazone.Views.Examples ||= {}

class Linguazone.Views.Examples.ExampleView extends Backbone.View
  template: """
    <img src="<%= example.get("image_url")%>">
  """

  initialize: ->
    super
    @example = @options.example

  render: ->
    @$el.html(_.template(@template, { example: @example }))
    this

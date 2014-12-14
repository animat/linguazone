Linguazone.Views.GameType ||= {}

class Linguazone.Views.GameType extends Backbone.View
  className: "game-type backbone"
  # TODO: The following is in the wrong place... Each input element in the example should have a label and a hint
  # 				Where can this be changed? I'd also like to have the example node have some different UI and UX in other ways
  template: """
    <h2>Example prompt</h2>
    <p>Example hint</p>
  """

  initialize: ->
    @name = @options.model.get("name")
    @node = new Linguazone.Models["#{@name}Node"]
    @node.set("question", "")
    @node.set("response", "")
    @node.set @options.model.get("node")
    @nodeView  = new Linguazone.Views.Games[@name](node: @node, exampleNode: true)
    @examples = new Linguazone.Collections.ExampleCollection

    @examples.fetch
      success: (response, xhr) =>
        @examples = response
        @render()

      error: (errorResponse) =>
        console.warn "Could not find an example for #{@name}"

  render: =>
    @$el.html(_.template(@template))
    @$el.append(@nodeView.render().el)

    @nodeView.$el.addClass("node-example")

    if @name = "OneToOne"
      $("#examples .question").prepend(@template2)

      if @examples.models?.length
        console.log "Appending example...", @examples.models[0]
        $("#examples .question h2").append(@examples.models[0].get("display_label"))

    template2: """
      <h2></h2>
      <p></p>
    """

class Linguazone.Collections.ExampleCollection extends Backbone.Collection
  #TODO: make this dynamic, add in userid
  url: '/examples?activity_id=2&language_id=6'
  initialize: ->

  parse: (data) ->
    return data

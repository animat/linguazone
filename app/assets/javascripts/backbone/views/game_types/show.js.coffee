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
    obj = this
    @examples.fetch
      success: (response, xhr) =>
        @examples = response;
        obj.render()
        return

      error: (errorResponse) ->
        console.log "Red alert!" + errorResponse
        return

  render: =>
    console.log("RENDERING EXAMPLE STUFF")
    @$el.html(_.template(@template))
    @$el.append(@nodeView.render().el)
    @nodeView.$el.addClass("node-example")

    if @name = "OneToOne"
      console.log("OneToOne is trueeee")
      console.log(@examples.models)
      $("#examples .question").prepend(@template2)
      console.log("prepended template")
      if @examples.models 
        $("#examples .question h2").append(@examples.models[0].display_label)
      console.log("added display label")

    template2: """
      <h2></h2>
      <p></p>
    """

class Linguazone.Collections.ExampleCollection extends Backbone.Collection
  #TODO: make this dynamic, add in userid
  url: 'http://localhost:3000/examples?activity_id=2&language_id=6'
  initialize: ->

  parse: (data) ->
    return data

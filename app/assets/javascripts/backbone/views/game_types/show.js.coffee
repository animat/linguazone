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
    @node.set @options.model.get("node")
    @nodeView  = new Linguazone.Views.Games[@name](node: @node, exampleNode: true)

  render: =>
    @$el.html(_.template(@template))
    @$el.append(@nodeView.render().el)
    @nodeView.$el.addClass("node-example")

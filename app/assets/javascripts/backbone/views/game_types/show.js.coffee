Linguazone.Views.GameType ||= {}

class Linguazone.Views.GameType extends Backbone.View
  className: "game-type"
  template: """
  """
  initialize: ->
    @name = @options.model.get("name")
    @node = new Linguazone.Models["#{@name}Node"]
    @node.set @options.model.get("node")
    @nodeView  = new Linguazone.Views.Games[@name](node: @node, exampleNode: true)

  render: =>
    @$el.html(_.template(@template))
    @$el.append(@nodeView.render().el)
    @

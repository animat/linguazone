class Linguazone.Views.Example extends Backbone.Marionette.Layout
  template: """
    <h3>Example Question</h3>
    <div id='example'></div>
  """

  regions:
    "example" : "#example"

  onRender: ->
    @loadNodeView()
    setTimeout((=> @makeSticky()), 200)

  loadNodeView: ->
    name = @model.get('name')
    klass = Linguazone.Views.Games[name]

    @node = new Linguazone.Models["#{name}Node"]
    @nodeView  = new klass(node: @node, exampleNode: true)
    @example.show @nodeView

  makeSticky: ->
    $example = $("#examples")

    originalTop = $example.offset().top
    originalLeft = $example.position().left

    updatePosition = =>
      if $(window).scrollTop() > originalTop
        $example.css({ 'position': 'fixed', 'top':0, 'left': originalLeft})
      else
        $example.css({ 'position': 'relative', 'left': '-10px' }) # HACK: why -10 px???

    updatePosition()
    $(window).scroll(updatePosition)

class Linguazone.Collections.ExampleCollection extends Backbone.Collection

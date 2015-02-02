class Linguazone.Views.GameType extends Backbone.Marionette.Layout
  template: """
    <h3>Example Question</h3>
    <div id='example'></div>
  """

  regions:
    "example"  : "#example"

  onRender: ->
    @loadNodeView()
    @setExampleValues()
    #setTimeout((=> @makeSticky()), 100)

  setExampleValues: ->
    if _.isFunction @nodeView.loadExamples
      @nodeView.loadExamples @options.examples
    else
      console.error "Can't load examples for ", @model

  loadNodeView: ->
    name = @model.get('name')
    klass = Linguazone.Views.Games[name]

    @node = new Linguazone.Models["#{name}Node"]
    @nodeView  = new klass(node: @node, exampleNode: true)
    @example.show @nodeView

  makeSticky: ->
    $example = $("#examples")

    updatePosition = =>
      unless @isSticky
        originalTop = $example.offset().top
        originalLeft = $example.position().left

      if $(window).scrollTop() > originalTop
        $example.css({ 'position': 'fixed', 'top' : '-5px', 'left': originalLeft})
        @isSticky = true
      else
        @isSticky = false
        $example.css({ 'position': 'relative', 'left': '-10px' }) # HACK: why -10 px???

    updatePosition()
    $(window).scroll(updatePosition)


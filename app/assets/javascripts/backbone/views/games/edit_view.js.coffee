Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.EditView extends Linguazone.Views.Games.GameFormBaseView
  template : JST["backbone/templates/games/edit"]

  constructor: (options) ->
    super(options)
    @model.bind "change", @render


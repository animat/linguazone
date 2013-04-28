Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.EditView extends Linguazone.Views.Games.GameFormBaseView
  template : JST["backbone/templates/games/edit"]

  events:
    "submit": "save"

  constructor: (options) ->
    super(options)

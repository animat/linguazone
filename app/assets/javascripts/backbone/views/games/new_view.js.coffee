Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NewView extends Linguazone.Views.Games.GameFormBaseView
  template: JST["backbone/templates/games/new"]
  events:
    "submit #new-game": "save"
    "click .addNode": "addNode"

  constructor: (options) ->
    @model = new Linguazone.Models.Game
      activity_id: options.activity_id
      language_id: options.language_id
      game_type:   options.game_type
    @model.addBlankNode()
    super
    @model.bind "change", @render

class Linguazone.Views.Games.MatchingNewView extends Linguazone.Views.Games.GameFormBaseView
  constructor: (options) ->
    super
  initialize_word_list: ->



Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NewView extends Linguazone.Views.Games.GameFormBaseView
  template: JST["backbone/templates/games/new"]
  events:
    "submit #new-game": "metadataStep"
    "click .addNode": "addNode"
    "click #submit_game": "save"
    "change #description_input": "updateMetadata"

  # Changed by @CR possibly a mistake
  #modelEvents:
  #  "change": "render"

  constructor: (options) ->
    console.log("incoming options")
    console.log(options)
    @model = new Linguazone.Models.Game
      activity_id: options.activity_id
      language_id: options.language_id
      game_type:   options.game_type
    @model.addBlankNode()
    super

  updateMetadata: =>
    
    @model.set("description", $("#description_input").val())
    console.log(@model.get('description'))
    return

class Linguazone.Views.Games.MatchingNewView extends Linguazone.Views.Games.GameFormBaseView
  constructor: (options) ->
    super

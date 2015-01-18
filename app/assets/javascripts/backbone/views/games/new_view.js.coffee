Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NewView extends Linguazone.Views.Games.GameFormBaseView
  template: JST["backbone/templates/games/new"]
  events:
    "submit #new-game": "metadataStep"
    "click .addNode": "addNode"
    "focus .addNode": "addNode"
    "click #submit_game": "save"
    "change #description_input": "updateMetadata"

  updateMetadata: =>
    @model.set("description", $("#description_input").val())

class Linguazone.Views.Games.MatchingNewView extends Linguazone.Views.Games.GameFormBaseView

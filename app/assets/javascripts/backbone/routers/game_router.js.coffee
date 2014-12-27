class Linguazone.Routers.GameRouter extends Backbone.Marionette.AppRouter
  initialize: (options) ->

  appRoutes:
    "activity/:activityId/gameType/:gameType/new" : "new"

load_game_type = (activity_id, language_id) =>
  game_type = new Linguazone.Models.GameType
  xhr = game_type.fetch
    data:
      activity_id: activity_id
      language_id: language_id
  xhr.success ->
    Linguazone.App.examples.show new Linguazone.Views.GameType({ model: game_type })

    _.each game_type.get("lists"), (list) ->
      view = new Linguazone.Views.Games.OptionListView({name: list.linkedto })
      $("#option-lists").append(view.render().el)


new Linguazone.Routers.GameRouter
  controller:
    new: (activityId, gameType) ->
      game = new Linguazone.Models.Game
        activity_id: activityId
        language_id: QueryString.language
        game_type:   gameType

      game.addBlankNode()

      view = new Linguazone.Views.Games.NewView
        model: game

      #TODO: move all of the saving here.
      view.on "save", ->
        window.location = "/my_games"

      load_game_type activityId, QueryString.language

      Linguazone.App.customizer.show view

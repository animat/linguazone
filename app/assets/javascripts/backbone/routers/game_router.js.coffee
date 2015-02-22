class Linguazone.Routers.GameRouter extends Backbone.Marionette.AppRouter
  initialize: (options) ->

  appRoutes:
    "activity/:activityId/gameType/:gameType/new" : "new"

load_game_details = (activity_id, language_id) =>

  game_type = new Linguazone.Models.GameType
  game_type.fetch
    data:
      activity_id: activity_id
      language_id: language_id


  examples = new Linguazone.Collections.ExampleCollection
  examples.url = "/examples?activity_id=#{activity_id}&language_id=#{language_id}"
  examples.fetch().error ->
    console.error "Could not find an example for #{@name}"

  activity  = Linguazone.App.request "entities:activity:fetch", activity_id

  # Load Examples
  Linguazone.App.execute "when:fetched", [game_type, examples, activity], ->
    view = new Linguazone.Views.GameType
      model: game_type
      examples: examples

    Linguazone.App.examples.show view
    $("#examples").show()

  Linguazone.App.execute "when:fetched", activity, ->
    view = new Linguazone.Views.Activity
      model: activity
      header: true

    Linguazone.App.gameDetails.show(view)

  # Load Option Lists
  Linguazone.App.execute "when:fetched", game_type, ->
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
        courses: Linguazone.App.request "entities:courses:list"

      #TODO: move all of the saving here.
      view.on "save", ->
        window.location = "/my_games"

      load_game_details activityId, QueryString.language

      Linguazone.App.customizer.show view

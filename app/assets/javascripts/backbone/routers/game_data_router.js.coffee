class Linguazone.Routers.GameDataRouter extends Backbone.Router
  initialize: (options) ->
    @gameData = new Linguazone.Collections.GameDataCollection()
    @gameData.reset options.gameData

  routes:
    "new"      : "newGameData"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newGameData: ->
    @view = new Linguazone.Views.GameData.NewView(collection: @game_data)
    $("#game_data").html(@view.render().el)

  index: ->
    @view = new Linguazone.Views.GameData.IndexView(game_data: @game_data)
    $("#game_data").html(@view.render().el)

  show: (id) ->
    game_data = @game_data.get(id)

    @view = new Linguazone.Views.GameData.ShowView(model: game_data)
    $("#game_data").html(@view.render().el)

  edit: (id) ->
    game_data = @game_data.get(id)

    @view = new Linguazone.Views.GameData.EditView(model: game_data)
    $("#game_data").html(@view.render().el)

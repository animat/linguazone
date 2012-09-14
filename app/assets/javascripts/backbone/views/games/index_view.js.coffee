Linguazone.Views.GameData ||= {}

class Linguazone.Views.GameData.IndexView extends Backbone.View
  template: JST["backbone/templates/game_data/index"]

  initialize: () ->
    @options.gameData.bind('reset', @addAll)

  addAll: () =>
    @options.gameData.each(@addOne)

  addOne: (gameData) =>
    view = new Linguazone.Views.GameData.GameDataView({model : gameData})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(gameData: @options.gameData.toJSON() ))
    @addAll()

    return this

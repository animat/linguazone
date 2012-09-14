Linguazone.Views.GameData ||= {}

class Linguazone.Views.GameData.ShowView extends Backbone.View
  template: JST["backbone/templates/game_data/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

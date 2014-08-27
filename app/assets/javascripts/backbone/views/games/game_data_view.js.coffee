Linguazone.Views.GameData ||= {}

class Linguazone.Views.GameData.GameDataView extends Backbone.View
  template: JST["backbone/templates/game_data/game_data"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

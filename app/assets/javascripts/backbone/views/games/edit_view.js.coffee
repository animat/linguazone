Linguazone.Views.GameData ||= {}

class Linguazone.Views.GameData.EditView extends Backbone.View
  template : JST["backbone/templates/game_data/edit"]

  events :
    "submit #edit-game_data" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (game_data) =>
        @model = game_data
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this

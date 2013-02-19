class Linguazone.Models.Option extends Backbone.Model

class Linguazone.Collections.OptionCollection extends Backbone.Collection
  update_from: (words) ->
    words = _.map(words, (word) -> new Linguazone.Models.Option({text: word}))
    @update(words)

  to_select_to: ->
    x = 1
    array = []
    _.each @models, (model) ->
      array.push {id: x, text: model.get("text")}
    array

  to_a: ->
    _.map @models, (model) -> model.get("text")

Linguazone.OptionLists = ->
  rv = []
  for name, collection of Linguazone.Options
    obj = {}
    obj[name] = collection.to_a()
    rv.push obj
  rv


class Linguazone.Models.Word extends Backbone.Model

class Linguazone.Collections.WordCollection extends Backbone.Collection
  update_from: (words) ->
    words = _.map(words, (word) -> new Linguazone.Models.Word({text: word}))
    @update(words)

  to_select_to: ->
    x = 1
    array = []
    _.each @models, (model) ->
      array.push {id: x, text: model.get("text")}
    array

  to_a: ->
    _.map @models, (model) -> model.get("text")

Linguazone.WordLists = ->
  rv = []
  for name, collection of Linguazone.Words
    obj = {}
    obj[name] = collection.to_a()
    rv.push obj
  rv


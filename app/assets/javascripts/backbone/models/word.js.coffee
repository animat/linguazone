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

class Linguazone.Collections.ExampleCollection extends Backbone.Collection
  model: Linguazone.Models.Example
  url:   "/examples"
  getExampleHash: ->
    _.object(_.map @models, (e) -> e.getKeyValue())

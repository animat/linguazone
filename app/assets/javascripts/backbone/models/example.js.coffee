class Linguazone.Models.Example extends Backbone.Model
  urlRoot: '/examples'
  getKeyValue: ->
    [@get("node_key_name"),  @get("node_value")]

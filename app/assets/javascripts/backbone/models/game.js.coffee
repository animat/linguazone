class Linguazone.Models.Game extends Backbone.Model
  url: '/game_data'
  paramRoot: 'game'

  initialize: ->
     @set("nodes",  new Linguazone.Collections.NodeCollection)
     @get("nodes").add new Linguazone.Models.Node

  defaults:
    activity_id: null

class Linguazone.Collections.GameCollection extends Backbone.Collection
  model: Linguazone.Models.Game
  url: '/game'

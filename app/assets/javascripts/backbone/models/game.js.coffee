class Linguazone.Models.Game extends Backbone.Model
  paramRoot: 'game'

  defaults:
    activity_id: null

class Linguazone.Collections.GameCollection extends Backbone.Collection
  model: Linguazone.Models.Game
  url: '/game'

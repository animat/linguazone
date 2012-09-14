class Linguazone.Models.Node extends Backbone.Model
  defaults:
    "question":  "",
    "response":  ""

  url: '/gamedata/'
  validate: (attrs) ->
      return "cannot have an empty response" unless attrs.response
      return "cannot have an empty question" unless attrs.question


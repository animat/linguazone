class Linguazone.Models.Node extends Backbone.Model
  # extract this to base class if we need it again
  set: (attr, value) ->
    value = $.trim(value)
    super attr, value

  defaults:
    "question":  "",
    "response":  ""

  url: '/gamedata/'

  validation_errors: () ->
      return "Can not have an empty response" unless @get("response")
      return "Can not have an empty question" unless @get("question")

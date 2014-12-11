class Linguazone.Models.Node extends Backbone.Model
  # extract this to base class if we need it again
  set: (attr, value) ->
    value = $.trim(value)
    super attr, value

  defaults: "question":  ""
  url: '/gamedata/'

  validation_errors: () ->
      return "Can not have an empty question" unless @get("question")

class Linguazone.Models.AnswerAndMatchNode extends Linguazone.Models.Node

class Linguazone.Models.TwoAnswerAndMatchNode extends Linguazone.Models.Node

class Linguazone.Models.SingleWordMatchNode extends Linguazone.Models.Node

class Linguazone.Models.DoubleWordMatchNode extends Linguazone.Models.Node
  defautls: 
    "question": "",
    "match1": "",
    "match2": ""

class Linguazone.Models.TargetWordNode extends Linguazone.Models.Node
  defaults:
    "question": ""

class Linguazone.Models.MultipleAnswerNode extends Linguazone.Models.Node
  defaults:
    "question": ""

class Linguazone.Models.OneToOneNode extends Linguazone.Models.Node
  defaults:
    "question":  "",
    "response":  ""

  validation_errors: () ->
      return "Can not have an empty response" unless @get("response")
      super()
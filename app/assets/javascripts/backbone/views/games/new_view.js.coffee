Linguazone.Views.Games ||= {}
class ClassView extends Backbone.Marionette.ItemView
  events:
    "click input" : "toggleSelected"

  template: """
    <input type='checkbox'><%= name %></input>
  """

  toggleSelected: ->
    selected = not @model.get("_selected")
    @model.set("_selected", selected)
    @trigger("selected")

class ClassSelectionView extends Backbone.Marionette.CollectionView
  itemView: ClassView
  class: "classList"

class Linguazone.Views.Games.NewView extends Linguazone.Views.Games.GameFormBaseView
  template: JST["backbone/templates/games/new"]
  events:
    "click #back-to-questions"  : "questionsStep"
    "submit #new-game"          : "metadataStep"
    "click .addNode"            : "addNode"
    "focus .addNode"            : "addNode"
    "click #submit_game"        : "save"
    "change #description_input" : "updateMetadata"

  updateMetadata: =>
    @model.set("description", $("#description_input").val())

  onRender: ->
    super()
    $classes = @$el.find("#available-classes")
    $classes.html("")

    Linguazone.App.execute "when:fetched", @options.courses, =>
      view = new ClassSelectionView
        collection: @options.courses
      $classes.html(view.render().$el)
      @listenTo view, "itemview:selected", =>
        class_ids = @options.courses.filter((c) -> c.get("_selected")).map((c) -> c.get("id"))
        @model.set("class_ids", class_ids)

class Linguazone.Views.Games.MatchingNewView extends Linguazone.Views.Games.GameFormBaseView

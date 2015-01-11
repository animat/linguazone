describe 'Node', ->
  describe 'set', ->
    it "trims every string value", ->
      node = new Linguazone.Models.Node
      node.set("response", " how are you ")
      expect(node.get("response")).toBe("how are you")

describe 'GameData', ->
  it 'can initialize', ->
    game = new Linguazone.Models.Game
    expect(game).toBeTruthy()

  it 'can hydrate nodes from proper json', ->
    json = {"description" : "good game", "nodes":[{"options":[],"response":"dd","question":"asdfasdf"},{"options":[],"response":"gggg","question":"ddd"}]}
    @server = sinon.fakeServer.create()
    @server.respondWith( "GET", "/game_data/13", [ 200, {"Content-Type": "application/json"}, JSON.stringify(json) ])

    game = new Linguazone.Models.Game
      id: 13
    game.fetch()
    @server.respond()
    expect(game.get("description")).toBe("good game")
    expect(game.get("nodes").length).toBe(2)

describe 'Node', ->
  beforeEach ->
    @node = new Linguazone.Models.Node

  it 'can initialize', ->
    expect(@node).toBeTruthy()

  it 'can not save without a question', ->
    @node = new Linguazone.Models.Node({"question": "", "response" : "nope"})
    expect(@node.validation_errors()).toBeTruthy()

describe 'OneToOne Node View', ->
  beforeEach ->
    @node = new Linguazone.Models.Node( { question: { content: { content: "How are you"} } , response: { content: { content: "Good!"} }})
    @nodeView = new Linguazone.Views.Games.OneToOne(node: @node).render()

  it 'renders the question and answer', ->
    expect($(@nodeView.el)).toContainHtml("value=\"How are you\"")
    expect($(@nodeView.el)).toContainHtml("value=\"Good!\"")

  it 'can delete itself', ->
    $el = @nodeView.$el
    $el.remove = sinon.spy()
    $el.find(".delete").trigger("click")
    expect($el.remove.calledOnce).toBeTruthy()
    expect(@nodeView.options.node).not.toBeTruthy()

  it 'updates the node as the answer change', ->
    $answer = $(@nodeView.el).find(".response input")
    $answer.val("Better!")
    $answer.trigger("change")
    $answer.trigger("blur")
    expect(@nodeView.options.node.get("response")).toBe "Better!"

describe "Views.Games.MultipleAnswer", ->
  beforeEach ->
    @view = new Linguazone.Views.Games.MultipleAnswer
      node: new Linguazone.Models.Node
    @view.render()

  it "can run through the wizard", ->
    @view.$el.find(".question").val("Gato")
    @view.$el.find(".step-1 .next").click()

    @view.$(".step-2 textarea").val("cat\ndog").trigger("blur")
    @view.$el.find(".step-2 .next").click()

    @view.$(".step-3 .response").val("cat").trigger("blur")
    @view.$el.find(".step-3 .next").click()

    expect(@view.$(".value_cat")).toHaveClass("correct_answer")

  describe "Linguazone.Views.Games.Preview", ->
    beforeEach ->
      @view = new Linguazone.Views.Games.Preview
        model: new Backbone.Model
          question: "what is up"
          options: "cool,dude"
      @view.render()

    it "renders the question", ->
      expect(@view.$(".preview_question")).toHaveText("what is up")

describe 'Customizer', ->
  describe "when presented with game data", ->
    beforeEach ->
      loadFixtures('edit.html')
      @server = sinon.fakeServer.create()
      Linguazone.init()
      @server.requests[0].respond( 200, { "Content-Type": "application/json" }, '{"nodes":[{"options":[],"response":"asdfasdfs","question":""},{"options":[],"response":"asdfasdf","question":""},{"options":[],"response":"sadf","question":""}],"game_type":"TargetWord"}')

    afterEach ->
      @server.restore()

    it "loads the game", ->
      expect(window.Linguazone.AppView.model.get("game_type")).toBe("TargetWord")

  describe "selecting an activity", ->
    beforeEach ->
      loadFixtures('activity.html')
      Linguazone.init()
      $("#link1").trigger("click")

    it "hides other activity divs", ->
      expect($("#activity2")).toBeHidden()
      expect($("#activity1")).toBeVisible()

    it "hides the clicked link", ->
      expect($("#link1")).toBeHidden()

    it "sets the activity id", ->
      game_data = window.Linguazone.AppView.model
      expect(game_data.get("activity_id")).toBe 95

    it "creates a customizer view", ->
      expect($("#customizer")).toContainHtml("Add another")

    it "passes the activity type to the game", ->
      expect(window.Linguazone.AppView.model.get("game_type")).toBe("OneToOne")

# this is a little integrationy?  but only client side.
describe "Customizer", ->
  beforeEach ->
    loadFixtures('activity.html')
    Linguazone.init()
    $("#link1").trigger("click")

  it "updates the nodes in GameData", ->
    $(".question input").val("Niño")
    $(".response input").val("Child")
    $("a.addNode").click()
    game_data = window.Linguazone.AppView.model
    expect(game_data.get("nodes").length).toBe 2

  it "can delete a node", ->
    $(".question input").val("Niño")
    $(".response input").val("Child")
    $("a.addNode").click()
    $(".delete").last().click()
    game_data = window.Linguazone.AppView.model
    expect(game_data.get("nodes").length).toBe 1

  it "submits to ajax", ->
    @spy = sinon.stub(jQuery, 'ajax')
    $("input[type='submit']").click()
    expect(@spy.calledOnce).toBeTruthy()
    expect($("form")).toBeHidden()
    expect($("#confirmation")).toContainHtml("Game Created")
    jQuery.ajax.restore()

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
    expect(game.get("nodes").models.length).toBe(2)

describe 'Node', ->
  beforeEach ->
    @node = new Linguazone.Models.Node

  it 'can initialize', ->
    expect(@node).toBeTruthy()

  it 'can not save without a question', ->
    spy = sinon.spy()
    @node.bind("error", spy)
    @node.save({"question": "", "response" : "nope"})
    expect(spy.calledOnce).toBeTruthy()
    expect(spy.calledWith(@node, "cannot have an empty question")).toBeTruthy()

  it 'can not save without a response', ->
    spy = sinon.spy()
    @node.bind("error", spy)
    @node.save({"response": "", "question" : "how are?"})
    expect(spy.calledOnce).toBeTruthy()
    expect(spy.calledWith(@node, "cannot have an empty response")).toBeTruthy()

describe 'OneToOne Node View', ->
  beforeEach ->
    @node = new Linguazone.Models.Node({question: "How are you", response: "Good!"})
    @nodeView = new Linguazone.Views.Games.OneToOne(node: @node).render()

  it 'renders the question and answer', ->
    expect($(@nodeView.el)).toContainHtml("value=\"#{@node.get('question')}\"")
    expect($(@nodeView.el)).toContainHtml("value=\"#{@node.get('response')}\"")

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

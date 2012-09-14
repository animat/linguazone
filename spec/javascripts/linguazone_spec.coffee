describe 'Customizer', ->
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
      expect($("#customizer")).toContainHtml("Your Input")

# this is a little integrationy?  but only client side.
describe "Customizer", ->
  beforeEach ->
    loadFixtures('activity.html')
    Linguazone.init()
    $("#link1").trigger("click")

  it "updates the nodes in GameData", ->
    $(".question input").val("Niño")
    $(".response input").val("Child")
    $("button.addNode").click()
    game_data = window.Linguazone.AppView.model
    expect(game_data.get("nodes").length).toBe 2

  it "submits to ajax", ->
    @spy = sinon.stub(jQuery, 'ajax')
    $("input[type='submit']").click()
    expect(@spy.calledOnce).toBeTruthy()
    expect($("form")).toBeHidden()
    expect($("#customizer")).toContainHtml("Game Created")
    jQuery.ajax.restore()


describe 'GameData', ->
  it 'can initialize', ->
    game = new Linguazone.Models.Game
    expect(game).toBeTruthy()

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

describe 'NodeView', ->
  beforeEach ->
    @node = new Linguazone.Models.Node({question: "How are you", response: "Good!"})
    @nodeView = new Linguazone.Views.Games.NodeView(node: @node).render()

  it 'renders the question and answer', ->
    expect($(@nodeView.el)).toContainHtml("value=\"#{@node.get('question')}\"")
    expect($(@nodeView.el)).toContainHtml("value=\"#{@node.get('response')}\"")

  it 'updates the node as the answer change', ->
    $answer = $(@nodeView.el).find(".response input")
    console.log 'vieeew', $(@nodeView.el)
    console.log $answer
    $answer.val("Better!")
    $answer.trigger("change")
    $answer.trigger("blur")
    expect(@nodeView.options.node.get("response")).toBe "Better!"

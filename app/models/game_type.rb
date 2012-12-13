class GameType
  attr_accessor :questions, :activity

  def initialize
    @questions = []
  end

  Question = Struct.new(:name)
  #TODO: hard coded for OneToOne
  Node = Struct.new(:question, :response)

  def example_node_for(language)
    examples = Example.for(language, self.activity)

    #TODO: hard coded for OneToOne
    question = examples.find{|e| e.question_name.downcase == "question"}
    response = examples.find{|e| e.question_name.downcase == "response"}
    Node.new question.try(:node_input), response.node_input
  end

  def self.for(activity)
    rv = self.send(activity.game_type.underscore)
    rv.activity = activity
    rv
  end

  def self.one_to_one
    rv = self.new
    rv.questions << Question.new("Question")
    rv.questions << Question.new("Answer")
    rv
  end
end

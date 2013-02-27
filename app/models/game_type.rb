class GameType
  attr_accessor :questions, :activity, :lists

  def initialize
    @questions = []
    @lists = []
  end

  Question = Struct.new(:name)
  #TODO: hard coded for OneToOne
  Node = Struct.new(:question, :response)

  def example_node_for(language)
    examples = Example.for(language, self.activity)
    return nil unless examples.length

    question = examples.find{|e| e.question_name.downcase == "question"}
    response = examples.find{|e| e.question_name.downcase == "response"}
    Node.new question.try(:node_input), response.try(:node_input)
  end

  def name
    activity.game_type
  end

  def self.for(activity)
    rv = self.send(activity.game_type.underscore)
    rv.activity = activity
    rv
  end

  def self.target_word
    rv = self.new
    rv.questions << Question.new("Question")
    rv
  end

  def self.one_to_one
    rv = self.new
    rv.questions << Question.new("Question")
    rv.questions << Question.new("Answer")
    rv
  end

  def self.double_word_match
    rv = self.new
    rv.lists = [
      { :linkedto => "ltarget"},
      { :linkedto => "rtarget"}
    ]
    rv
  end

  def self.single_word_match
    rv = self.new
    rv.lists = [
      { :linkedto => "ltarget"}
    ]
    rv
  end
end

module StudyHelper
  
  def format_study_history(study_type)
    case study_type
      when "browse"
        "reviewed the word list"
      when "print"
        "printed the word list"
      when "practice"
        "practiced the word list"
      when "catch"
        "caught the words"
    end
  end
  
end


module CustomizeHelper
  
  def format_cmzr_type(type)
    "bleh"
    if type == "word_list" or type == "list"
      "word list"
    elsif type == "game"
      "game"
    end
  end
  
end
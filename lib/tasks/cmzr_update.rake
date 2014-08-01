namespace :cmzr_upate do
  
  desc "Update database with examples"
  task :add_examples => :environment do
    Example.create!(:language_id => 6, :default => true, :activity_id => 2, :display_label => "Display label for que goes here" :hint => "Hint for que goes here", :question_name => "question")
    Example.create!(:language_id => 6, :default => true, :activity_id => 2, :display_label => "Display label for resp goes here" :hint => "Hint for resp goes here", :question_name => "response")
    puts "Examples have been added successfully at #{Time.now}"
  end
  
  desc "Update database with Activities"
  task :update_node_options => :environment do
     @lf = Activity.where(:name => "Leap Frog").first
     @lf.node_options = "{ 'question': { 'prompt': 'The question a student sees', 'types': ['text', 'image', 'audio'], 'count': 1  }, 'response': { 'prompt': 'The response', 'types': ['text'], 'count': 5  }}"
     @lf.game_type = "OneToOne"
     @lf.save

     @o = Activity.where(:name => "Oracle").first
     @o.node_options = "{ 'question': { 'prompt': 'The question a student sees', 'types': ['text', 'image', 'audio'] }, 'response': { 'prompt': 'The students response', 'minimum': 3, 'maximum': 6, 'types': ['text'] }}"
     @o.game_type = "MultipleAnswer"
     @o.save

     @gg = Activity.where(:name => "Garden Grows").first
     @gg.node_options = "{ 'question': { 'prompt': 'The target word', 'types': ['text'], 'count': 1  }}"
     @gg.game_type = "TargetWord"
     @gg.save

     @bb = Activity.where(:name => "Bathtub Bubbles").first
     @bb.node_options = "{ 'question': { 'prompt': 'The question a student sees', 'types': ['text'], 'count': 1  }, 'match1': { 'prompt': 'First match', 'types': ['text'], 'count': 5  }, 'match2': { 'prompt': 'Second match', 'types': ['text'], 'count': 5  }}"
     @bb.game_type = "SingleWordMatch"
     @bb.save

     @c = Activity.where(:name => "Cliffhanger").first
     @c.node_options = "{ 'question': { 'prompt': 'The question a student sees', 'types': ['text'], 'count': 1  }, 'match1': { 'prompt': 'First match', 'types': ['text'], 'count': 5  }, 'match2': { 'prompt': 'Second match', 'types': ['text'], 'count': 5  }}"
     @c.game_type = "DoubleWordMatch"
     @c.save
     
     @s = Activity.where(:name => "Swish").first
     @s.node_options = "{ 'question': { 'prompt': 'The question a student sees', 'types': ['text'] }, 'lang': { 'prompt': 'The correct student response', 'types': ['text'] }, 'categ': { 'prompt': 'How students should categorize their answer', 'types': ['text']}}"
     @s.game_type = "AnswerAndMatch"
     @s.save
  end
  
en
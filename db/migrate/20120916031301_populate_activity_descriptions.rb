class PopulateActivityDescriptions < ActiveRecord::Migration
  def up
    @at = Activity.find_by_name("Alphabet Tree")
    @at.description = "Name a category that students must match. Fill in items that fit into that category and then a few decoy words to keep your students on their toes!"
    @at.save
    
    @bb = Activity.find_by_name("Bathtub Bubbles")
    @bb.description = "Choose the bubble that corresponds to the word or phrase on the boat."
    @bb.save
    
    @c = Activity.find_by_name("Cliffhanger")
    @c.description = "Choose from the two sets of options to find the answers that match the prompt."
    @c.save
    
    @d = Activity.find_by_name("Downfall")
    @d.description = "Shoot the UFOs that correspond to the prompt."
    @d.save
    
    @f = Activity.find_by_name("Ferris Wheel")
    @f.description = "Choose the letters to spell vocabulary words correctly"
    @f.save
    
    @fish = Activity.find_by_name("Fishing")
    @fish.description = "Find the appropriate match in this one-to-one matching game"
    @fish.save
    
    @gg = Activity.find_by_name("Garden Grows")
    @gg.description = "Given only a fragment, recall and spell the full phrase or term"
    @gg.save
    
    @lf = Activity.find_by_name("Leap Frog")
    @lf.description = "Challenge students to type in words or phrases while the timer is running. Help the frog get to the other side of the pond!"
    @lf.save
    
    @m = Activity.find_by_name("Magnetized")
    @m.description = "Unscramble refrigerator magnets to complete phrases."
    @m.save
    
    @mantis = Activity.find_by_name("Mantis")
    @mantis.description = "Correctly spell out words and phrases to help the Mantis get to her baby."
    @mantis.save
    
    @np = Activity.find_by_name("Number Pop")
    @np.description = "Press the  number keys that correspond to the numbers written in the target language."
    @np.save
    
    @ota = Activity.find_by_name("On the Air")
    @ota.description = "Record audio clips for your students to listen to at any time."
    @ota.save
    
    @o = Activity.find_by_name("Oracle")
    @o.description = "Click on the screen with the correct answer before the Bad Guy squishes all of the little Polyglots!"
    @o.save
    
    @pp = Activity.find_by_name("Poker Pairs")
    @pp.description = "Find the pairs that match in this Concentration-style game with cards."
    @pp.save
    
    @qs = Activity.find_by_name("Quiz Show")
    @qs.description = "Select the correct multiple choice answer to quiz questions."
    @qs.save
    
    @ss = Activity.find_by_name("Sentence Swiper")
    @ss.description = "Ask students to identify individual parts of a sentence"
    @ss.save
    
    @shop = Activity.find_by_name("Shopping")
    @shop.description = "Find the items on the shopping list before time runs out."
    @shop.save
    
    @sling = Activity.find_by_name("Slingshot")
    @sling.description = "Shoot the correct balloon with the slingshot."
    @sling.save
    
    @splat = Activity.find_by_name("Splat")
    @splat.description = "Unscramble the letters correctly to spell words and phrases."
    @splat.save
    
    @swish = Activity.find_by_name("Swish")
    @swish.description = "Type in appropriate answers to questions, then group the answers into basketball hoops for bonus points."
    @swish.save
    
    @thump = Activity.find_by_name("Thumper")
    @thump.description = "Whack the correct answers when they pop up from the ground with your mallet."
    @thump.save
  end

  def down
    @activities = Activity.all
    @activities.each do |a|
      a.description = ""
      a.save
    end
  end
end

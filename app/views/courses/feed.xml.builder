xml.instruct!
xml.rss "version" => "2.0" do
 xml.channel do

   xml.title       "LinguaZone: #{@course.name} at #{@course.user.school.name}"
   xml.link        "http://www.linguazone.com/class/"+String(@course.id)
   xml.description "Games, word lists, and audio blogs for #{@course.name} on LinguaZone.com"

   @showing_posts.each do |sp|
     xml.item do
       xml.title       "[Audio blog] "+sp.post.title
       xml.link        url_for :only_path => false, :controller => 'posts', :action => 'show', :id => sp.id
       xml.description sp.post.content
     end
   end
   
   @showing_word_lists.each do |swl|
      xml.item do
        xml.title       "[Word list] Study your word list"
        xml.link        url_for :only_path => false, :controller => 'study', :action => 'practice', :id => swl.id
        xml.description swl.word_list.description
      end
   end
    
   @showing_games.each do |sg|
       unless sg.game.nil?
         xml.item do
           xml.title      "[Game] Play "+sg.game.activity.name
           xml.link        url_for :only_path => false, :controller => 'play', :action => 'show', :id => sg.id
           xml.description sg.game.description
         end
     end
   end
   
 end
end
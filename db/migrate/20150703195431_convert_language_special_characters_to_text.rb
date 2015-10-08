#encoding: utf-8 
class ConvertLanguageSpecialCharactersToText < ActiveRecord::Migration
  def change
    change_column :languages, :special_characters, :text
    
    @lang = Language.find_by_name("French")
    @lang.special_characters = '<set language="French"><character>à</character><character>â</character><character>ç</character><character>é</character><character>è</character><character>ê</character><character>ë</character><character>î</character><character>ï</character><character>ô</character></set>'
    @lang.save
  end
end

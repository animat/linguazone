#encoding: utf-8 

class CorrectItalianSpecialCharacters < ActiveRecord::Migration
  def change
    @lang = Language.find_by_name("Italian")
    @lang.special_characters = '<set language="Italian"><character>á</character><character>à</character><character>é</character><character>è</character><character>í</character><character>ì</character><character>ó</character><character>ò</character><character>ú</character><character>ù</character></set>'
    @lang.save
  end
end

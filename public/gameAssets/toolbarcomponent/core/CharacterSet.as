import toolbarcomponent.core.*;

class toolbarcomponent.core.CharacterSet {
	private var language:String;
	private var characters:Array;
	
	public function CharacterSet(language:String) {
		this.language = language;
		characters = new Array();
	}
	
	public function addCharacter(char:String):Void {
		characters.push(char.toString());
	}
	
	
	public function getLanguage():String {
		return language;
	}
	public function getCharacters():Array {
		return characters;
	}
}
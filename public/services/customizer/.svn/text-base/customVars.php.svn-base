<?php

include_once('../include.php');

if (isset($_REQUEST['userid'])) {
	$userId = $_REQUEST['userid'];
}

// Data request by the original Customizer
if ((isset($_POST['action']) || isset($_GET['action'])) && !isset($_GET['listid'])) {
	if (isset($_POST['action']) && $_POST['action'] == 'new') {
   		$gameid = saveNewGameXML($handle, $_POST['infoid'], $_POST['templateid'], $_POST['langid'], $userId);
   		saveGameXML($handle, $gameid, $_POST['template_xml'], $_POST['gamedata_xml'], $_POST['gamedescription'], $_POST['keywords'], false, $userId);
   		echo "msg=Your new game has been created!&new_gameid=$gameid";
   	
 	} else if (isset($_POST['action']) && $_POST['action'] == 'edit') {
   		saveGameXML($handle, $_POST['gameid'], $_POST['template_xml'], $_POST['gamedata_xml'], $_POST['gamedescription'], $_POST['keywords'], false, $userId);
   		echo "msg=Your updates have been saved.";
 
 	} else {
   		buildGameXML($handle);
	}
} 

// Data request by LZX Customizer for a GAME
else if (isset($_REQUEST['cmzrtype']) && $_REQUEST['cmzrtype'] == "game") {
	if (isset($_REQUEST['create'])) {
		$templateid = saveNewTemplateXML($handle, $_REQUEST['gameinfoid'], $_REQUEST['languageid'], $userId);
		$gameid = saveNewGameXML($handle, $_REQUEST['gameinfoid'], $templateid, $_REQUEST['languageid'], $userId);
		saveGameXML($handle, $gameid, $_REQUEST['templatebranch'], $_REQUEST['gamedatabranch'], $_REQUEST['descriptext'], $_REQUEST['descripkeys'], $_REQUEST['classes'], $userId);
		
		if ($_REQUEST['audiofiles']) {
			saveNewAudioFiles($handle, $_REQUEST['audiofiles'], $gameid);
		}
		if ($_REQUEST['deleteaudiofiles']) {
			deleteAudioFiles($handle, $_REQUEST['deleteaudiofiles']);
		}
		if ($_REQUEST['activeaudiofiles']) {
			saveActiveAudioFiles($handle, $_REQUEST['activeaudiofiles'], $gameid);
		}
		
		successFeedback($gameid);
		
	} else if (isset($_REQUEST['edit'])) {
		saveGameXML($handle, $_REQUEST['gameid'], $_REQUEST['templatebranch'], $_REQUEST['gamedatabranch'], $_REQUEST['descriptext'], $_REQUEST['descripkeys'], $_REQUEST['classes'], $userId);
		
		if ($_REQUEST['audiofiles']) {
			saveNewAudioFiles($handle, $_REQUEST['audiofiles'], $_REQUEST['gameid']);
		}
		if ($_REQUEST['deleteaudiofiles']) {
			deleteAudioFiles($handle, $_REQUEST['deleteaudiofiles']);
		}
		if ($_REQUEST['activeaudiofiles']) {
			saveActiveAudioFiles($handle, $_REQUEST['activeaudiofiles'], $_REQUEST['gameid']);
		}
		
		successFeedback($_REQUEST['gameid']);
		
	}
}

// Data request by LZX Customizer for a LIST
else if (isset($_REQUEST['cmzrtype']) && $_REQUEST['cmzrtype'] == "list") {
	if (isset($_REQUEST['create'])) {
		$listid = saveNewListXML($handle, $_REQUEST['languageid'], $userId);
		saveListXML($handle, $listid, $_REQUEST['gamedatabranch'], $_REQUEST['descriptext'], $_REQUEST['descripkeys'], $_REQUEST['classes'], $_REQUEST['activatenewgames'], $userId);
		successFeedback($listid);
		
	} else if (isset($_REQUEST['edit'])) {
		saveListXML($handle, $_REQUEST['listid'], $_REQUEST['gamedatabranch'], $_REQUEST['descriptext'], $_REQUEST['descripkeys'], $_REQUEST['classes'], $_REQUEST['activatenewgames'], $userId);
		successFeedback($_REQUEST['listid']);
	} else {
		buildListXML($handle);
	}
}

// LZX Customizer editing a LIST
else if (isset($_GET['action']) && $_GET['action'] == "edit" && isset($_GET['listid'])) {
	buildListXML($handle);
}

// LZX Customizer requesting classes for a game
else if (isset($_GET['getClasses']) && $_GET['getClasses'] == 'true' && $_GET['type'] == 'game') {
	getAllGameClassesForTeacher($handle, $userId, $_GET['gameid']);
}

// LZX Customizer requesting classes for a word list
else if (isset($_GET['getClasses']) && $_GET['getClasses'] == 'true' && $_GET['type'] == 'list') {
	getAllListClassesForTeacher($handle, $userId, $_GET['listid']);
}

else if (isset($_GET['viewWordListToGamesCheckboxes']) && $_GET['viewWordListToGamesCheckboxes'] == 'true') {
	viewWordListToGamesCheckboxes($handle, $_GET['list_id']);
}

// LZX Customizer or audio-widget.swf requesting new audio ID
else if (isset($_GET['getNewAudioID']) && $_GET['getNewAudioID'] == 'true') {
	getNewAudioID($handle);
}

else {
  die("msg=Please don't call this page with a proper action ;)");
}




//-----------------------------------
//  NEW GAME
//-----------------------------------


// copies the prototype game's info and creates a new description entry for the new game
// game's format never changes and is copied directly from the prototype
// template is added on the fly during saving when determined if it is modified
// keywords are removed from the table and added as new each time, since they share gameid
function saveNewGameXML($handle, $infoid, $templateid, $langid, $userId) {
  $gamedata = "<gamedata></gamedata>";

  // create a new game with it
  $I = "INSERT INTO games (template_id, xml, activity_id, language_id, created_at, created_by_id, updated_by_id) ";
  $V = "VALUES ($templateid, '$gamedata', $infoid, $langid, '".date('Y-m-d H:i:s')."', ".$userId.", ".$userId.");";
  queryOrdie($handle, $I.$V);
  
  // store the new gameid for near-future reference
  $gameid = mysql_insert_id();
  
  // create a new entry in the available_games table so they show up in the user's account
  $I = "INSERT INTO available_games (game_id, user_id) ";
  $V = "VALUES ($gameid, ".$userId.");";
  queryOrdie($handle, $I.$V);
  
  return $gameid;
}

function saveNewTemplateXML($handle, $infoid, $langid, $userId) {
	$I = "INSERT INTO templates (activity_id, language_id, user_id) ";
	$V = "VALUES ('$infoid', '$langid', '$userId');";
	//$V = "VALUES ($infoid, $langid, 30)";
	queryOrdie($handle, $I.$V);
	
	$templateid = mysql_insert_id();
	
	return $templateid;
}

//-----------------------------------
// -----------NEW LIST------------
// Same as the method above, except now used for new LISTS
function saveNewListXML($handle, $langid, $userId) {
  $xml = "<gamedata></gamedata>";

  // create a new game with it
  $I = "INSERT INTO word_lists (xml, language_id, created_at, updated_at, created_by_id, updated_by_id) ";
  $V = "VALUES ('$xml', '$langid', '".date('Y-m-d H:i:s')."', '".date('Y-m-d H:i:s')."', ".$userId.", ".$userId.");";
  queryOrdie($handle, $I.$V);
  
  // store the new gameid for near-future reference
  $listid = mysql_insert_id();
  
  // create a new entry in the available_word_lists table so they show up in the user's account
  $I = "INSERT INTO available_word_lists (word_list_id, user_id) ";
  $V = "VALUES ($listid, ".$userId.");";
  queryOrdie($handle, $I.$V);
  
  return $listid;
}

//-----------------------------------
//  LOAD GAME
//-----------------------------------


/*
  general inner composition:
    $format         = "format section";
    $description    = "description *and* keywords";
    $questionData   = "gamedata, all questions, options and answers";
    $customData     = "global game data, templates";
*/

// creates the complete xml file
function buildGameXML($handle)  {  
  if (isset($_GET['gameid']) || isset($_GET['infoid'])) {
  
    if ($_GET['action'] == "new") {
      // build xml with new game and template
      $gamedata = db_buildGameXMLdata($handle, $_GET['infoid'], $_GET['templateid'], $_GET['langid']);
      $gamexmldata = "<gamedata></gamedata>";
	  $description = "";
      //$description = $gamedata->template_descrip;
      $language = getLanguageById($handle, $_GET['langid']);

    } else if ($_GET['action'] == "edit") {
		$gamedata = db_getGameXMLdata($handle, $_GET['gameid']);
	    $keywords = db_getKeywords($handle, $_GET['gameid']);
		$gamexmldata = $gamedata->xml;
	    $description = stripslashes( $gamedata->description );
	    $language = getLanguageById($handle, $gamedata->language_id);
	  
	} else if ($_GET['action'] == "play") {
		// used for playing the games, will do the same thing as edit, except scramble the question order
		$gamedata = db_getGameXMLdata($handle, $_GET['gameid']);
		$keywords = db_getKeywords($handle, $_GET['gameid']);
		$gamexmldata = $gamedata->xml;
     	$description = stripslashes( $gamedata->description );
      	$language = getLanguageById($handle, $gamedata->language_id);
            
    } else {
      die("msg=Please don't call this page with either action 'new', 'edit', or 'play'");
    }
    
  } else {
    die("msg=Please don't call this page without a gameid or infoid ;)");
  }
  
  // Print out the formatted XML to the page  
  $printXML = '<?xml version="1.0" encoding="utf-8"?>'; 
  $printXML .= '<xml>';
  $printXML .= '<format gamename="'.$gamedata->name.'">';
  $printXML .= '</format>';  
  $printXML .= createDescriptionBlock($description, $keywords);
  $printXML .= $gamexmldata;
  $printXML .= $gamedata->template_xml;
  $printXML .= '<language>'.$language.'</language>';
  $printXML .= '</xml>';
  
  if ($_GET['action'] == "play") {
  	$printXML = scramble($printXML);
  }
  
  echo $printXML;
}

//-----------------------------------
//---------Build List XML----------
function buildListXML($handle)  {  
    if ($_GET['action'] == "new") {
      // build xml with new game and template
      $listxmldata = "<gamedata></gamedata>";
	  $keywords = "";
	  $description = "";
	  $langid = $_GET['lang'];

    } else if ($_GET['action'] == "edit") {
      $listdata = db_getListXMLdata($handle, $_GET['listid']);
      $keywords = db_getListKeywords($handle, $_GET['listid']);
      $listxmldata = $listdata->xml;
      $description = $listdata->description;
	  $langid = $listdata->language_id;
	      
    } else {
      die("msg=Please don't call this page with either action new, or edit");
    }
  $language = getLanguageById($handle, $langid);

  // Print out the formatted XML to the page  
  $printXML = '<?xml version="1.0" encoding="utf-8"?>'; 
  $printXML .= '<xml>';
  $printXML .= '<format gamename="Word list" wordlist="true">';
  $printXML .= '<attribute name="english" label="Native term" type="editbox" interactive="true" /><attribute name="lang" label="Target language" type="editbox" interactive="true" />';
  $printXML .= '</format>'; 

  $printXML .= createDescriptionBlock($description, $keywords);
  $printXML .= $listxmldata;
  $printXML .= '<templatedata></templatedata>';
  $printXML .= '<language>'.$language.'</language>';
  $printXML .= '</xml>';

  echo $printXML;

}


// Search the database for metadata on given game
function db_buildGameXMLdata($handle, $infoid, $templateid, $langid) {
  $S = "SELECT activities.name, templates.description, templates.xml "; 
  $F = "FROM activities, templates ";
  $W = "WHERE activities.id = ".$infoid." ";
  $A1 = "AND templates.id = ".$templateid.";";

  $result = queryOrdie($handle, $S.$F.$W.$A1);
  $record = mysql_fetch_object($result);
  return $record;
}

// Search the database for metadata on given game
function db_getGameXMLdata($handle, $gameid) {
  $S = "SELECT games.xml, games.description, games.language_id, activities.name, templates.xml as template_xml "; 
  $F = "FROM games, activities, templates ";
  $W = "WHERE games.id = ".$gameid." ";
  $A1 = "AND activities.id = games.activity_id ";
  $A2 = "AND templates.id = games.template_id;";

  $result = queryOrdie($handle, $S.$F.$W.$A1.$A2);
  $record = mysql_fetch_object($result);
  return $record;
}
//-----------------------------------
//-------Get List XML data--------
function db_getListXMLdata($handle, $listid) {
  $S = "SELECT word_lists.xml, word_lists.description, word_lists.language_id "; 
  $F = "FROM word_lists ";
  $W = "WHERE word_lists.id = ".$listid.";";
  
  $result = queryOrdie($handle, $S.$F.$W);
  $record = mysql_fetch_object($result);
  return $record;
}

// Search the database for metadata on given game
function db_getKeywords($handle, $gameid) {
	// *** TODO : Re-insert keyword functionality to customizer
  /*$S = "SELECT keyword FROM games_keywords ";
  $W = "WHERE game_id = ".$gameid.";";
  return queryOrdie($handle, $S.$W);*/
}
//-----------------------------------
//-------Get list keywords--------
function db_getListKeywords($handle, $listid) {
	// *** TODO : Re-insert keyword functionality to customizer
  /*$S = "SELECT keyword FROM word_lists_keywords ";
  $W = "WHERE word_list_id = '$listid';";
  return queryOrdie($handle, $S.$W);*/
}


//-----------------------------------
//  SAVE GAME
//-----------------------------------
function saveGameXML($handle, $gameid, $template_xml, $gamedata_xml, $gamedescription, $keywords, $classids, $userId) {
  saveTemplate($handle, $gameid, $template_xml, $userId);
  saveGameinfo($handle, $gameid, $gamedescription, split(",", $keywords));
  saveGamedata($handle, $gameid, $gamedata_xml, $userId);
  saveActiveClasses($handle, $classids, $gameid, $userId);
}
//-----------------------------------
//----------Save List XML---------
function saveListXML($handle, $listid, $xml, $descrip, $keywords, $classids, $activategameids, $userId) {
	saveListinfo($handle, $listid, $descrip, split(",", $keywords));
	saveListdata($handle, $listid, $xml, $userId);
	$query = "SELECT game_id FROM games_word_lists WHERE word_list_id = '$listid'";
	$result = $handle->query($query);
	while ($row = $handle->fetchArray($result)) {
		saveGamedata($handle, $row['game_id'], $xml, $userId);
	}
	if ($activategameids != false) {
		activateNewGamesFromWordList($handle, $activategameids, $listid, $userId);
	}
	saveActiveClassesList($handle, $classids, $listid, $userId);
}


// store the game's customdata as a new template if necessary
function saveTemplate($handle, $gameid, $template_xml, $userId) {
  
  if ($template_xml == "undefined") {
  	$template_xml = "<templatedata />";
  }

  // gather current template's general info
  $S = "SELECT t.id, t.activity_id, t.language_id FROM templates t, games g ";
  $W = "WHERE g.template_id = t.id "; 
  $A = "AND g.id=".$gameid.";";
  $result = queryOrdie($handle, $S.$W.$A);
  $record = mysql_fetch_object($result);
  
  // create new template for the game
  $I = "INSERT INTO templates (activity_id, language_id, user_id, xml) ";
  $V = "VALUES ($record->activity_id, $record->language_id, '$userId', '$template_xml');";
  queryOrdie($handle, $I.$V);
  
  $newTemplateId = mysql_insert_id();
  
  // delete the old template (as long as it isn't an admin template)
  $D = "DELETE FROM templates ";
  $W = "WHERE id='$record->id'";
  $A = "AND admin=0;";
  queryOrdie($handle, $D.$W.$A);
  
  // update the game's templateid
  $U = "UPDATE games ";
  $S = "SET template_id = $newTemplateId ";
  $W = "WHERE id = $gameid;";  
  queryOrdie($handle, $U.$S.$W);
}


// store the game's description and its keywords
function saveGameinfo($handle, $gameid, $gamedescription, $keywords) {
  $descrip = stripslashes( $descrip );
  $descrip = mysql_real_escape_string( $gamedescription );
  $U = "UPDATE games ";
  $S = "SET description = '$descrip' ";
  $W = "WHERE id = $gameid;";
  queryOrdie($handle, $U.$S.$W);
  
	// *** TODO : Re-insert keyword functionality to customizer
/*
  // keywords, delete old ones first
  $D = "DELETE FROM games_keywords ";
  $W = "WHERE game_id = '$gameid';";
  queryOrdie($handle, $D.$W);
 
  // add new keywords
  foreach ($keywords as $keyword) {
	if ($keyword != "" && $keyword != null && $keyword != "null") {
	  $I = "INSERT INTO games_keywords (game_id, keyword) ";
   	  $V = "VALUES ($gameid, '$keyword');";
   	  queryOrdie($handle, $I.$V);
    }
  }
*/
}

//-----------------------------------
//---------Save List Info----------
function saveListinfo($handle, $listid, $listdescrip, $keywords) {
  $descrip = stripslashes( $descrip );
  $descrip = mysql_real_escape_string( $listdescrip );
  $U = "UPDATE word_lists ";
  $S = "SET description = '$descrip' ";
  $W = "WHERE id = $listid;";
  queryOrdie($handle, $U.$S.$W);

	// *** TODO : Re-insert keyword functionality to customizer
/*
  // keywords, delete old ones first
  $D = "DELETE FROM word_lists_keywords ";
  $W = "WHERE word_list_id = '$listid';";
  queryOrdie($handle, $D.$W);

  // add new keywords
  foreach ($keywords as $keyword) {
	if ($keyword != "" && $keyword != null && $keyword != "null") {
	  $I = "INSERT INTO word_lists_keywords (word_list_id, keyword) ";
   	  $V = "VALUES ($listid, '$keyword');";
   	  queryOrdie($handle, $I.$V);
    }
  }
*/
}

// store the game's data (questions, answers/options)
function saveGamedata($handle, $gameid, $gamedata_xml, $userId) {
  $U = "UPDATE games ";
  $S = "SET xml = '$gamedata_xml', updated_at=NOW(), updated_by_id='$userId' ";
  $W = "WHERE id = $gameid;";
  queryOrdie($handle, $U.$S.$W);
}
//-----------------------------------
//---------Save List Data----------
function saveListdata($handle, $listid, $xml, $userId) {
	$U = "UPDATE word_lists ";
	$S = "SET xml = '$xml', updated_at=NOW(), updated_by_id='$userId' ";
	$W = "WHERE id = '$listid';";
	queryOrdie($handle, $U.$S.$W);
}


//-----------------------------------
//  SHARED FUNCTIONS
//-----------------------------------

// perform a query and die with a message var return
function queryOrdie($handle, $query) {
  $result = $handle->query($query) or die('<?xml version="1.0" encoding="utf-8"?><error>Failed query: '.$query.'</error>');
  return $result;
}

// given a language id, return the name of the language
function getLanguageById($handle, $id) {
  $S = "SELECT languages.name ";
  $F = "FROM languages ";
  $W = "WHERE languages.id = ".$id.";";
  
  $result = queryOrdie($handle, $S.$F.$W);
  $arr = $handle->fetchArray($result);
  return $arr['name'];
}

// creates the xml section with the description and keywords
function createDescriptionBlock($description, $keywords) {
  $result = "<description>";
  $result .= "<text>".$description."</text>";
  
  if ($keywords != "") {
 	 while ($row = mysql_fetch_array($keywords, MYSQL_ASSOC)) {
 	   $result .= "<keyword>";
 	   $result .= $row['keyword'];
 	   $result .= "</keyword>";
 	 }
  }
  
  $result .= "</description>";
  return $result;
}

// given a game's full XML structure, randomly order the game branches/ nodes
function scramble($xml) {
	$str = "";
	if (!preg_match('|^(.*?)<gamedata>(.*?)</gamedata>(.*)$|s', $xml, $matches)) {
    	print "no match\n";
    }
	preg_match_all('|<(\w+).*?</\1>|s', $matches[2], $items);
	if(!count($items[0]))
    	preg_match_all("|<[^>]*>|", $matches[2], $items);
	$items = $items[0];
	$str .= $matches[1] . "<gamedata>\n";
	shuffle($items);
	for($n = 0 ; $n < count($items) ; $n++) {
		$str .= $items[$n] . "\n";
	}
	$str .= "</gamedata>" . $matches[3];
	return $str;
}

// echo the success feedback message with appropriate id between <msg> tags
function successFeedback($id) {
	echo '<?xml version="1.0" encoding="utf-8"?>';
	echo '<msg>'.$id.'</msg>';
}

// get all of the classes for a given teacher id... not consistently displaying correct results!
function getAllGameClassesForTeacher($handle, $teacherid, $gameid) {
	$query = "SELECT * FROM courses WHERE user_id = '".$teacherid."'";
	$result = $handle->query($query);
	$numRows = $handle->getNumRows($result);
	$msg = '<?xml version="1.0" encoding="utf-8"?>';
	$msg .= '<classes>';
	if ($numRows > 0) {
		while ($row = $handle->fetchArray($result)) {
			$query2 = "SELECT game_id FROM available_games
						WHERE course_id = '".$row['id']."'
						AND game_id = '".$gameid."'";
			$result2 = $handle->query($query2);
			$numRows = $handle->getNumRows($result2);
			if ($numRows > 0) {
				$active = "true";
			} else {
				$active = "false";
			}
			$msg .= '<class classname="'.$row['name'].'" classid="'.$row['id'].'" classactive="'.$active.'" />';
		}
	} else {
		$msg .= '<class classname="You have not created any classes yet" classid="0" />';
	}
	$msg .= '</classes>';
	echo $msg;
}

// Get all of the classes for a given teacher and a given word list
function getAllListClassesForTeacher($handle, $teacherid, $listid) {
	$query = "SELECT * FROM courses WHERE user_id = '".$teacherid."'";
	$result = $handle->query($query);
	$numRows = $handle->getNumRows($result);
	$msg = '<?xml version="1.0" encoding="utf-8"?>';
	$msg .= '<classes>';
	if ($numRows > 0) {
		while ($row = $handle->fetchArray($result)) {
			$query2 = "SELECT word_list_id 
									FROM available_word_lists 
									WHERE course_id = '".$row['id']."' 
									AND word_list_id = '".$listid."'";
			$result2 = $handle->query($query2);
			$numRows = $handle->getNumRows($result2);
			if ($numRows > 0) {
				$active = "true";
			} else {
				$active = "false";
			}
			$msg .= '<class classname="'.$row['name'].'" classid="'.$row['id'].'" classactive="'.$active.'" />';
		}
	} else {
		$msg .= '<class classname="You have not created any classes yet" classid="0" />';
	}
	$msg .= '</classes>';
	echo $msg;
}


function saveActiveClasses($handle, $classids, $gameid, $userId) {
	$query = "DELETE FROM available_games WHERE game_id='".$gameid."' AND course_id != 0";
	$result = $handle->query($query);
	if ($classids != 0) {
		$currArray = split("_", $classids);
		for ($i = 0; $i < count($currArray); $i++) {
			if ($currArray[$i] != '') {
				$temp = $currArray[$i];
				$query2 = "INSERT INTO available_games (game_id, course_id, user_id) 
								VALUES ('".$gameid."', '".$temp."', '".$userId."')";
				$result2 = $handle->query($query2);
			}
		}
	}
}

function saveActiveClassesList($handle, $classids, $listid, $userId) {
	$query = "DELETE FROM available_word_lists WHERE word_list_id = '".$listid."' AND course_id != 0";
	$result = $handle->query($query);
	if ($classids != 0) {
		$currArray = split("_", $classids);
		for ($i = 0; $i < count($currArray); $i++) {
			if ($currArray[$i] != '') {
				$temp = $currArray[$i];
				$query2 = "INSERT INTO available_word_lists (word_list_id, course_id, user_id) 
								VALUES ('".$listid."', '".$temp."', '".$userId."')";
				$result2 = $handle->query($query2);
			}
		}
	}
	
	// Update games made from this list to be active in the appropriate classes 
	$query = "SELECT game_id FROM games_word_lists WHERE word_list_id='$listid'";
	$result = $handle->query($query);
	while ($row = $handle->fetchArray($result)) {
		$query2 = "DELETE FROM available_games WHERE game_id = '".$row['game_id']."'";
		$result2 = $handle->query($query2);
		for ($i = 0; $i < count($currArray); $i++) {
			$query3 = "INSERT INTO available_games (game_id, user_id, course_id)
									VALUES ('".$row['game_id']."', '".$userId."', '".$currArray[$i]."')";
			$result3 = $handle->query($query3);
		}
	}
}

function activateNewGamesFromWordList($handle, $gameinfoids, $listid, $userId) {
	$gameInfoIdsArray = split("_", $gameinfoids);
	for ($i = 0; $i < count($gameInfoIdsArray); $i++) {
		if ($gameInfoIdsArray[$i] != null) {
			$alreadyInDB = findActiveGameId($handle, $listid, $gameInfoIdsArray[$i]);
			if ($alreadyInDB == 0) {
				convertGameFromList($handle, $gameInfoIdsArray[$i], $listid);
			}
		}
	}
}

// *** Heads up: The following function is duplicated from /teachers/_backend/backend-lists.php
function convertGameFromList($handle, $infoid, $listid) {
	// Find and store info on the given list from the LISTS TABLE
	$getQuery = "SELECT xml, description, language_id, created_at, created_by_id, updated_by_id 
					FROM word_lists 
					WHERE id='$listid'";
	$getResult = $handle->query($getQuery);
	$arr = $handle->fetchArray($getResult);
	
	$listXML = $arr['xml'];
	$listDescrip = stripslashes( $listDescrip );
	$listDescrip = mysql_real_escape_string($arr['description']);
	$listLang = $arr['language_id'];
	$listCreated = $arr['created_at'];
	$listCreatedBy = $arr['created_by_id'];
	
	// Store tempalte XML data, too
	$templateXML = "<templatedata/>";
	
	// Duplicate the TEMPLATES row, store new template ID number
	$insertTemplateQuery = "INSERT INTO templates (admin, activity_id, language_id, user_id, xml) VALUES ('0', '$infoid', '$listLang', '$listCreatedBy', '$templateXML')";
	$insertTemplateResult = $handle->query($insertTemplateQuery) OR die("mysql failed: ". mysql_error());
	$templateId = mysql_insert_id();
	
	// Duplicate GAMES row, using the new template ID number. Store new game ID number
	$insertQuery = "INSERT INTO games (template_id, xml, description, activity_id, language_id, 
										created_at, updated_at, created_by_id, updated_by_id)
							VALUES ('$templateId', '$listXML', '$listDescrip', '$infoid', '$listLang', 
										NOW(), NOW(), '$listCreatedBy', '$listCreatedBy')";
	$insertResult = $handle->query($insertQuery) OR die("mysql failed: ". mysql_error());
	$newGameId = mysql_insert_id();
	
	// Insert a new row into available_games to show the teacher they now have this game
	$availQuery = "INSERT INTO available_games (game_id, user_id, course_id)
										VALUES ('$newGameId', '$listCreatedBy', '0')";
	$availResult = $handle->query($availQuery) OR die("mysql failed: ". mysql_error());
	
	// Insert as many rows as needed into the GAMES_KEYWORDS and copy the list's keywords
	// *** TODO : Re-insert keyword functionality to the customizer
	/*$listKeyQuery = "SELECT keyword FROM word_lists_keywords WHERE word_list_id = $listid";
	$listKeyResult = $handle->query($listKeyQuery);
	while ($row = $handle->fetchArray($listKeyResult)) {
		if ($row['keyword'] != "" && $row['keyword'] != null && $row['keyword'] != "null" )
		$copyKeyQuery = "INSERT INTO games_keywords (game_id, keyword) 
											VALUES ('$newGameId', '".$row['keyword']."')";
		$copyKeyResult = $handle->query($copyKeyQuery);
	}*/
	
	// Make an entry into the word lists games linker table
	$linkerQuery = "INSERT INTO games_word_lists (word_list_id, game_id) VALUES ('$listid', '$newGameId')";
	$linkerResult = $handle->query($linkerQuery) OR die("mysql failed: ".mysql_error());
	
	return $newGameId;
}
function viewWordListToGamesCheckboxes($handle, $list_id) {
	$msg = '<?xml version="1.0" encoding="utf-8"?>';
	$msg .= '<games>';

	$convertableGamesQuery = "SELECT id, name FROM activities WHERE convertable = 1 ORDER BY name ASC";
	$convertableGamesResult = $handle->query($convertableGamesQuery);
	while ($row = $handle->fetchArray($convertableGamesResult)) {
		if ($list_id != 0) {
			$gameId = findActiveGameId($handle, $list_id, $row['id']);
		} else {
			$gameId = 0;
		}
		$active = $gameId != 0;
		$msg .= '<game gamename="'.$row['name'].'" gameinfoid="'.$row['id'].'" gameid="'.$gameId.'" activate="'.$active.'" />';
	}

	$msg .= '</games>';
	echo $msg;
}

function findActiveGameId($handle, $list_id, $activity_id) {
	$query = "SELECT wlg.game_id, g.activity_id 
						FROM games_word_lists wlg, games g
						WHERE wlg.word_list_id = '$list_id'
						AND wlg.game_id = g.id
						AND g.activity_id = '$activity_id'";
	$result = $handle->query($query);
	$numRows = $handle->getNumRows($result);
	if ($numRows > 0) {
		$arr = $handle->fetchArray($result);
		return $arr['game_id'];
	} else {
		return 0;
	}
}

function getNewAudioID($handle) {
	if (isset ($_GET['user_id']) && isset($_GET['post_id']) && isset($_GET['comment_id'])) {
		$query = "INSERT INTO audio_clips (user_id, post_id, comment_id, created_at, updated_at) VALUES ('".$_GET['user_id']."', '".$_GET['post_id']."', '".$_GET['comment_id']."', 'NOW()', 'NOW()')";
	} else if (isset($_GET['post_id']) && isset($_GET['comment_id'])) {
		$query = "INSERT INTO audio_clips (post_id, comment_id, created_at, updated_at) VALUES ('".$_GET['post_id']."', '".$_GET['comment_id']."', 'NOW()', 'NOW()')";
	} else if (isset($_GET['post_id'])) {
		$query = "INSERT INTO audio_clips (post_id, created_at, updated_at) VALUES ('".$_GET['post_id']."', 'NOW()', 'NOW()')";
	} else if (isset($_GET['comment_id'])) {
		$query = "INSERT INTO audio_clips (comment_id, created_at, updated_at) VALUES ('".$_GET['comment_id']."', 'NOW()', 'NOW()')";
	} else {
		$query = "INSERT INTO audio_clips (created_at, updated_at) VALUES ('NOW()', 'NOW()')";
	}
	$result = $handle->query($query);
	$id = $handle->getPrimaryKey();
	$printXML = '<?xml version="1.0" encoding="utf-8"?>'; 
	$printXML .= '<xml>';
	$printXML .= '<id>'.$id.'</id>';
	$printXML .= '</xml>';
	echo $printXML;
}

function saveNewAudioFiles($handle, $audioIDstr, $gameid) {
	$audioIDs = split("_", $audioIDstr);
	for ($i = 0; $i < count($audioIDs); $i++) {
		if ($audioIDs[$i] != '') {
			$query = "UPDATE audio_clips SET used_in_games_tally = used_in_games_tally + 1 WHERE id = '".$audioIDs[$i]."'";
			$result = $handle->query($query) or die('<?xml version="1.0" encoding="utf-8"?><error>Could not add audio ID #'.$audioIDs[$i].'</error>');
		}
	}
}

function deleteAudioFiles($handle, $audioIDstr) {
	$audioIDs = split("_", $audioIDstr);
	for ($i = 0; $i < count($audioIDs); $i++) {
		if ($audioIDs[$i] != '') {
			$query = "UPDATE audio_clips SET used_in_games_tally = used_in_games_tally - 1 WHERE id = '".$audioIDs[$i]."'";
			$result = $handle->query($query) or die('<?xml version="1.0" encoding="utf-8"?><error>Could not delete audio ID #'.$audioIDs[$i].'</error>');
		}
	}
}

function saveActiveAudioFiles($handle, $audioIDstr, $gameid) {
	$query = "UPDATE games SET audio_ids = '".$audioIDstr."' WHERE id = '".$gameid."'";
	$result = $handle->query($query) or die ('<?xml version="1.0" encoding="utf-8"?><error>Could store active audio ID numbers</error>');
}

?>
<?php
include_once('include.php');

function getRealIpAddr()
{
    if (!empty($_SERVER['HTTP_CLIENT_IP']))   //check ip from share internet
    {
      $ip=$_SERVER['HTTP_CLIENT_IP'];
    }
    elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))   //to check ip is pass from proxy
    {
      $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
    }
    else
    {
      $ip=$_SERVER['REMOTE_ADDR'];
    }
    return $ip;
}

if (isset($_GET['getInfo']) && isset($_GET['gameid'])) {
	$infoQuery = "SELECT g.description, a.name, a.swf, a.hints_xml, l.special_characters  
					FROM games g, activities a, languages l 
					WHERE g.id = ".$_GET['gameid']."
					AND g.activity_id = a.id
					AND g.language_id = l.id";
	$infoResult = $handle->query($infoQuery);
	$infoArr = $handle->fetchArray($infoResult);
	$descrip = stripslashes ($infoArr['description']);
	$xml = '<?xml version="1.0" encoding="utf-8"?>';
	$xml .= '<gameInfo gameName="'.$infoArr['name'].'" gameSWF="'.$infoArr['swf'].'">';
	$xml .= '<description>'.$descrip.'</description>';
	$xml .= $infoArr['hints_xml'];
	$xml .= $infoArr['special_characters'];
	$xml .= '</gameInfo>';
	echo $xml;
	die();
}

if (isset($_GET['getScores'])) {
	// Track how many scores to list. Default value is 5, but not currently in use!
	if (isset($_GET['numScores'])) {
		$numScore = $_GET['numScores'];
	} else {
		$numScores = 5;
	}
	if (isset($_GET['game_id'])) {
		$query = "SELECT score, user_id FROM high_scores WHERE game_id = '".$_GET['game_id']."' ORDER BY score";
		$result = $handle->query($query) or die ("Could not retrieve scores for that game :: ".mysql_error());
		$xml = '<?xml version="1.0" encoding="utf-8"?>';
		$xml .= '<scores gameid="'.$_GET['game_id'].'">';
		while ($row = $handle->fetchArray($result)) {
			$xml .= '<score name="'.$row['user_id'].'" value="'.$row['score'].'" />';
		}
		$xml .= '</scores>';
		echo $xml;
	} else {
		echo "Could not get scores -- no game id listed.";
	}
	die();
}

if (isset($_REQUEST['score']) && isset($_REQUEST['game_id']) && isset($_REQUEST['user_id'])) {
	$score = $_REQUEST['score'];
	$user_id = $_REQUEST['user_id'];
	$game_id = $_REQUEST['game_id'];
	
	// Check to see if that game has been entered in there already!
	$existing_query = "SELECT id, submitted_at FROM high_scores WHERE user_id='".$_REQUEST['user_id']."' AND game_id='".$_REQUEST['game_id']."'";
	$existing_results = $handle->query($existing_query);
	$add_to_db = true;
	$t1 = strtotime("now");
	while($row = $handle->fetchArray($existing_results)) {
		$t2 = strtotime($row['submitted_at']);
		$diff = $t1 - $t2;
		if ($diff < 5) {
			$add_to_db = false;
		}
	}
	if ($add_to_db) {
		$query = "INSERT INTO high_scores (score, game_id, submitted_at, user_id, user_ip_address) VALUES 
				('$score', '$game_id', NOW(), '$user_id', '".getRealIpAddr()."')";
		$result = $handle->query($query) or die ("Error saving score :: ".mysql_error());
		echo "Your score has been saved and submitted to your teacher.";
	} else {
		echo "Could not save score -- duplicate score in database.";
	}
	
	
} else {
	echo "Could not save score -- was missing some information. (".$row['id'].")";
}

// Share a game:
// 		copy the info in games and templates
//		updatie date and teacher id info
// 		create an entry in the games_available table
//		update the media items
if (isset($_POST['action']) && $_POST['action'] == 'share') {
	
	$userId = $_POST['user_id'];
	
	// Find and store info on the given game from the GAMES TABLE
	$getQuery = "SELECT template_id, xml, description, audio_ids, activity_id, language_id, 
									created_at, created_by_id, updated_by_id 
					FROM games 
					WHERE id='".$_POST['gameid']."'";
	$getResult = $handle->query($getQuery);
	$arr = $handle->fetchArray($getResult);
	
	$gameXML = $arr['xml'];
	$gameDescrip = $arr['description'];
	$gameDescrip = mysql_real_escape_string($gameDescrip);
	$gameAudioIDs = $arr['audio_ids'];
	$gameInfoId = $arr['activity_id'];
	$gameLang = $arr['language_id'];
	$gameCreated = $arr['created_at'];
	$gameCreatedBy = $arr['created_by_id'];
	
	// Find and store the template XML on given game from the TEMPLATES table
	$getTemplateQuery = "SELECT template_xml 
									FROM templates 
									WHERE template_id='".$arr['template_id']."'";
	$getTemplateResult = $handle->query($getTemplateQuery) OR die("mysql failed: ". mysql_error());
	$templateArr = $handle->fetchArray($getTemplateResult);
	
	$templateXML = $templateArr['xml'];
	
	// Duplicate the TEMPLATES row, store new template ID number
	$insertTemplateQuery = "INSERT INTO templates (template_admin, template_game_info_id, template_lang_id, template_user_id, template_xml) 
										VALUES ('0', '".$gameInfoId."', '".$gameLang."', '".$userId."', '".$templateXML."')";
	$insertTemplateResult = $handle->query($insertTemplateQuery) OR die("mysql failed: ". mysql_error());
	$templateId = mysql_insert_id();
	
	// Duplicate GAMES row, using the new template ID number. Store new game ID number
	$insertQuery = "INSERT INTO games (game_template_id, game_xml_data, game_descrip, game_audio_ids, game_info_id, game_language, 
										game_created, game_modified, game_created_by, game_modified_by)
							VALUES ('".$templateId."', '".$gameXML."', '".$gameDescrip."', '".$gameAudioIDs."', '".$gameInfoId."', '".$gameLang."', 
										'".$gameCreated."', NOW(), '".$gameCreatedBy."', '".$userId."')";
	$insertResult = $handle->query($insertQuery) OR die("mysql failed: ". mysql_error());
	$newGameId = mysql_insert_id();
	
	// Insert a new row into GAMES_AVAILABLE to show the teacher they now have this game
	$availQuery = "INSERT INTO games_available (avail_game_id, avail_teacher_id, avail_class_id)
										VALUES ('".$newGameId."', '".$userId."', '0')";
	$availResult = $handle->query($availQuery) OR die("mysql failed: ". mysql_error());
	
	// Update the media table for all audio clips
	if ($gameAudioIDs != "" && $gameAudioIDs != null) {
		$ids = split("_", $gameAudioIDs);
		for ($i = 0; $i < count($ids); $i++) {
			$mediaQuery = "UPDATE media SET used_count = used_count + 1 WHERE id = '".$ids[$i]."'";
			$mediaResult = $handle->query($mediaQuery);
		}
	}
	
	echo $newGameId;
}
?>
<?php
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Class: DbConnector
// Purpose: Connect to MySQL database, execute given queries
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
require_once 'SystemComponent.php';

class dbConnector extends SystemComponent {

  var $the_query;
  var $link;

  //***Connect to the database
  function dbConnector(){
    // Load settings from parent class
    $settings = SystemComponent::getSettings();
    // Get the main settings from the array we just loaded
    $host = $settings['db_host'];
    $db = $settings['db_name'];
    $user = $settings['db_username'];
    $pass = $settings['db_password'];
    // Connect to the database
    $this->link = mysql_connect($host, $user, $pass);
    mysql_select_db($db);
    register_shutdown_function( array( &$this, 'close' ));
  }

  //***Execute a database query
  function query($query) {
    $this->the_query = $query;
    return mysql_query($query, $this->link);
  }

  //***Returns the last database query, for debugging
  function getQuery() {
    return $this->the_query;
  }

  //***Return row count
  function getNumRows($result){
    return mysql_num_rows($result);
  }

  //***Get array of query results
  function fetchArray($result) {
    return mysql_fetch_array($result);
  }
  
  //***Get associative array from query results
  function fetchAssoc($result) {
    return mysql_fetch_assoc($result);
  }
  
  //***Get the primary key ID of the last entry inserted
  function getPrimaryKey() {
  	return mysql_insert_id($this->link);
  }
  
  //***Given the user's ID number, return their full name
  function getUserFullName($user_id) {
  	$user_query = "SELECT user_fname, user_lname FROM users WHERE user_id='$user_id'";
	$user_result = $this->query($user_query);
	$arr = $this->fetchArray($user_result);
	$full_name = $arr['user_fname']." ".$arr['user_lname'];
	return $full_name;
  }
  
  //***Given the user's ID number, return the language that they teach
  function getGameLanguage($game_lang_id) {
  	$lang_query = "SELECT language FROM languages 
					WHERE languages.lang_id = '$game_lang_id'";
	$lang_result = $this->query($lang_query);
	$arr = $this->fetchArray($lang_result);
	return $arr['language'];
  }

  //
  function getLanguage($langid) {
	$query = "SELECT language FROM languages WHERE languages.lang_id = '$langid'";
	$result = $this->query($query);
	$arr = $this->fetchArray($result);
	return $arr['language'];
  }
  
  //***Return the comments on a game in the format: comment1, comment2, ..."
  function getGameDescription($game_id) {
    $descrip_query = "SELECT game_descrip FROM games WHERE game_id = '$game_id'";
    $descript_result = $this->query($comment_query);
	$arr = $this->fetchArray($descrip_result);
	$descrip = stripslashes ($arr['game_descrip']);
	return $descrip;
  }
  
  //***Return the keywords of a game in the format: "keyword1, keyword2, ..."
  function getGameKeywords($game_id) {
  	$keyword_query = "SELECT keyword FROM games_keywords WHERE game_id = '$game_id'";
	$keyword_result = $this->query($keyword_query);
	$keyTotal = $this->getNumRows($keyword_result);
	if ($keyTotal > 1) {
		$str = "";
		for ($i = 0; $i < $keyTotal - 1; $i++) {
			$keyArray = $this->fetchArray($keyword_result);
			if ($keyArray['keyword'] != "") {
				$str .= $keyArray['keyword'].', ';
			}
		}
		$keyArray = $this->fetchArray($keyword_result);
		if ($keyArray['keyword'] != '') {
			$str .= $keyArray['keyword'];
		}
	} else if ($keyTotal == 1) {
		$keyArray = $this->fetchArray($keyword_result);
		if ($keyArray['keyword'] != "") {
			$str .= $keyArray['keyword'];
		}
	} else {
		return "";
	}
	return $str;
  }
  //***Same as above, but for word lists
  function getListKeywords($list_id) {
    $keyword_query = "SELECT keyword  
						FROM word_lists_keywords
						WHERE word_list_id = '$list_id'";
	$keyword_result = $this->query($keyword_query);
	$keyTotal = $this->getNumRows($keyword_result);
	$str = "";
	if ($keyTotal > 1) {
		for ($i = 0; $i < $keyTotal - 1; $i++) {
			$keyArray = $this->fetchArray($keyword_result);
			if ($keyArray['keyword'] != "") {
				$str .= $keyArray['keyword'].', ';
			}
		}
		$keyArray = $this->fetchArray($keyword_result);
		if ($keyArray['keyword'] != '') {
			$str .= $keyArray['keyword'];
		}
	} else if ($keyTotal == 1) {
		$keyArray = $this->fetchArray($keyword_result);
		if ($keyArray['keyword'] != "") {
			$str .= $keyArray['keyword'];
		}
	} else {
		return "";
	}
	return $str;
  }

	//***Return the name of the state given the ID number
	function getStateName($stateID) {
		$query = "SELECT state FROM states WHERE states.state_id = $stateID";
		$result = $this->query($query);
		$arr = $this->fetchArray($result);
		return $arr['state'];
	}
	
	//***Return the name of the school given the ID number
	function getSchoolName($schoolID) {
		$query = "SELECT school FROM schools WHERE schools.school_id = $schoolID";
		$result = $this->query($query);
		$arr = $this->fetchArray($result);
		return $arr['school'];
	}

  //***Close the connection
  function close() {
    if( $this->link ) {
		mysql_close($this->link);
    }
  }

}
?>

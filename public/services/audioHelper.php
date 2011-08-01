<?php

include_once("../includes/include.php");

if ($_GET['findNewID'] == "true") {
	$query = "INSERT INTO media (type) VALUES ('2')";
	$result = $handle->query($query);
	$id = $handle->getPrimaryKey();
	$printXML = '<?xml version="1.0" encoding="utf-8"?>'; 
	$printXML .= '<xml>';
	$printXML .= '<id>'.$id.'</id>';
	$printXML .= '</xml>';
	echo $printXML;
}

if ($_GET['deleteID']) {
	$query = "UPDATE media SET used_count = used_count - 1 WHERE id = ".$_GET['deleteID'];
	$result = $handle->query($query) or die('<?xml version="1.0" encoding="utf-8"?><error>Could not delete audio id #'.$_GET['deleteID'].'</error>');
	echo '<?xml version="1.0" encoding="utf-8"?><msg>Success</msg>';
}

?>
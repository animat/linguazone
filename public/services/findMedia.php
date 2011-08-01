<?php

include_once('php/dbConnector.php');
$handle = new dbConnector();

if (isset($_GET['find'])) {
	if ($_GET['find'] == "all") {
		$query = "SELECT DISTINCT(m.id), name, descrip, path, mt.ext
					FROM medias m
					INNER JOIN media_types mt ON mt.id = m.media_type_id
					WHERE m.published = 1";
	} else if (isset($_GET['cat'])) {
		$query = "SELECT DISTINCT(m.id), m.name, descrip, path, mt.ext
					FROM medias m
					INNER JOIN media_types mt ON mt.id = m.media_type_id
					INNER JOIN media_categories mc ON mc.id = m.media_category_id
					WHERE mc.name = '".$_GET['cat']."'
					AND m.published = 1";
	} else {
		$query = "SELECT DISTINCT(m.id), m.name, m.descrip, m.path, mt.ext
					FROM medias m, media_keywords mk, media_types mt
					WHERE (
						MATCH (m.name, m.descrip) AGAINST ('".$_GET['find']."')
						OR
						MATCH (mk.name) AGAINST ('".$_GET['find']."')
						)
					AND mk.media_id = m.id
					AND mt.id = m.media_type_id
					AND m.published = 1";
	}
	$result = $handle->query($query);
	$printXML = '<?xml version="1.0" encoding="utf-8"?>'; 
	$printXML .= '<xml>';
	while ($row = $handle->fetchArray($result)) {
		$printXML .= '<item name="'.$row['name'].'" path="'.$row['path'].'" type="'.$row['ext'].'" descrip="'.$row['descrip'].'" id="'.$row['id'].'" />';
	}
	$printXML .= '</xml>';
	echo $printXML;
}

if (isset($_GET['category'])) {
	$query = "SELECT * FROM media_categories";
	$result = $handle->query($query);
	$printXML = '<?xml version="1.0" encoding="utf-8"?>';
	$printXML .= '<xml>';
	while ($row = $handle->fetchArray($result)) {
		$query2 = "SELECT COUNT(id) as num FROM medias WHERE media_category_id = '".$row['id']."' AND published = 1";
		$result2 = $handle->query($query2);
		while ($row2 = $handle->fetchArray($result2)) {
			if ($row2['num'] > 0) {
				$printXML .= '<category name="'.$row['name'].'" id="'.$row['id'].'" />';
			}
		}
	}
	$printXML .= '</xml>';
	echo $printXML;
}

?>
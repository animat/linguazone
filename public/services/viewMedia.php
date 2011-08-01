<?php

include_once('../includes/include.php');

$query = "SELECT m.id, name, descrip, path, mt.type FROM media m
			INNER JOIN media_types mt ON mt.id = m.type";
$result = $handle->query($query);
$num = $handle->getNumRows($result);

echo 'Current media assets ('.$num.'):<br />';
echo '<table width="100%" border="1">';
while($row = $handle->fetchArray($result)) {
	echo '<tr>';
	echo '<td>'.$row['id'].'</td>';
	echo '<td>'.$row['type'].'</td>';
	echo '<td>'.$row['descrip'].'</td>';
	echo '<td style="color: blue">';
	$query2 = "SELECT keyword FROM media_keywords WHERE media_id = ".$row['id'];
	$result2 = $handle->query($query2);
	while ($row2 = $handle->fetchArray($result2)) {
		echo $row2['keyword'].', ';
	}
	echo '</td>';
	echo '</tr>';
}
echo '</table>';

?>
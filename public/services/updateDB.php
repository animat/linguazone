<?php

include_once('include.php');
/*
// Update all single teacher subscriptions
$query = "SELECT * FROM users WHERE subscribe_type = 2";
echo $query;
$result = $handle->query($query) or die("ack! ".mysql_error());
echo $handle->getNumRows($result) or die("argh! ".mysql_error());

while($row = $handle->fetchArray($result)) {
	$plan = 1;
	$pin = rand(10000, 99999);
	$created = $row['created_at'];
	$updated = $row['created_at'];
	$expired = $row['expired_at'];
	
	$q = "INSERT INTO subscriptions (subscription_plan_id, pin, created_at, updated_at, expired_at) VALUES ('$plan', '$pin', '$created', '$updated', '$expired')";
	$r = $handle->query($q);
	$sub_id = $handle->getPrimaryKey();
	
	$q = "UPDATE users SET subscription_id = '$sub_id' WHERE id = '".$row['id']."'";
	$r = $handle->query($q);
	
	echo "UPDATED #".$row['id'].'<br />';
}
*/
/*
// Update all trial accounts
$query = "SELECT * FROM users WHERE subscribe_type = 3";
echo $query;
$result = $handle->query($query) or die("ack! ".mysql_error());
echo $handle->getNumRows($result) or die("argh! ".mysql_error());

while($row = $handle->fetchArray($result)) {
	$plan = 9;
	$pin = rand(10000, 99999);
	$created = $row['created_at'];
	$updated = $row['created_at'];
	$expired = $row['expired_at'];
	
	$q = "INSERT INTO subscriptions (subscription_plan_id, pin, created_at, updated_at, expired_at) VALUES ('$plan', '$pin', '$created', '$updated', '$expired')";
	$r = $handle->query($q);
	$sub_id = $handle->getPrimaryKey();
	
	$q = "UPDATE users SET subscription_id = '$sub_id' WHERE id = '".$row['id']."'";
	$r = $handle->query($q);
	
	echo "UPDATED #".$row['id'].'<br />';
}
*/
/*
// Update schoolwide accounts
$query = "SELECT * FROM schools WHERE enabled = 1";
echo $query;
$result = $handle->query($query) or die("ack! ".mysql_error());

while($row = $handle->fetchArray($result)) {
	$pin = $row['pin'];
	$created = $row['created_at'];
	$updated = $row['created_at'];
	$expired = $row['expired_at'];
	
	$teachersQuery = "SELECT * FROM users WHERE school_id = '".$row['id']."'";
	$teachersResult = $handle->query($teachersQuery);
	$numTeachers = $handle->getNumRows($teachersResult);
	if ($numTeachers < 4) {
		$plan = 2;
	} else if ($numTeachers < 7) {
		$plan = 3;
	} else {
		$plan = 4;
	}
	
	$q = "INSERT INTO subscriptions (subscription_plan_id, pin, created_at, updated_at, expired_at) VALUES ('$plan', '$pin', '$created', '$updated', '$expired')";
	$r = $handle->query($q);
	$sub_id = $handle->getPrimaryKey();
	
	while($teachersRow = $handle->fetchArray($teachersResult)) {
		$q = "UPDATE users SET subscription_id = '$sub_id' WHERE id = '".$teachersRow['id']."'";
		$r = $handle->query($q);
		echo "updated user #".$teachersRow['id']."<br />";
	}
	echo "~~~~~UPDATED school subscription #".$row['id'].'<br />';
}


// Update audio recordings into the audio_clips table, not the media table
$query = "SELECT * FROM media WHERE type = 2";
$result = $handle->query($query);
while ($row = $handle->fetchArray($result)) {
	$tally = $row['used_count'];
	echo "found audio id :: #".$row['id']."<br />";
	
	$q2 = "INSERT INTO audio_clips (id, used_in_games_tally) VALUES ('".$row['id']."', '$tally')";
	$r2 = $handle->query($q2);
	
	$q3 = "DELETE FROM media WHERE id = '".$row['id']."'";
	$r3 = $handle->query($q3);
}
*/
/*
// Update posts into the available_posts table
$query = "SELECT * FROM posts";
$result = $handle->query($query);
while ($row = $handle->fetchArray($result)) {
	$q2 = "INSERT INTO available_posts (post_id, user_id, course_id, ordering, hidden) VALUES ('".$row['id']."', '".$row['user_id']."', '".$row['course_id']."', '0', '0')";
	$r2 = $handle->query($q2);
	
	$q3 = "INSERT INTO available_posts (post_id, user_id, course_id, ordering, hidden) VALUES ('".$row['id']."', '".$row['user_id']."', '0', '0', '0')";
	$r3 = $handle->query($q3);
	echo 'Placed update into available_posts...<br />';
}
*/

/*
// Delete duplicate high score entries from Number Pop
$query = "SELECT hs.id, hs.user_id, hs.game_id, hs.submitted_at
			FROM high_scores hs
			INNER JOIN games g ON g.id = hs.game_id
			WHERE g.activity_id = 25
			ORDER BY user_id, game_id, submitted_at";
$result = $handle->query($query);
$totalNum = $handle->getNumRows($result);
$u = "";
$g = "";
$sa = "";
$dupes = 0;
while ($row = $handle->fetchArray($result)) {
	if ($row['user_id'] == $u && $row['game_id'] == $g) {
		$t1 = strtotime($sa);
		$t2 = strtotime($row['submitted_at']);
		$diff = $t2 - $t1;
		if ($diff < 30) {
			echo "<p><em>".$row['user_id']." :: ".$row['game_id']." :: ".$row['submitted_at']."</em> -------- DELETE</p>";
			deleteHS($handle, $row['id']);
			$dupes++;
		} else {
			echo "<p>Keeper :: ".$row['user_id']." :: ".$row['game_id']." :: ".$row['submitted_at']."</p>";
			$u = $row['user_id'];
			$g = $row['game_id'];
			$sa = $row['submitted_at'];
		}
	} else {
		echo "<p>".$row['user_id']." :: ".$row['game_id']." :: ".$row['submitted_at']."</p>";
		$u = $row['user_id'];
		$g = $row['game_id'];
		$sa = $row['submitted_at'];
	}
}

function deleteHS($handle, $id) {
	$q = "DELETE FROM high_scores WHERE id = '$id'";
	$r = $handle->query($q);
}

echo "<br /><br /><br /><p>Complete! Iterated through ".$totalNum." rows and deleted ".$dupes." from the DB.</p>";
*/

$query = "SELECT u.id, u.first_name, u.last_name, u.email
			FROM users u
			WHERE u.email
			IN (
				SELECT email
				FROM users
				GROUP BY email
				HAVING COUNT( email ) >1
			)
			AND u.role = 'student'
			ORDER BY u.email";
$result = $handle->query($query);
$e = "";
$eid = "";
$dupes = 0;
while ($row = $handle->fetchArray($result)) {
	if ($e == $row['email']) {
		echo "<p>Deleting #".$row['id']." ".$row['email']." and changing the values in course high scores and comments to #".$eid."</p>";
		$dupes++;
		$to = $eid;
		$from = $row['id'];
		/*
		// comments
		$cq = "UPDATE comments SET user_id = '$to' WHERE user_id = '$from'";
		$cr = $handle->query($cq);
		// high scores
		$hsq = "UPDATE high_scores SET user_id = '$to' WHERE user_id = '$from'";
		$hsr = $handle->query($hsq);
		// delete course registrations
		$crdq = "DELETE FROM course_registrations WHERE user_id = '$from'";
		$crdr = $handle->query($crdq);
		// delete users
		$udq = "DELETE FROM users WHERE id = '$from'";
		$udr = $handle->query($udq);
		//pointStudentWork($handle, $row['id'], $eid);
		*/
	} else {
		$e = $row['email'];
		$eid = $row['id'];
		echo "<p style='font-size: .7em'>Saving ".$row['id']." ".$row['email']."</p>";
	}
}
/*
function pointStudentWork($handle, $from, $to) {
	// comments
	$cq = "UPDATE comments SET user_id = '$to' WHERE user_id = '$from'";
	$cr = $handle->query($cq);
	// high scores
	$hsq = "UPDATE high_scores SET user_id = '$to' WHERE user_id = '$from'";
	$hsr = $handle->query($hsq);
	// delete course registrations
	$crdq = "DELETE FROM course_registrations WHERE user_id = '$from'";
	$crdr = $handle->query($crdq);
	// delete users
	$udq = "DELETE FROM users WHERE user_id = '$from'";
	$udr = $handle->query($udq);
}
*/
echo "<p>Complete! Deleted ".$dupes." duplicate entries</p>";

?>
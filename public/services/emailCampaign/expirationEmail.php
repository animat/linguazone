<?php

include_once('../includes/include.php');
include_once('emailCampaign.php');
$campaign = new EmailCampaign($handle);

// Trial with one week left
$userQuery = "SELECT u.user_id, u.user_email, u.user_enabled, u.user_fname, u.user_lname, u.user_subscribe_type, u.user_expire_date,
						s.school, s.school_city,
						st.state
				FROM users u, schools s, states st
				WHERE u.user_school_id = s.school_id
				AND s.school_state = st.state_id
				AND u.user_enabled = 1 
				AND u.user_subscribe_type = 3
				AND u.user_expire_date >= ADDDATE(NOW(), INTERVAL 7 DAY) 
				AND u.user_expire_date < ADDDATE(NOW(), INTERVAL 8 DAY)
				ORDER BY u.user_lname ASC";
$userResult = $handle->query($userQuery);
$userNum = $handle->getNumRows($userResult);
if ($userNum > 0) {
	$names = "";
	while ($row = $handle->fetchArray($userResult)) {
		$campaign->emailWeekLeft($row['user_id']);
		$names .= '#'.$row['user_id'].' - '.$row['user_fname'].' '.$row['user_lname'].' ('.$row['user_email'].") \n";
	}
	echo $names;
	$campaign->emailExpirationDetails(7, $names);
}
// Trial with 3 days left
$userQuery = "SELECT u.user_id, u.user_email, u.user_enabled, u.user_fname, u.user_lname, u.user_subscribe_type, u.user_expire_date,
						s.school, s.school_city,
						st.state
				FROM users u, schools s, states st
				WHERE u.user_school_id = s.school_id
				AND s.school_state = st.state_id
				AND u.user_enabled = 1
				AND u.user_subscribe_type = 3
				AND u.user_expire_date >= ADDDATE(NOW(), INTERVAL 3 DAY) 
				AND u.user_expire_date < ADDDATE(NOW(), INTERVAL 4 DAY)
				ORDER BY u.user_lname ASC";
$userResult = $handle->query($userQuery);
$userNum = $handle->getNumRows($userResult);
if ($userNum > 0) {
	$names = "";
	while ($row = $handle->fetchArray($userResult)) {
		$campaign->emailThreeDaysLeft($row['user_id']);
		$names .= '#'.$row['user_id'].' - '.$row['user_fname'].' '.$row['user_lname'].' ('.$row['user_email'].") \n";
	}
	echo $names;
	$campaign->emailExpirationDetails(3, $names);
}

// Single teacher with two weeks left
$userQuery = "SELECT u.user_id, u.user_email, u.user_enabled, u.user_fname, u.user_lname, u.user_subscribe_type, u.user_expire_date,
						s.school, s.school_city,
						st.state
				FROM users u, schools s, states st
				WHERE u.user_school_id = s.school_id
				AND s.school_state = st.state_id
				AND u.user_enabled = 1
				AND u.user_subscribe_type = 2
				AND u.user_expire_date >= ADDDATE(NOW(), INTERVAL 14 DAY) 
				AND u.user_expire_date < ADDDATE(NOW(), INTERVAL 15 DAY)
				ORDER BY u.user_lname ASC";
$userResult = $handle->query($userQuery);
$userNum = $handle->getNumRows($userResult);
if ($userNum > 0) {
	$names = "";
	while ($row = $handle->fetchArray($userResult)) {
		$campaign->emailSingleTwoWeeksLeft($row['user_id']);
		$names .= '#'.$row['user_id'].' - '.$row['user_fname'].' '.$row['user_lname'].' ('.$row['user_email'].") \n";
	}
	echo $names;
	$campaign->emailPaidExpirationDetails('single', 14, $names);
}
// Single teacher with one week left
$userQuery = "SELECT u.user_id, u.user_email, u.user_enabled, u.user_fname, u.user_lname, u.user_subscribe_type, u.user_expire_date,
						s.school, s.school_city,
						st.state
				FROM users u, schools s, states st
				WHERE u.user_school_id = s.school_id
				AND s.school_state = st.state_id
				AND u.user_enabled = 1
				AND u.user_subscribe_type = 2
				AND u.user_expire_date >= ADDDATE(NOW(), INTERVAL 7 DAY) 
				AND u.user_expire_date < ADDDATE(NOW(), INTERVAL 8 DAY)
				ORDER BY u.user_lname ASC";
$userResult = $handle->query($userQuery);
$userNum = $handle->getNumRows($userResult);
if ($userNum > 0) {
	$names = "";
	while ($row = $handle->fetchArray($userResult)) {
		$campaign->emailSingleWeekLeft($row['user_id']);
		$names .= '#'.$row['user_id'].' - '.$row['user_fname'].' '.$row['user_lname'].' ('.$row['user_email'].") \n";
	}
	echo $names;
	$campaign->emailPaidExpirationDetails('single', 7, $names);
}

// Schoolwide with two weeks left
$userQuery = "SELECT u.user_id, u.user_email, u.user_enabled, u.user_fname, u.user_lname, u.user_subscribe_type, u.user_expire_date,
						s.school, s.school_city,
						st.state
				FROM users u, schools s, states st
				WHERE u.user_school_id = s.school_id
				AND s.school_state = st.state_id
				AND u.user_enabled = 1
				AND u.user_subscribe_type = 1
				AND u.user_expire_date >= ADDDATE(NOW(), INTERVAL 14 DAY) 
				AND u.user_expire_date < ADDDATE(NOW(), INTERVAL 15 DAY)
				ORDER BY u.user_lname ASC";
$userResult = $handle->query($userQuery);
$userNum = $handle->getNumRows($userResult);
if ($userNum > 0) {
	$names = "";
	while ($row = $handle->fetchArray($userResult)) {
		$campaign->emailSchoolwideTwoWeeksLeft($row['user_id']);
		$names .= '#'.$row['user_id'].' - '.$row['user_fname'].' '.$row['user_lname'].' ('.$row['user_email'].") \n";
	}
	echo $names;
	$campaign->emailPaidExpirationDetails('schoolwide', 14, $names);
}
// Single teacher with one week left
$userQuery = "SELECT u.user_id, u.user_email, u.user_enabled, u.user_fname, u.user_lname, u.user_subscribe_type, u.user_expire_date,
						s.school, s.school_city,
						st.state
				FROM users u, schools s, states st
				WHERE u.user_school_id = s.school_id
				AND s.school_state = st.state_id
				AND u.user_enabled = 1
				AND u.user_subscribe_type = 1
				AND u.user_expire_date >= ADDDATE(NOW(), INTERVAL 7 DAY) 
				AND u.user_expire_date < ADDDATE(NOW(), INTERVAL 8 DAY)
				ORDER BY u.user_lname ASC";
$userResult = $handle->query($userQuery);
$userNum = $handle->getNumRows($userResult);
if ($userNum > 0) {
	$names = "";
	while ($row = $handle->fetchArray($userResult)) {
		$campaign->emailSchoolwideWeekLeft($row['user_id']);
		$names .= '#'.$row['user_id'].' - '.$row['user_fname'].' '.$row['user_lname'].' ('.$row['user_email'].") \n";
	}
	echo $names;
	$campaign->emailPaidExpirationDetails('schoolwide', 7, $names);
}

echo '<br /><br />expirationEmail.php completed.';

?>
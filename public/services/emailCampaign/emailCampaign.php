<?php

include("class.phpmailer.php");

class EmailCampaign {
	private $handle;
	private $date;
	private $mimeBoundary;
	private $headers;
	private $mailer;
	
	public function __construct($handle) {
		$this->handle = $handle;
		$this->date = date("D, d M Y H:i:s O");
		$rndm = md5(time());
		$this->mimeBoundary = '==Multipart_Boundary_x'.$rndm.'_x';
		$this->mailer = new PHPMailer();
		$this->mailer->From = "info@linguazone.com";
		$this->mailer->FromName = "LinguaZone.com";
		$this->mailer->Host = "localhost";
		$this->mailer->Mailer = "mail";
	}
	private function getUserInfo($userId) {
		$query = "SELECT user_email, user_fname, user_lname, user_subscribe_type, user_enabled_date, user_expire_date, school, school_city, state, percent, single_cost, school_cost, target_group, email_msg
					FROM users
					INNER JOIN schools ON user_school_id = schools.school_id
					INNER JOIN states ON schools.school_state = states.state_id
					LEFT JOIN discounts ON user_discount_id = discounts.id
					WHERE user_id = '$userId'";
		$result = $this->handle->query($query) or die("MySQL Error: ".mysql_error());
		return $this->handle->fetchArray($result);
	}
	
	private function printPlainTrialMsg() {
		return "Thank you for signing up for your free trial with LinguaZone.".
	"\n\n".
	"Enjoy trying out the games with your students and watch for the new improvements that will be happening throughout the coming weeks.".
	"\n\n".
	"Create new games with your vocabulary words or verb conjugations or cultural material from your classes.".
	"\n\n".
	"Create class pages for as many classes as you want.".
	"\n\n".
	"After creating new games or adopting games other teachers have made, click on the classes where you want the games to appear.".
	"\n\n".
	"Your students will go to LinguaZone.com with no need for passwords or signing in. ".
	"They simply search for their school and start playing the games you have customized for them.".
	"\n\n".
	"Feel free to contact us with any questions about how to use the site or with ideas for new games. ".
	"We are constantly working on new games and new features.".
	"\n\n".
	"Thank you for your interest as we endeavor to create an engaging way for students to drill and practice the language skills they learn in your classes.".
	"\n\n".
	"Margaret Roberts and Colin Angevine".
	"\n".
	"LinguaZone.com";
	}
	private function printFormattedTrialMsg() {
		return "<html>".
"<body>".
"<p>Thank you for signing up for your free trial with <font color=\"blue\"><b>LinguaZone</b></font>.</p>".
"<p>Enjoy trying out the games with your students and <b>watch for the new improvements</b> that will be happening throughout the coming weeks.</p>".
"<p><b>Create new games</b> with your vocabulary words or verb conjugations or cultural material from your classes.</p>".
"<p><b>Create class pages</b> for as many classes as you want.</p>".
"<p>After creating new games or <b>adopting games</b> other teachers have made, click on the classes where you want the games to appear.</p>".
"<p>Your students will go to LinguaZone.com with <b>no need for passwords</b> or signing in.</p>".
"<p>They simply <b>search for their school</b> and start playing the <b>games you have customized for them</b>.</p>".
"<p>Feel free to contact us with any questions about how to use the site or with ideas for new games.</p>".
"<p>We are constantly working on new games and new features.</p>".
"<p>Thank you for your interest as we endeavor to create an engaging way for students to <b>drill and practice the language skills they learn in your classes</b>.</p>".
"<p>Margaret Roberts and Colin Angevine</p>".
"<p>LinguaZone.com</p>".
"</body>".
"</html>";
	}
	
	private function printPlainWeekLeft($discountMsg) {
		return "Turn your free trial into a year-long subscription to LinguaZone.".
"\n\n".
$discountMsg
."\n\n".
"After you login, go to the \"My account\" tab and click on the subscription you would like".
"\n\t".
"$50 for a single teacher subscription or $100 to sign up your entire school".
"\n\n".
"Pay online with a credit card or print out the invoice that will be emailed to you after you subscribe to send a check or purchase order.".
"\n\n".
"We hope you have enjoyed playing language games with your classes!".
"\n\n".
"with our thanks,".
"\n".
"Margaret Roberts and Colin Angevine";
	}
	private function printFormattedWeekLeft($discountMsg) {
		return "<html>".
"<body>".
"<p>Turn your <b>free trial</b> into a year-long subscription to <a href=\"http://www.linguazone.com\">LinguaZone</a>.</p>".
"<p>".$discountMsg."</p>".
"<p>After you login, go to the <font color=\"green\">My account</font> tab and click on the subscription you would like".
"<ul>".
	"<li><i>$50 for a single teacher subscription</i></li>".
	"<li><i>OR $100 to sign up your entire school</i></li>".
"</ul>".
"<p>Pay online with a <b>credit card</b> or print out the invoice that will be emailed to you after you subscribe to send a <b>check or purchase order</b>.</p>".
"<p>We hope you have enjoyed playing language games with your classes!</p>".
"<p>with our thanks,</p>".
"<p>Margaret Roberts and Colin Angevine</p>".
"</body>".
"</html>";
	}
	
	private function printPlainThreeDaysLeft($discountMsg) {
		$str = "3 days left on your free trial to LinguaZone.".
"\n\n";
		if ($discountMsg != null && $discountMsg != "") {
			$str .= $discountMsg;
			$str .= " Your discount will automatically be deducted when you sign up through your MY ACCOUNT tab before your trial expires.";
			$str .= "\n\n";
		}
$str .= "We hope you have tried a variety of our games with your classes, used some games that other teachers have made, and customized your own. Set up pages for your classes and enter notes for them and key words to help you search for games later.".
"\n\n".
"Any games you made during your trial will still be available after you subscribe.".
"\n\n".
"Many thanks for your interest! We hope you continue to enjoy this way to help reinforce what you are teaching. Look for our new games and features coming out soon.".
"\n\n".
"with our thanks,".
"\n".
"Margaret Roberts and Colin Angevine";
		return $str;
	}
	private function printFormattedThreeDaysLeft($discountMsg) {
		$str = "<html>".
"<body>".
"<p>3 days left on your <b>free trial</b> to <a href=\"http://www.LinguaZone.com\">LinguaZone</a>.</p>";
		if ($discountMsg != null && $discountMsg != "") {
			$str .= "<p>";
			$str .= $discountMsg;
			$str .= " Your discount will automatically be deducted when you sign up through your <font color=\"green\">MY ACCOUNT</font> tab before your trial expires.";
			$str .= "</p>";
		}
$str .= "<p>We hope you have tried a variety of our games with your classes, used some games that other teachers have made, and customized your own. Set up pages for your classes and enter notes for them and key words to help you search for games later.</p>".
"<p>Any games you made during your trial will still be available after you subscribe.</p>".
"<p>Many thanks for your interest! We hope you continue to enjoy this way to help reinforce what you are teaching. Look for our <b>new games and features</b> coming out soon.</p>".
"<p>with our thanks,</p>".
"<p>Margaret Roberts and Colin Angevine</p>".
"</body>".
"</html>";
		return $str;
	}
	
	private function printPlainSingleTwoWeeksLeft() {
		$str = "Your subscription to LinguaZone.com is coming up for renewal in 2 weeks. We hope that you have enjoyed using the games and will look forward to the new additions coming to the site.".
"\n\n".
"We also hope that you will renew your subscription for another year. Go to the \"My account\" tab after you login and follow the steps for renewing your account. Your invoice will be emailed to you for payment by check or purchase order or you can pay online with a credit card.".
"\n\n".
"many thanks for your continued support which is helping us develop features that are at the forefront of language game technology,".
"\n".
"Margaret Roberts and Colin Angevine";
		return $str;
	}
	private function printFormattedSingleTwoWeeksLeft() {
		$str = "<html>".
"<body>".
"<p>Your subscription to <a href=\"http://www.linguazone.com\">LinguaZone.com</a> is coming up for renewal in <b>2 weeks</b>. We hope that you have enjoyed using the games and will look forward to the new additions coming to the site.</p>".
"<p>We also hope that you will <b>renew your subscription</b> for another year. Go to the <font color=\"green\">\"My account\"</font> tab after you login and follow the steps for renewing your account. Your invoice will be emailed to you for payment by check or purchase order or you can pay online with a credit card.</p>".
"<p>many thanks for your continued support which is helping us develop features that are at the forefront of language game technology,</p>".
"<p>Margaret Roberts and Colin Angevine</p>".
"</body>".
"</html>";
		return $str;
	}
	
	private function printPlainSingleWeekLeft() {
		$str = "Your subscription to LinguaZone.com is coming up for renewal in one week. We hope that you have enjoyed using the games and will look forward to the new additions coming to the site.".
"\n\n".
"We also hope that you will renew your subscription for another year. Go to the \"My account\" tab after you login and follow the steps for renewing your account. Your invoice will be emailed to you for payment by check or purchase order or you can pay online with a credit card.".
"\n\n".
"many thanks for your continued support which is helping us develop features that are at the forefront of language game technology,".
"\n".
"Margaret Roberts and Colin Angevine";
		return $str;
	}
	private function printFormattedSingleWeekLeft() {
		$str = "<html>".
"<body>".
"<p>Your subscription to <a href=\"http://www.linguazone.com\">LinguaZone.com</a> is coming up for renewal in <b>one week</b>. We hope that you have enjoyed using the games and will look forward to the new additions coming to the site.</p>".
"<p>We also hope that you will <b>renew your subscription</b> for another year. Go to the <font color=\"green\">\"My account\"</font> tab after you login and follow the steps for renewing your account. Your invoice will be emailed to you for payment by check or purchase order or you can pay online with a credit card.</p>".
"<p>many thanks for your continued support which is helping us develop features that are at the forefront of language game technology,</p>".
"<p>Margaret Roberts and Colin Angevine</p>".
"</body>".
"</html>";
		return $str;
	}
	
	private function printPlainSchoolwideTwoWeeksLeft() {
		$str = "Your subscription to LinguaZone.com is coming up for renewal in 2 weeks. We hope that you have enjoyed using the games and will look forward to the new additions coming to the site.".
"\n\n".
"We also hope that you will renew your subscription for another year. Any teacher at your school with an account can complete the renewal. Go to the \"My account\" tab after you login and follow the steps for renewing your account. Your invoice will be emailed to you for payment by check or purchase order or you can pay online with a credit card.".
"\n\n".
"many thanks for your continued support which is helping us develop features that are at the forefront of language game technology,".
"\n".
"Margaret Roberts and Colin Angevine";
		return $str;
	}
	private function printFormattedSchoolwideTwoWeeksLeft() {
		$str = "<html>".
"<body>".
"<p>Your subscription to <a href=\"http://www.linguazone.com\">LinguaZone.com</a> is coming up for renewal in <b>2 weeks</b>. We hope that you have enjoyed using the games and will look forward to the new additions coming to the site.</p>".
"<p>We also hope that you will <b>renew your subscription</b> for another year. Any teacher at your school with an account can complete the renewal. Go to the <font color=\"green\">\"My account\"</font> tab after you login and follow the steps for renewing your account. Your invoice will be emailed to you for payment by check or purchase order or you can pay online with a credit card.</p>".
"<p>many thanks for your continued support which is helping us develop features that are at the forefront of language game technology,</p>".
"<p>Margaret Roberts and Colin Angevine</p>".
"</body>".
"</html>";
		return $str;
	}
	
	private function printPlainSchoolwideWeekLeft() {
		$str = "Your subscription to LinguaZone.com is coming up for renewal in one week. We hope that you have enjoyed using the games and will look forward to the new additions coming to the site.".
"\n\n".
"We also hope that you will renew your subscription for another year. Any teacher at your school with an account can complete the renewal. Go to the \"My account\" tab after you login and follow the steps for renewing your account. Your invoice will be emailed to you for payment by check or purchase order or you can pay online with a credit card.".
"\n\n".
"many thanks for your continued support which is helping us develop features that are at the forefront of language game technology,".
"\n".
"Margaret Roberts and Colin Angevine";
		return $str;
	}
	private function printFormattedSchoolwideWeekLeft() {
		$str = "<html>".
"<body>".
"<p>Your subscription to <a href=\"http://www.linguazone.com\">LinguaZone.com</a> is coming up for renewal in <b>one week</b>. We hope that you have enjoyed using the games and will look forward to the new additions coming to the site.</p>".
"<p>We also hope that you will <b>renew your subscription</b> for another year. Any teacher at your school with an account can complete the renewal. Go to the <font color=\"green\">\"My account\"</font> tab after you login and follow the steps for renewing your account. Your invoice will be emailed to you for payment by check or purchase order or you can pay online with a credit card.</p>".
"<p>many thanks for your continued support which is helping us develop features that are at the forefront of language game technology,</p>".
"<p>Margaret Roberts and Colin Angevine</p>".
"</body>".
"</html>";
		return $str;
	}	
	
	public function printInvoice($printing, $userId) {
		$arr = $this->getUserInfo($userId);
		$now = date('F dS, Y', strtotime("now"));
		$expire = date('F dS, Y', strtotime($arr['user_expire_date']));

		$line = ($printing) ? "<br />" : "\n";
		$str = 
	'LinguaZone.com Invoice '.$line.
	$now.
	$line.
	$line.
	'Ordered by: '.$line.
	$line.
	$arr['user_fname'].' '.$arr['user_lname'].$line.
	$arr['user_email'].' '.$line.
	$arr['school'].' '.$line.
	$arr['school_city'].', '.$arr['state'].' '.$line.
	$line.
	$line.
	'Order details:'.$line.
	$line.
	'Qty    Description                                                                      Price'.$line.
	'---      -------------------------------------------------------------------                   ---------'.$line;
	if ($_GET['type'] == 'single') {
		$str .= '1      One-year single teacher subscription to LinguaZone.com      $50.00 USD'.$line.$line;
		if ($arr['target_group'] != null && $arr['single_cost'] != 50) {
			$str .= 
			'              '.$arr['target_group'].' discount price: $'.$arr['single_cost'].' USD'.$line.$line;
			$str .=
			'              Order total: $'.$arr['single_cost'].' USD'.$line;
		} else {
			$str .=
			'             Order total: $50.00 USD';
		}
	} else if ($_GET['type'] == 'school') {
		$str .= '1      One-year schoolwide subscription to LinguaZone.com         $100.00 USD'.$line.$line;
		if ($arr['target_group'] != null && $arr['school_cost'] != 100) {
			$str .= 
			'              '.$arr['target_group'].' discount price: $'.$arr['school_cost'].' USD'.$line.$line;
			$str .=
			'              Order total: $'.$arr['school_cost'].' USD'.$line;
		} else {
			$str .=
			'              Order total: $100.00 USD'.$line;
		}
	}
	$str .= 
	$line.
	$line.
	$line.
	'Payment can be received as check, money order, certified check, or payment can also be made by credit card online at www.LinguaZone.com.'.$line.
	$line.
	'Submit payment to: '.$line.
	'LinguaZone '.$line.
	'417 Yorkshire Way '.$line.
	'Bryn Mawr, PA 19010 '.$line.
	$line.
	'Payment due by: '.$expire.
	$line.
	'If payment is not received by this time the account will be suspended until payment is received.'.
	$line.
	$line.
	'For any questions please contact info@linguazone.com.'.$line.
	'Thanks for your interest, and have fun with the games!'.$line.
	$line.
	'LinguaZone'.$line.
	'417 Yorkshire Way'.$line.
	'Bryn Mawr, PA 19010'.$line.
	'Tel: 610.322.9137'.$line.
	'Web: http://www.LinguaZone.com';

		if ($printing) {
			echo $str;
		} else {
			return $str;
		}
	}
	public function printTrialDetails() {
		$query = "SELECT u.user_email, u.user_fname, u.user_lname, u.user_subscribe_type, u.user_enabled_date, u.user_expire_date,
									s.school, s.school_city, st.state,
						(SELECT COUNT(DISTINCT user_id) FROM users) AS userTotal,
						(SELECT COUNT(DISTINCT school_id) FROM schools) AS schoolTotal
						FROM users u, schools s, states st 
						WHERE u.user_id='".$_GET['userId']."'
						AND u.user_school_id=s.school_id
						AND s.school_state=st.state_id";
		$result = $this->handle->query($query);
		$arr = $this->handle->fetchArray($result);
		$now = date('F dS \a\t g:i A.', strtotime("now"));

		return 
'A new member to the LinguaZone.com community signed up for a trial account today, '.$now.
"\n\n".
'     Teacher details:'.
"\n".
$arr['user_fname'].' '.$arr['user_lname'].
"\n".
$arr['user_email'].
"\n".
'From '.$arr['school'].' in '.$arr['school_city'].', '.$arr['state'].
"\n\n".
'     That sets our total number of schools and teachers in our database to...'.
"\n".
'Schools: '.$arr['schoolTotal'].
"\n".
'Teachers: '.$arr['userTotal'];
	}
	
	public function emailNewSchoolInvoice($userId) {
		$arr = $this->getUserInfo($userId);
		$subject = 'LinguaZone.com Invoice';
		$message = $this->printInvoice(false, $userId);
		$headers = 'From: LinguaZone.com <info@linguazone.com>';
		mail( $arr['user_email'], $subject, $message, $headers );
		mail( 'magistraroberts@hotmail.com', $subject, $message, $headers ); 
		mail( 'colinangevine@gmail.com', $subject, $message, $headers );
	}
	public function emailSingleInvoice($userId) {
		$arr = $this->getUserInfo($userId);
		$subject = 'LinguaZone.com Invoice';
		$message = $this->printInvoice(false, $userId);
		$headers = 'From: LinguaZone.com <info@linguazone.com>';
		mail( $arr['user_email'], $subject, $message, $headers );
		mail( 'magistraroberts@hotmail.com', $subject, $message, $headers ); 
		mail( 'colinangevine@gmail.com', $subject, $message, $headers );
	}
	
	public function emailTrial($userId) {
		$arr = $this->getUserInfo($userId);
		$this->mailer->Subject = "Welcome to LinguaZone";
		$this->mailer->Body = $this->printFormattedTrialMsg();
		$this->mailer->AltBody = $this->printPlainTrialMsg();	
		$this->mailer->addAddress($arr['user_email'], $arr['user_fname']." ".$arr['user_lname']);
		if ($this->mailer->Send()) {
			//echo "EmailCampaign :: emailTrial :: Sent to ".$userId." :: Success";
		} else {
			//echo "EmailCampaign :: emailTrial :: Sent to ".$userId." :: FAILURE";
		}
		$this->mailer->ClearAddresses();
		
		// Send out email to administrators
		$subject = 'New LinguaZone.com Trial Subscription';
		$message = $this->printTrialDetails();
		$headers = 'From: LinguaZone.com <info@linguazone.com>';
		mail( 'magistraroberts@hotmail.com', $subject, $message, $headers );
		mail( 'colinangevine@gmail.com', $subject, $message, $headers );
	}
	
	public function emailWeekLeft($userId) {
		$arr = $this->getUserInfo($userId);
		$discountMsg = ($arr['email_msg'] == null) ? "" : $arr['email_msg'];
		
		$this->mailer->Subject = ($discountMsg != "") ? "Use your LinguaZone discount -- subscribe before your trial expires" : "Your LinguaZone.com trial account will expire soon";
		$this->mailer->Body = $this->printFormattedWeekLeft();
		$this->mailer->AltBody = $this->printPlainWeekLeft();	
		$this->mailer->addAddress($arr['user_email'], $arr['user_fname']." ".$arr['user_lname']);
		if ($this->mailer->Send()) {
			//echo "EmailCampaign :: emailWeekLeft :: Sent to ".$userId." :: Success";
		} else {
			//echo "EmailCampaign :: emailWeekLeft :: Sent to ".$userId." :: FAILURE";
		}
		$this->mailer->ClearAddresses();
	}
	public function emailThreeDaysLeft($userId) {
		$arr = $this->getUserInfo($userId);
		$discountMsg = ($arr['email_msg'] == null) ? "" : $arr['email_msg'];
		
		$this->mailer->Subject = ($discountMsg != "") ? "Use your LinguaZone discount -- subscribe now before your trial expires" : "Your LinguaZone.com trial account will expire soon";
		$this->mailer->Body = $this->printFormattedThreeDaysLeft($discountMsg);
		$this->mailer->AltBody = $this->printPlainThreeDaysLeft($discountMsg);
		$this->mailer->AddAddress($arr['user_email'], $arr['user_fname']." ".$arr['user_lname']);
		if ($this->mailer->Send()) {
			//echo "EmailCampaign :: emailThreeDaysLeft :: Sent to ".$userId." :: Success";
		} else {
			//echo "EmailCampaign :: emailThreeDaysLeft :: Sent to ".$userId." :: FAILURE";
		}
		$this->mailer->ClearAddresses();
	}
	
	public function emailSingleTwoWeeksLeft($userId) {
		$arr = $this->getUserInfo($userId);
		
		$this->mailer->Subject = "Expiring subscription to LinguaZone";
		$this->mailer->Body = $this->printFormattedSingleTwoWeeksLeft();
		$this->mailer->AltBody = $this->printPlainSingleTwoWeeksLeft();
		$this->mailer->AddAddress($arr['user_email'], $arr['user_fname']." ".$arr['user_lname']);
		if ($this->mailer->Send()) {
			//echo "EmailCampaign :: emailSingleTwoWeeksLeft :: Sent to ".$userId." :: Success";
		} else {
			//echo "EmailCampaign :: emailSingleTwoWeeksLeft :: Sent to ".$userId." :: FAILURE";
		}
		$this->mailer->ClearAddresses();
	}
	public function emailSingleWeekLeft($userId) {
		$arr = $this->getUserInfo($userId);
		
		$this->mailer->Subject = "Expiring subscription to LinguaZone - one week left";
		$this->mailer->Body = $this->printFormattedSingleWeekLeft();
		$this->mailer->AltBody = $this->printPlainSingleWeekLeft();
		$this->mailer->AddAddress($arr['user_email'], $arr['user_fname']." ".$arr['user_lname']);
		if ($this->mailer->Send()) {
			//echo "EmailCampaign :: emailSingleWeekLeft :: Sent to ".$userId." :: Success";
		} else {
			//echo "EmailCampaign :: emailSingleWeekLeft :: Sent to ".$userId." :: FAILURE";
		}
		$this->mailer->ClearAddresses();
	}
	
	public function emailSchoolwideTwoWeeksLeft($userId) {
		$arr = $this->getUserInfo($userId);
		
		$this->mailer->Subject = "Expiring subscription to LinguaZone";
		$this->mailer->Body = $this->printFormattedSchoolwideTwoWeeksLeft();
		$this->mailer->AltBody = $this->printPlainSchoolwideTwoWeeksLeft();
		$this->mailer->AddAddress($arr['user_email'], $arr['user_fname']." ".$arr['user_lname']);
		if ($this->mailer->Send()) {
			//echo "EmailCampaign :: emailSchoolwideTwoWeeksLeft :: Sent to ".$userId." :: Success";
		} else {
			//echo "EmailCampaign :: emailSchoolwideTwoWeeksLeft :: Sent to ".$userId." :: FAILURE";
		}
		$this->mailer->ClearAddresses();
	}
	public function emailSchoolwideWeekLeft($userId) {
		$arr = $this->getUserInfo($userId);
		
		$this->mailer->Subject = "Expiring subscription to LinguaZone - one week left";
		$this->mailer->Body = $this->printFormattedSchoolwideWeekLeft();
		$this->mailer->AltBody = $this->printPlainSchoolwideWeekLeft();
		$this->mailer->AddAddress($arr['user_email'], $arr['user_fname']." ".$arr['user_lname']);
		if ($this->mailer->Send()) {
		//	echo "EmailCampaign :: emailSchoolwideWeekLeft :: Sent to ".$userId." :: Success";
		} else {
		//	echo "EmailCampaign :: emailSchoolwideWeekLeft :: Sent to ".$userId." :: FAILURE";
		}
		$this->mailer->ClearAddresses();
	}
	
	public function emailExpirationDetails($days, $names) {
		$msg = 'The following users have been emailed because their accounts are expiring in '.$days." days...\n\n";
		$msg .= $names;
		$msg .= "\n\n";
		$msg .= 'Mailed on '.$this->date;
		mail ('colinangevine@gmail.com', 'Emailing expiring users', $msg, 'From: LinguaZone.com <info@linguazone.com>');
	}	
	public function emailPaidExpirationDetails($type, $days, $names) {
		$msg = 'The following '.$type.' subscribers have been emailed because their accounts are expiring in '.$days." days...\n\n";
		$msg .= $names;
		$msg .= "\n\n";
		$msg .= 'Mailed on '.$this->date;
		mail ('colinangevine@gmail.com', 'Emailing expiring '.$type.' subscribers', $msg, 'From: LinguaZone.com <info@linguazone.com>');
	}
}

?>
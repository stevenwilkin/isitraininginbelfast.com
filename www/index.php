<?php
	define('DATA', '../var/forecast.dat');
	// get the current weather symbol
	$image = file_get_contents(DATA);
	if(empty($image))
		$image = 'NA.gif';
	// and when it was retrieved
	$modified = date('D d/m/Y G:i', filemtime(DATA));
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Is it raining in Belfast?</title>
<link rel="stylesheet" href="/css/belfast.css" type="text/css" media="all" />
</head>
<body>

</body>
</html>

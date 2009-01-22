<?php

define('DATA', '../var/forecast.dat');

$descriptions = array(
	'w0.gif'	=> 'Clear sky (night)',
	'w8.gif'	=> 'Low-level cloud',
	'w16.gif'	=> 'Sleet shower (night)',
	'w24.gif'	=> 'Light snow',
	'w1.gif'	=> 'Sunny',
	'w9.gif'	=> 'Light rain shower (night)',
	'w17.gif'	=> 'Sleet shower (day)',
	'w25.gif'	=> 'Heavy snow shower (night)',
	'w2.gif'	=> 'Partly cloudy (night)',
	'w10.gif'	=> 'Light rain shower (day)',
	'w18.gif'	=> 'Sleet',
	'w26.gif'	=> 'Heavy snow shower (day)',
	'w3.gif'	=> 'Sunny intervals',
	'w11.gif'	=> 'Drizzle',
	'w19.gif'	=> 'Hail shower (night)',
	'w27.gif'	=> 'Heavy snow',
	'w4.gif'	=> 'Dust',
	'w12.gif'	=> 'Light rain',
	'w20.gif'	=> 'Hail shower (day)',
	'w28.gif'	=> 'Thundery shower (night)',
	'w5.gif'	=> 'Mist',
	'w13.gif'	=> 'Heavy rain shower (night)',
	'w21.gif'	=> 'Hail',
	'w29.gif'	=> 'Thundery shower (day)',
	'w6.gif'	=> 'Fog',
	'w14.gif'	=> 'Heavy rain shower (day)',
	'w22.gif'	=> 'Light snow shower (night)',
	'w30.gif'	=> 'Thunder storm',
	'w33.gif'	=> 'Haze',
	'w15.gif'	=> 'Heavy rain',
	'w23.gif'	=> 'Light snow shower (day)',
	'w31.gif'	=> 'Tropical storm',
	'w7.gif'	=> 'Medium-level cloud',
	'NA.gif'	=> 'Not available',
);

// get the current weather symbol
$image = file_get_contents(DATA);
if(empty($image))
	$image = 'NA.gif';
// it's description
$description = $descriptions[$image];
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

<img src="/img/<?php echo $image ?>" title="<?php echo $description ?>" alt="<?php echo $description ?>" />

<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-2764682-6");
pageTracker._trackPageview();
} catch(err) {}</script>

</body>
</html>

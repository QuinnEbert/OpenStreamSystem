<?php
$vod = array();
if ($handle = opendir('/tmp/av')) {
	while (false !== ($entry = readdir($handle))) {
        if (strtolower(substr($entry,-4))==='.flv') {
        	$vod[] = "/tmp/av/{$entry}";
        }
    }
}
?>
<html>
<head>
<title>OSS</title>
</head>
<body>
<h1>OSS</h1>
<p>Still in <em>heavy</em> development...</p>
<h2>VOD List (TEST only)</h2>
<pre><?php
echo(print_r($vod,true));
?></pre>
</body>
</html>
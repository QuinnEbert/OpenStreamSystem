<?php
function modal_ajax_return_vod_list() {
	$vod = array();
	if ($handle = opendir('/tmp/av')) {
		while (false !== ($entry = readdir($handle))) {
			if (strtolower(substr($entry,-4))==='.flv') {
				$vod[] = "/tmp/av/{$entry}";
			}
		}
	}
	$die = json_encode(array('count'=>count($vod),'data'=>$vod));
	if (isset($_REQUEST['callback']))
		die($_REQUEST['callback'].'('.$die.');');
	die($die);
}
if (isset($_GET['modal'])) {
	switch($_GET['modal']) {
		case 'vod_list':
			modal_ajax_return_vod_list();
			break;
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
<pre id="vod_list"></pre>
<script type="text/javascript">
function modal_ajax_return_vod_list(dataSet) {
	var elem = document.getElementById('vod_list');
	elem.innerHTML = '';
	if (!dataSet.count) {
		elem.innerHTML += 'No VODs!';
	} else {
		for (var i = 0 ; i < dataSet.count ; i = i + 1) {
			elem.innerHTML += dataSet.data[i]+"\n";
		}
	}
}
var script = document.createElement('script');
script.src = 'index.php?modal=vod_list&callback=modal_ajax_return_vod_list'
document.getElementsByTagName('head')[0].appendChild(script);
</script>
</body>
</html>
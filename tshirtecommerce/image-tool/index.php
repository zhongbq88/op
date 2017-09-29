<?php
error_reporting(0);
define('DS', DIRECTORY_SEPARATOR);
define('ROOT', dirname(dirname(__FILE__)));

$src 	= $_GET['src'];

if(strpos($src, 'http') === false)
	$src	= 'http://'. $src;

$src 	= str_replace(' ', '%20', $src);

$type = pathinfo($src, PATHINFO_EXTENSION);

$img =  openURL($src);
header("Content-type: image/$type");
echo $img;
exit;

function openURL($url, $use_include_path = false, $stream_context = null, $curl_timeout = 5)
{	
	$url = str_replace('//uploaded', '//uploaded', $url);
	
	if ($stream_context == null && preg_match('/^https?:\/\//', $url)) {
        $stream_context = @stream_context_create(array('http' => array('timeout' => $curl_timeout)));
    }
    if (in_array(ini_get('allow_url_fopen'), array('On', 'on', '1')) || !preg_match('/^https?:\/\//', $url)) {
        return @file_get_contents($url, $use_include_path, $stream_context);
    } elseif (function_exists('curl_init')) {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
        curl_setopt($curl, CURLOPT_TIMEOUT, $curl_timeout);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
        if ($stream_context != null) {
            $opts = stream_context_get_options($stream_context);
            if (isset($opts['http']['method']) && Tools::strtolower($opts['http']['method']) == 'post') {
                curl_setopt($curl, CURLOPT_POST, true);
                if (isset($opts['http']['content'])) {
                    parse_str($opts['http']['content'], $post_data);
                    curl_setopt($curl, CURLOPT_POSTFIELDS, $post_data);
                }
            }
        }
        $content = curl_exec($curl);
        curl_close($curl);
        return $content;
    } else {
        return false;
    }
}

function base_url($atRoot=FALSE, $atCore=FALSE, $parse=FALSE){
	if (isset($_SERVER['HTTP_HOST'])) {
		$http = isset($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) !== 'off' ? 'https' : 'http';
		$hostname = $_SERVER['HTTP_HOST'];
		$dir =  str_replace(basename($_SERVER['SCRIPT_NAME']), '', $_SERVER['SCRIPT_NAME']);

		$core = preg_split('@/@', str_replace($_SERVER['DOCUMENT_ROOT'], '', realpath(dirname(__FILE__))), NULL, PREG_SPLIT_NO_EMPTY);
		$core = $core[0];

		$tmplt = $atRoot ? ($atCore ? "%s://%s/%s/" : "%s://%s/") : ($atCore ? "%s://%s/%s/" : "%s://%s%s");
		$end = $atRoot ? ($atCore ? $core : $hostname) : ($atCore ? $core : $dir);
		$base_url = sprintf( $tmplt, $http, $hostname, $end );
	}
	else $base_url = 'http://localhost/';

	if ($parse) {
		$base_url = parse_url($base_url);
		if (isset($base_url['path'])) if ($base_url['path'] == '/') $base_url['path'] = '';
	}

	return $base_url;
}

?>	
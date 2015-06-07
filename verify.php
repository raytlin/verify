<?php
	$url = $_GET['url'];
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_HEADER, true);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true); // Must be set to true so that PHP follows any "Location:" header
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	
	$a = curl_exec($ch);

	$url = curl_getinfo($ch, CURLINFO_EFFECTIVE_URL); 



	$finalUrl = parse_url($url, PHP_URL_SCHEME) . "://" . parse_url($url, PHP_URL_HOST) . "/favicon.ico"; 

	

	$curl = curl_init($finalUrl);
	$result = curl_exec($curl);
	echo $result; 
	curl_close($curl);

	
?>

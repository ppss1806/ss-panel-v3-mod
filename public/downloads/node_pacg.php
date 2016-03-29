<?php
$address = $_GET['address'];
$port = $_GET['port'];
$content =file_get_contents("http://127.0.0.1:8974/");




{
$res = str_replace("TIHUAN","PROXY ".$_GET['address'].":".$_GET['port'].";DIRECT",$content);
}


Header("Content-type: application/x-ns-proxy-autoconfig");
echo($res);
?>


								
			






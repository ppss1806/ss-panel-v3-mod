<?php
$address = $_GET['address'];
$port = $_GET['port'];
$content =file_get_contents("http://127.0.0.1:8974/");



if(isset($_GET["ios"]))
{
$res = str_replace("TIHUAN","SOCKS ".$_GET['address'].":".$_GET['port'].";DIRECT",$content);
}
else
{
$res = str_replace("TIHUAN","SOCKS5 ".$_GET['address'].":".$_GET['port'].";DIRECT",$content);
}


Header("Content-type: application/x-ns-proxy-autoconfig");
echo($res);
?>


								
			






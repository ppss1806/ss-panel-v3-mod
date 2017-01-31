<?php

namespace App\Utils;

use App\Models\User;
use App\Services\Config;


Class QRcode
{
	
	static function decode($url)
	{
		switch(Config::get('telegram_qrcode'))
		{
			case 'qrcodereader':
				return QRcode::QRCodeReader_decode($url);
			case 'phpzbar':
				return QRcode::phpzbar_decode($url);
			default:
				return QRcode::online_decode($url);
		}
	}
	
	static function online_decode($url)
	{
		$data = array();
		$data['fileurl'] = $url;
		$param = http_build_query($data, '', '&');
		
		$sock = new HTTPSocket;
		$sock->connect("api.qrserver.com",80);
		$sock->set_method('GET');
		$sock->query('/v1/read-qr-code/',$param);
		
		$raw_text = $sock->fetch_body();
		$result_array = json_decode($raw_text, TRUE);
		return $result_array[0]['symbol'][0]['data'];
	}
	
	static function QRCodeReader_decode($url)
	{
		$QRCodeReader = new \Libern\QRCodeReader\QRCodeReader();
		$qrcode_text = $QRCodeReader->decode($url);
		return $qrcode_text;
	}
	
	static function phpzbar_decode($url)
	{
		$filepath = BASE_PATH."/storage/".time().rand(1, 100).".png";
		$img = file_get_contents($url);
		file_put_contents($filepath, $img);
		
		/* Create new image object */
		$image = new \ZBarCodeImage($filepath);
		
		/* Create a barcode scanner */
		$scanner = new \ZBarCodeScanner();
		
		/* Scan the image */
		$barcode = $scanner->scan($image);
		
		unlink($filepath);
		
		return (isset($barcode[0]['data']) ? $barcode[0]['data'] : null);
	}
	
}

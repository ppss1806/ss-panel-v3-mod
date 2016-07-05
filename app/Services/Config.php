<?php

namespace App\Services;


class Config
{
	
    public static function get($key){
		require BASE_PATH."/config/.config.php";
		return $System_Config[$key];
    }

    public static function getPublicConfig(){
        return [
            "appName" => self::get("appName"),
            "version" => VERSION,
            "baseUrl" => self::get("baseUrl"),
            "checkinTime" => self::get("checkinTime"),
            "checkinMin" => self::get("checkinMin"),
			"code_payback" => self::get("code_payback"),
            "checkinMax" => self::get("checkinMax"),
			"wecenter_url" => self::get("wecenter_url"),
			"enable_wecenter" => self::get("enable_wecenter"),
         ];
    }

    public static function getDbConfig(){
        return [
            'driver'    => self::get('db_driver'),
            'host'      => self::get('db_host'),
            'database'  => self::get('db_database'),
            'username'  => self::get('db_username'),
            'password'  => self::get('db_password'),
            'charset'   => self::get('db_charset'),
            'collation' => self::get('db_collation'),
            'prefix'    => self::get('db_prefix')
        ];
    }
	
	public static function getRadiusDbConfig(){
        return [
            'driver'    => self::get('db_driver'),
            'host'      => self::get('radius_db_host'),
            'database'  => self::get('radius_db_database'),
            'username'  => self::get('radius_db_user'),
            'password'  => self::get('radius_db_password'),
            'charset'   => self::get('db_charset'),
            'collation' => self::get('db_collation')
        ];
    }
	
	public static function getWecenterDbConfig(){
        return [
            'driver'    => self::get('db_driver'),
            'host'      => self::get('wecenter_db_host'),
            'database'  => self::get('wecenter_db_database'),
            'username'  => self::get('wecenter_db_user'),
            'password'  => self::get('wecenter_db_password'),
            'charset'   => self::get('db_charset'),
            'collation' => self::get('db_collation')
        ];
    }
}
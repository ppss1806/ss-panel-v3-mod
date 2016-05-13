<?php

namespace App\Utils;

use App\Models\User;
use App\Models\WecenterUser;
use App\Services\Config;
use App\Utils;


Class Wecenter
{

    /**
     * 添加或者更新密码信息
     */
    static function Add($user,$pwd)
    {
        if(Config::get('wecenter_db_user')!='')
		{
			$email=$user->email;
			$exists=WecenterUser::where("email",$email)->first();
			
			if($exists==NULL)
			{
				$exists=new WecenterUser();
				$exists->password=md5(md5($pwd).Config::get('salt'));
				$exists->user_name=$user->user_name;
				$exists->email=$email;
				$exists->salt=Config::get('salt');
				$exists->group_id=5;
				$exists->save();
			}
			else
			{
				$exists->password=md5(md5($pwd).Config::get('salt'));
				$exists->salt=Config::get('salt');
				$exists->save();
			}
		}
    }
	
	
	static function Delete($email)
	{
		if(Config::get('wecenter_db_user')!='')
		{
			WecenterUser::where("email",$email)->delete();
		}
	}
	
	static function ChangeUserName($email1,$email2,$pwd,$username)
	{
		if(Config::get('wecenter_db_user')!='')
		{
			$email=$user->email;
			$exists=WecenterUser::where("email",$email1)->first();
			
			if($exists!=NULL)
			{
				$exists->password=md5(md5($pwd).Config::get('salt'));
				$exists->user_name=$username;
				$exists->email=$email2;
				$exists->salt=Config::get('salt');
				$exists->save();
			}
			else
			{
				$exists=new WecenterUser();
				$exists->password=md5(md5($pwd).Config::get('salt'));
				$exists->user_name=$username;
				$exists->email=$email2;
				$exists->salt=Config::get('salt');
				$exists->group_id=5;
				$exists->save();
			}
		}
	}
	
	static function Login($user,$pwd,$time)
	{
		if(Config::get('wecenter_db_user')!='')
		{
			$email=$user->email;
			$exists=WecenterUser::where("email",$email)->first();
			
			
			$expire_in = $time+time();
			
			Utils\Cookie::setwithdomain([Config::get('wecenter_cookie_prefix')."_user_login"=>Wecenter::encode_hash(array(
								'uid' => $exists->uid,
								'user_name' => $user->email,
								'password' => md5(md5($pwd).Config::get('salt'))
							), md5(Config::get('wecenter_cookie_key') . $_SERVER['HTTP_USER_AGENT']))],$expire_in,Config::get('wecenter_system_main_domain'));
		}
	}
	
	
	static function Loginout()
	{
		if(Config::get('wecenter_db_user')!='')
		{
			Utils\Cookie::setwithdomain([Config::get('wecenter_cookie_prefix')."_user_login"=>"loginout"],time()-86400,Config::get('wecenter_system_main_domain'));
		}
	}
	
	public static function encode_hash($hash_data, $hash_key = null)
	{
		$hash_string="";
		
		if (!$hash_data)
		{
			return false;
		}

		foreach ($hash_data as $key => $value)
		{
			$hash_string .= $key . "^]+" . $value . "!;-";
		}

		$hash_string = substr($hash_string, 0, - 3);

		// 加密干扰码，加密解密时需要用到的 key
		if (! $hash_key)
		{
			$hash_key = G_COOKIE_HASH_KEY;
		}

		// 加密过程
		$tmp_str = "";
		for ($i = 1; $i <= strlen($hash_string); $i ++)
		{
			$char = substr($hash_string, $i - 1, 1);
			$keychar = substr($hash_key, ($i % strlen($hash_key)) - 2, 1);
			$char = chr(ord($char) + ord($keychar));
			$tmp_str .= $char;
		}

		$hash_string = base64_encode($tmp_str);

		$hash_string = str_replace(array(
			'+',
			'/',
			'='
		), array(
			'-',
			'_',
			'.'
		), $hash_string);

		return $hash_string;
	}
	
	
}
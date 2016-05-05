<?php

namespace App\Utils;

use App\Models\User;
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
			$dsn = "mysql:host=".Config::get('wecenter_db_host').";dbname=".Config::get('wecenter_db_database');  
			$db = new \PDO($dsn, Config::get('wecenter_db_user'), Config::get('wecenter_db_password'));
			$email=$user->email;
			$stmt = $db->prepare("SELECT * FROM `aws_users` where `email`=:email");
			$stmt->execute(array(':email'=>$email));
			
			if($stmt->rowCount()==0)
			{
				$sql = "INSERT INTO `aws_users` (`uid`, `user_name`, `email`, `mobile`, `password`, `salt`, `avatar_file`, `sex`, `birthday`, `province`, `city`, `job_id`, `reg_time`, `reg_ip`, `last_login`, `last_ip`, `online_time`, `last_active`, `notification_unread`, `inbox_unread`, `inbox_recv`, `fans_count`, `friend_count`, `invite_count`, `article_count`, `question_count`, `answer_count`, `topic_focus_count`, `invitation_available`, `group_id`, `reputation_group`, `forbidden`, `valid_email`, `is_first_login`, `agree_count`, `thanks_count`, `views_count`, `reputation`, `reputation_update_time`, `weibo_visit`, `integral`, `draft_count`, `common_email`, `url_token`, `url_token_update`, `verified`, `default_timezone`, `email_settings`, `weixin_settings`, `recent_topics`) VALUES (NULL, :username, :email, NULL, :password, :salt, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, '0', NULL, '0', NULL, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '0', '0', '0', '1', '0', '0', '0', '0', '0', '1', '0', NULL, NULL, NULL, '0', NULL, NULL, '', '', NULL)";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':password'=>md5(md5($pwd).Config::get('salt')),':email'=>addslashes($email),':salt'=>Config::get('salt'),':username'=>$user->user_name));
			}
			else
			{
				$sql = "UPDATE `aws_users` SET `password` = :password,`salt`=:salt WHERE `email` = :email;";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':password'=>md5(md5($pwd).Config::get('salt')),':email'=>addslashes($email),':salt'=>Config::get('salt')));
			}
		}
    }
	
	
	static function Delete($email)
	{
		if(Config::get('wecenter_db_user')!='')
		{
			$dsn = "mysql:host=".Config::get('wecenter_db_host').";dbname=".Config::get('wecenter_db_database');  
			$db = new \PDO($dsn, Config::get('wecenter_db_user'), Config::get('wecenter_db_password'));
			
			$stmt = $db->prepare("SELECT * FROM `aws_users` where `email`=:email");
			$stmt->execute(array(':email'=>$email));
		
			if($stmt->rowCount()>0)
			{
				$sql = "DELETE FROM `aws_users` WHERE `email` = :email ";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':email'=>$email));
			}
		}
	}
	
	static function ChangeUserName($email1,$email2,$pwd,$username)
	{
		if(Config::get('wecenter_db_user')!='')
		{
			$dsn = "mysql:host=".Config::get('wecenter_db_host').";dbname=".Config::get('wecenter_db_database');  
			$db = new \PDO($dsn, Config::get('wecenter_db_user'), Config::get('wecenter_db_password'));
			$stmt = $db->prepare("SELECT * FROM `aws_users` where `email`=:email");
			$stmt->execute(array(':email'=>$email1));
			
			if($stmt->rowCount()>0)
			{
				$sql = "UPDATE `aws_users` SET `password` = :password,`salt`=:salt,`email`=:email2,`user_name`=:username WHERE `email` = :email;";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':password'=>md5(md5($pwd).Config::get('salt')),':email'=>addslashes($email),':salt'=>Config::get('salt'),'username'=>$username,'email2'=>$email2));
				
			}
			else
			{
				$sql = "INSERT INTO `aws_users` (`uid`, `user_name`, `email`, `mobile`, `password`, `salt`, `avatar_file`, `sex`, `birthday`, `province`, `city`, `job_id`, `reg_time`, `reg_ip`, `last_login`, `last_ip`, `online_time`, `last_active`, `notification_unread`, `inbox_unread`, `inbox_recv`, `fans_count`, `friend_count`, `invite_count`, `article_count`, `question_count`, `answer_count`, `topic_focus_count`, `invitation_available`, `group_id`, `reputation_group`, `forbidden`, `valid_email`, `is_first_login`, `agree_count`, `thanks_count`, `views_count`, `reputation`, `reputation_update_time`, `weibo_visit`, `integral`, `draft_count`, `common_email`, `url_token`, `url_token_update`, `verified`, `default_timezone`, `email_settings`, `weixin_settings`, `recent_topics`) VALUES (NULL, :username, :email, NULL, :password, :salt, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, '0', NULL, '0', NULL, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '0', '0', '0', '1', '0', '0', '0', '0', '0', '1', '0', NULL, NULL, NULL, '0', NULL, NULL, '', '', NULL)";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':password'=>md5(md5($pwd).Config::get('salt')),':email'=>addslashes($email2),':salt'=>Config::get('salt'),':username'=>$username));
			}
		}
	}
	
	static function Login($user,$pwd,$time)
	{
		if(Config::get('wecenter_db_user')!='')
		{
			$dsn = "mysql:host=".Config::get('wecenter_db_host').";dbname=".Config::get('wecenter_db_database');  
			$db = new \PDO($dsn, Config::get('wecenter_db_user'), Config::get('wecenter_db_password'));
			$email=$user->email;
			$stmt = $db->prepare("SELECT * FROM `aws_users` where `email`=:email");
			$stmt->execute(array(':email'=>$email));
			$resultarray = $stmt->fetchAll(\PDO::FETCH_ASSOC);
			
			$expire_in = $time+time();
			
			Utils\Cookie::setwithdomain([Config::get('wecenter_cookie_prefix')."_user_login"=>Wecenter::encode_hash(array(
								'uid' => $resultarray[0]['uid'],
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
<?php

namespace App\Utils;

use App\Models\User;
use App\Services\Config;


Class Radius
{

    /**
     * 添加或者更新密码信息
     */
    static function Add($user,$pwd)
    {
        if(Config::get('radius_db_user')!='')
		{
			$dsn = "mysql:host=".Config::get('radius_db_host').";dbname=".Config::get('radius_db_database');  
			$db = new \PDO($dsn, Config::get('radius_db_user'), Config::get('radius_db_password'));
			$email=$user->email;
			$email=str_replace("@","",$email);
			$email=str_replace(".","",$email);
			$stmt = $db->query("SELECT * FROM `radcheck` WHERE `username`='".addslashes($email)."'");
			
			if($stmt->rowCount()==0)
			{
				$sql = "INSERT INTO `radcheck` ( `username`, `attribute`, `op`, `value`) VALUES ( :username, 'Cleartext-Password', ':=', :passwd);";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':username'=>addslashes($email),':passwd'=>addslashes($pwd)));
				
				$sql = "INSERT INTO `radusergroup` (`username`, `groupname`, `priority`) VALUES (:groupname, 'user', '0');";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':groupname'=>addslashes($email)));
				
				$sql = "INSERT INTO `userinfo` ( `username`) VALUES ( :username);";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':username'=>addslashes($email)));
			}
			else
			{
				$sql = "UPDATE `radcheck` SET `value` = :passwd WHERE `radcheck`.`username` = :username; ";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':username'=>addslashes($email),':passwd'=>addslashes($pwd)));
			}
		}
    }
	
	
	static function Delete($email)
	{
		if(Config::get('radius_db_user')!='')
		{
			$dsn = "mysql:host=".Config::get('radius_db_host').";dbname=".Config::get('radius_db_database');  
			$db = new \PDO($dsn, Config::get('radius_db_user'), Config::get('radius_db_password'));
			
			$email=str_replace("@","",$email);
			$email=str_replace(".","",$email);
			$stmt = $db->query("SELECT * FROM `radcheck` WHERE `username`='".addslashes($email)."'");
		
			if($stmt->rowCount()>0)
			{
				$sql = "DELETE FROM `radcheck` WHERE `radcheck`.`username` = :username ";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':username'=>addslashes($email)));

				$sql = "DELETE FROM `radusergroup` WHERE `radusergroup`.`username` = :username";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':username'=>addslashes($email)));
				
				$sql = "DELETE FROM `userinfo` WHERE `userinfo`.`username` = :username";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':username'=>addslashes($email)));
			}
		}
	}
	
	static function ChangeUserName($email1,$email2,$passwd)
	{
		if(Config::get('radius_db_user')!='')
		{
			$dsn = "mysql:host=".Config::get('radius_db_host').";dbname=".Config::get('radius_db_database');  
			$db = new \PDO($dsn, Config::get('radius_db_user'), Config::get('radius_db_password')); 
			$email1=str_replace("@","",$email1);
			$email1=str_replace(".","",$email1);
			$email2=str_replace("@","",$email2);
			$email2=str_replace(".","",$email2);
			$stmt = $db->query("SELECT * FROM `radcheck` WHERE `username`='".addslashes($email1)."'");
			if($stmt->rowCount()>0)
			{
				$sql = "UPDATE `radcheck` SET `username` = :username,`value` = :passwd WHERE `radcheck`.`username` = :username1;";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':username'=>addslashes($email2),':username1'=>addslashes($email1),':passwd'=>$passwd));

				$sql = "UPDATE `radusergroup` SET `username` = :username WHERE `radusergroup`.`username` = :username1;";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':username'=>addslashes($email2),':username1'=>addslashes($email1)));
				
				$sql = "UPDATE `userinfo` SET `username` = :username WHERE `userinfo`.`username` = :username1 ;";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':username'=>addslashes($email2),':username1'=>addslashes($email1)));
				
			}
			else
			{
				$sql = "INSERT INTO `radcheck` ( `username`, `attribute`, `op`, `value`) VALUES ( :username, 'Cleartext-Password', ':=', :passwd);";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':username'=>addslashes($email2),':passwd'=>addslashes($passwd)));
				
				$sql = "INSERT INTO `radusergroup` (`username`, `groupname`, `priority`) VALUES (:groupname, 'user', '0');";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':groupname'=>addslashes($email2)));
				
				$sql = "INSERT INTO `userinfo` ( `username`) VALUES ( :username);";
				$stmt = $db->prepare($sql);
				$stmt->execute(array(':username'=>addslashes($email2)));
			}
		}
	}
	
	static function GetUserName($email)
	{
		$emailt=str_replace("@","",$email);
		$emailt=str_replace(".","",$emailt);
		return $emailt;
	}
	
}
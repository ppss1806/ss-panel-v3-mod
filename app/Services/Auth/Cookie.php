<?php

namespace App\Services\Auth;

use App\Models\User;
use App\Utils;
use App\Utils\Hash;
use App\Services\Config;


class Cookie extends Base
{
    public  function login($uid,$time){
        $user = User::find($uid);
        $key = Hash::cookieHash($user->pass);
        Utils\Cookie::set([
            "uid" => $uid,
            "email" => $user->email,
            "key" => $key,
			"ip" => md5($_SERVER["REMOTE_ADDR"].Config::get('key').$uid)
        ],$time+time());
    }

    public  function getUser(){
        $uid = Utils\Cookie::get('uid');
        $key = Utils\Cookie::get('key');
		$ip = Utils\Cookie::get('ip');
        if ($uid == null){
            $user = new User();
            $user->isLogin = false;
            return $user;
        }
		
		if($ip != md5($_SERVER["REMOTE_ADDR"].Config::get('key').$uid))
		{
			$user = new User();
            $user->isLogin = false;
            return $user;
		}

        $user = User::find($uid);
        if ($user == null){
            $user = new User();
            $user->isLogin = false;
            return $user;
        }

        if (Hash::cookieHash($user->pass) != $key){
            $user->isLogin = false;
            return $user;
        }
        $user->isLogin = true;
        return $user;
    }

    public  function logout(){
        $time = time() - 1000;
        Utils\Cookie::set([
            "uid" => null,
            "email" => null,
            "key" => null
        ],$time);
    }
}
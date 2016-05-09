<?php

namespace App\Utils;

use App\Models\User;
use App\Services\Config;


Class Duoshuo
{

    static function Add($user)
    {
        if(Config::get('duoshuo_shortname')!='')
		{
			if($user->is_admin==1)
			{
				$role="administrator";
			}
			else
			{
				$role="user";
			}
			$data = array();
			$data['short_name'] = Config::get('duoshuo_shortname');
			$data['secret'] = Config::get('duoshuo_apptoken');
			$data['users'] = array();
			$data['users'][] = array(
				'user_key' => $user->id,
				'name' => $user->user_name,
				'avatar_url' => "https://avatar.zhaojin97.cn/avatar/".md5($user->email)."&r=X&s=80",
				'email' => $user->email,
				'role' => $role
				);
				
			
			
			$param = http_build_query($data, '', '&');
			
			

			$sock = new HTTPSocket;
			$sock->connect("api.duoshuo.com",80); 	
			$sock->set_method('POST');
			$sock->query('/users/import.json',$param);
			
		}
    }
	
}
<?php

namespace App\Utils;

use App\Models\User;
use App\Services\Config;

use App\Utils\HTTPSocket;

Class Da
{

    /**
     * 添加订阅
     */
    static function Add($email)
    {
        if(Config::get('enable_directadmin')=='true')
		{
			$sock = new HTTPSocket;
			$sock->connect(Config::get('da_host'), Config::get('da_port')); 	
			$sock->set_login(Config::get('da_username'),Config::get('da_password'));
			$sock->set_method('GET');
			$sock->query('/CMD_API_EMAIL_LIST?action=add&domain='.Config::get('da_domain').'&name='.Config::get('da_listname').'&type=list&email='.$email);
			$r=$sock->fetch_result();
		}
    }
	
	
	static function Delete($email)
	{
		if(Config::get('enable_directadmin')=='true')
		{
			$sock = new HTTPSocket;
			$sock->connect(Config::get('da_host'), Config::get('da_port')); 	
			$sock->set_login(Config::get('da_username'),Config::get('da_password'));
			$sock->set_method('GET');
			$sock->query('/CMD_API_EMAIL_LIST?action=delete_subscriber&domain='.Config::get('da_domain').'&name='.Config::get('da_listname').'&type=list&select0='.$email);
			$r=$sock->fetch_result();
		}
	}
	
	
}
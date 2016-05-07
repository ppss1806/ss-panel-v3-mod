<?php

namespace App\Models;

/**
 * Ip Model
 */

use App\Utils\Tools;

class LoginIp extends Model

{
	protected $connection = "default";
    protected $table = "login_ip";
	
	public function user()
    {
        return User::find($this->attributes['userid']);
    }
	
	public function datetime()
	{
		return date("Y-m-d H:i:s",$this->attributes['datetime']);
	}





}

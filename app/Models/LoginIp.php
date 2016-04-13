<?php

namespace App\Models;

/**
 * Ip Model
 */

use App\Utils\Tools;

class LoginIp extends Model

{
    protected $table = "login_ip";
	
	public function user()
    {
        return User::find($this->attributes['userid']);
    }





}

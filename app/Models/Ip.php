<?php

namespace App\Models;

/**
 * Ip Model
 */

use App\Utils\Tools;

class Ip extends Model

{
	protected $connection = "default";
    protected $table = "alive_ip";
	
	public function user()
    {
        return User::find($this->attributes['userid']);
    }

	public function Node()
    {
        return Node::find($this->attributes['nodeid']);
    }
	
	
	public function ip()
    {
        return str_replace("::ffff:","",$this->attributes['ip']);
    }



}

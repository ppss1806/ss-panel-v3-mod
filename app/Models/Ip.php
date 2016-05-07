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



}

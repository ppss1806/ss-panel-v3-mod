<?php

namespace App\Models;

/**
 * Node Model
 */

use App\Utils\Tools;

class Speedtest extends Model

{
    protected $table = "speedtest";
	
	public function node()
    {
        return Node::find($this->attributes['nodeid']);
    }





}

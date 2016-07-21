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
        $user = User::where("id",$this->attributes['userid'])->first();
		if($user == NULL)
		{
			Ip::where('id','=',$this->attributes['id'])->delete();
			return null;
		}
        else
		{
			return $user;
		}
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

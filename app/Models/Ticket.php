<?php

namespace App\Models;

/**
 * Ticket Model
 */

class Ticket extends Model

{
	protected $connection = "default";
    protected $table = "ticket";

	public function datetime()
    {
        return date("Y-m-d H:i:s",$this->attributes['datetime']);
    }
	
	public function User()
    {
        return User::where("id",$this->attributes['userid'])->first();
    }



}

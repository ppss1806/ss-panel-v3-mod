<?php


namespace App\Models;

use App\Utils\Tools;

class UnblockIp extends Model
{
	protected $connection = "default";
    protected $table = "unblockip";

    public function user()
    {
        return User::find($this->attributes['userid']);
    }
	
	public function time()
	{
		return date("Y-m-d H:i:s",$this->attributes['datetime']);
	}
	
}
<?php


namespace App\Models;

use App\Utils\Tools;

class BlockIp extends Model
{
	protected $connection = "default";
    protected $table = "blockip";

    public function node()
    {
        return Node::find($this->attributes['nodeid']);
    }
	
	public function time()
	{
		return date("Y-m-d H:i:s",$this->attributes['datetime']);
	}
	
}
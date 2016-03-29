<?php

namespace App\Command;
use App\Models\Node;
use App\Models\User;
use App\Models\RadiusBan;
use App\Utils\Radius;

class Job
{
	public static function syncnode()
    {
		$nodes = Node::all();
        foreach($nodes as $node){
			if($node->sort==0)
			{
				$ip=gethostbyname($node->server);
				$node->node_ip=$ip;
				$node->save();
			}
		}
	}
	
	public static function syncnasnode()
    {
		$nodes = Node::all();
        foreach($nodes as $node){
			if($node->sort==1)
			{
				$ip=gethostbyname($node->server);
				$node->node_ip=$ip;
				$node->save();
				
				Radius::AddNas($node->node_ip,$node->server);
			}
		}
	}
	
	public static function DailyJob()
    {
		$nodes = Node::all();
        foreach($nodes as $node){
			if(strpos($node->name,"Shadowsocks")!=FALSE)
			{
				if(date("d")==$node->bandwidthlimit_resetday)
				{
					$node->node_bandwidth=0;
					$node->save();
				}
			}
		}
	}
	
	public static function CheckJob()
    {
		$users = User::all();
        foreach($users as $user){
			if(($user->transfer_enable<=$user->u+$user->d||$user->enable==0||(strtotime($user->expire_in)<time()&&strtotime($user->expire_in)>644447105))&&RadiusBan::where("userid",$user->id)->first()==null)
			{
				$rb=new RadiusBan();
				$rb->userid=$user->id;
				$rb->save();
				Radius::Delete($user->email);
				
			}
			
			
			if($user->class!=0&&strtotime($user->class_expire)>644447105&&strtotime($user->class_expire)<time())
			{
				$user->class=0;
				$user->save();
			}
		}
		
		$rbusers = RadiusBan::all();
		foreach($rbusers as $sinuser){
			$user=User::find($sinuser->userid);
			if($user->enable==1&&(strtotime($user->expire_in)>time()||strtotime($user->expire_in)<644447105)&&$user->transfer_enable>$user->u+$user->d)
			{
				$sinuser->delete();
				Radius::Add($user,$user->passwd);
			}
		}
		
		
		
		
	}
}
<?php

namespace App\Command;
use App\Models\Node;
use App\Models\User;
use App\Models\RadiusBan;
use App\Models\LoginIp;
use App\Services\Config;
use App\Utils\Radius;
use App\Utils\Tools;
use App\Services\Mail;
use App\Utils\QQWry;
use App\Utils\Duoshuo;
use App\Utils\GA;

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
	
	public static function SyncDuoshuo()
    {
		$users = User::all();
        foreach($users as $user){
			Duoshuo::add($user);
		}
		echo "ok";
	}
	
	public static function UserGa()
    {
		$users = User::all();
        foreach($users as $user){
			
			$ga = new GA();
			$secret = $ga->createSecret();
			
			$user->ga_token=$secret;
			$user->save();
		}
		echo "ok";
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
		//节点掉线检测
		if(Config::get("node_offline_warn")=="true")
		{
			$nodes = Node::all();
			$adminUser = User::where("is_admin","=","1")->get();
			foreach($nodes as $node){
				if(time()-$node->node_heartbeat>90&&time()-$node->node_heartbeat<150&&$node->node_heartbeat!=0&&$node->sort==0)
				{
					foreach($adminUser as $user)
					{
						echo "Send offline mail to user: ".$user->id;
						$subject = Config::get('appName')."-系统警告";
						$to = $user->email;
						$text = "管理员您好，系统发现节点 ".$node->name." 掉线了，请您及时处理。" ;
						try {
							Mail::send($to, $subject, 'news/warn.tpl', [
								"user" => $user,"text" => $text
							], [
							]);
						} catch (Exception $e) {
							echo $e->getMessage();
						}
					}
				}
			}
		}
		
		//登陆地检测
		if(Config::get("login_warn")=="true")
		{
			$iplocation = new QQWry(); 
			$Logs = LoginIp::where("datetime",">",time()-60)->get();
			foreach($Logs as $log){
				$UserLogs=LoginIp::where("userid","=",$log->userid)->orderBy("id","desc")->take(2)->get();
				if($UserLogs->count()==2)
				{
					$i = 0;
					$Userlocation = "";
					foreach($UserLogs as $userlog)
					{
						if($i == 0)
						{
							$location=$iplocation->getlocation($userlog->ip);
							$ip=$userlog->ip;
							$Userlocation = $location['country'];
							$i++;
						}
						else
						{
							$location=$iplocation->getlocation($userlog->ip);
							$nodes=Node::where("node_ip","=",$ip)->first();
							if($Userlocation!=$location['country']&&$nodes==null)
							{
								
								$user=User::where("id","=",$userlog->userid)->first();
								echo "Send warn mail to user: ".$user->id."-".iconv('gbk', 'utf-8//IGNORE', $Userlocation)."-".iconv('gbk', 'utf-8//IGNORE', $location['country']);
								$subject = Config::get('appName')."-系统警告";
								$to = $user->email;
								$text = "您好，系统发现您的账号在 ".iconv('gbk', 'utf-8//IGNORE', $Userlocation)." 有异常登录，请您自己自行核实登陆行为。有异常请及时修改密码。" ;
								try {
									Mail::send($to, $subject, 'news/warn.tpl', [
										"user" => $user,"text" => $text
									], [
									]);
								} catch (Exception $e) {
									echo $e->getMessage();
								}
							}
						}
					}
				}
			}
		}
		
		
		
		
		
		
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
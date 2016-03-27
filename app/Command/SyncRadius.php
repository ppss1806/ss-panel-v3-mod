<?php





namespace App\Command;


use App\Models\User;
use App\Models\Node;
use App\Services\Config;
use App\Services\Mail;
use App\Models\TrafficLog;
use App\Utils\Tools;
use App\Utils\Radius;
use App\Utils\Da;


class SyncRadius
{

	public static function synclogin()
    {
		
		$tempuserbox=array();
		$users = User::all();
        foreach($users as $user){
			$email=$user->email;
			$email=Radius::GetUserName($email);
			$tempuserbox[$email]=$user->id;
		}
		
		/*$tempnodebox=array();
		$nodes = Node::all();
        foreach($nodes as $node){
			if(strpos($node->name,"Shadowsocks")!=FALSE)
			{
				$ip=gethostbyname($node->server);
				$tempnodebox[$ip]=$node->id;
			}
		}*/
		
		
		$dsn = "mysql:host=".Config::get('radius_db_host').";dbname=".Config::get('radius_db_database');  
		$db = new \PDO($dsn, Config::get('radius_db_user'), Config::get('radius_db_password'));
		$stmt = $db->query("SELECT * FROM `radpostauth` WHERE `authdate`<'".date("Y-m-d H:i:s")."' AND`authdate`>'".date("Y-m-d H:i:s",time()-60)."'");
		$result = $stmt->fetchAll();
		
		foreach($result as $row)  
		{  
			//if($row["pass"]!="")
			{
				$traffic = new TrafficLog();
				$traffic->user_id = $tempuserbox[$row["username"]];
				$traffic->u = 0;
				$traffic->d = 10000;
				$traffic->node_id = 1;
				$traffic->rate = 1;
				$traffic->traffic = Tools::flowAutoShow(10000);
				$traffic->log_time = time();
				$traffic->save();
				
				$user=User::find($tempuserbox[$row["username"]]);
				$user->t = time();
				$user->u = $user->u + 0;
				$user->d = $user->d + 10000;
				$user->save();
			}
		}  
		
		
		/*$stmt = $db->query("SELECT * FROM `radacct` WHERE `acctstoptime`<'".date("Y-m-d H:i:s")."' AND `acctstoptime`>'".date("Y-m-d H:i:s",time()-60)."'");
		$result = $stmt->fetchAll();
		
		foreach($result as $row)  
		{  
			$traffic = new TrafficLog();
			$traffic->user_id = $tempuserbox[$row["username"]];
			$traffic->u = $row["acctinputoctets"];
			$traffic->d = $row["acctoutputoctets"];
			$traffic->node_id = 150;
			$traffic->rate = 1;
			$traffic->traffic = Tools::flowAutoShow(($row["acctinputoctets"]+$row["acctoutputoctets"])/1024/1024);
			$traffic->log_time = time();
			$traffic->save();	
			
			$user->t = time();
			$user->u = $user->u + $row["acctinputoctets"];
			$user->d = $user->d + $row["acctoutputoctets"];
			$user->save();
		}  */
		
		
		
	}
	
	
	public static function syncvpn()
    {
		
		$tempuserbox=array();
		$users = User::all();
        foreach($users as $user){
			$email=$user->email;
			$email=Radius::GetUserName($email);
			$tempuserbox[$email]=$user->id;
		}
		
		/*$tempnodebox=array();
		$nodes = Node::all();
        foreach($nodes as $node){
			if(strpos($node->name,"Shadowsocks")!=FALSE)
			{
				$ip=gethostbyname($node->server);
				$tempnodebox[$ip]=$node->id;
			}
		}*/
		
		$dsn = "mysql:host=".Config::get('radius_db_host').";dbname=".Config::get('radius_db_database');  
		$db = new \PDO($dsn, Config::get('radius_db_user'), Config::get('radius_db_password'));
		/*$stmt = $db->query("SELECT * FROM `radpostauth` WHERE `authdate`<'".date("Y-m-d H:i:s")."' AND`authdate`>'".date("Y-m-d H:i:s",time()-60)."'");
		$result = $stmt->fetchAll();
		
		foreach($result as $row)  
		{  
			//if($row["pass"]!="")
			{
				$traffic = new TrafficLog();
				$traffic->user_id = $tempuserbox[$row["username"]];
				$traffic->u = 0;
				$traffic->d = 10000;
				$traffic->node_id = 149;
				$traffic->rate = 1;
				$traffic->traffic = Tools::flowAutoShow(10000);
				$traffic->log_time = time();
				$traffic->save();
				
				$user->t = time();
				$user->u = $user->u + 0;
				$user->d = $user->d + 10000;
				$user->save();
			}
		}  
		*/
		
		$stmt = $db->query("SELECT * FROM `radacct` WHERE `acctstoptime`<'".date("Y-m-d H:i:s")."' AND `acctstoptime`>'".date("Y-m-d H:i:s",time()-60)."'");
		$result = $stmt->fetchAll();
		
		foreach($result as $row)  
		{  
			$traffic = new TrafficLog();
			$traffic->user_id = $tempuserbox[$row["username"]];
			$traffic->u = $row["acctinputoctets"];
			$traffic->d = $row["acctoutputoctets"];
			$traffic->node_id = 2;
			$traffic->rate = 1;
			$traffic->traffic = Tools::flowAutoShow(($row["acctinputoctets"]+$row["acctoutputoctets"]));
			$traffic->log_time = time();
			$traffic->save();	
			
			$user=User::find($tempuserbox[$row["username"]]);
			$user->t = time();
			$user->u = $user->u + $row["acctinputoctets"];
			$user->d = $user->d + $row["acctoutputoctets"];
			$user->save();
		}  
		
		
		
	}
	
    public static function syncusers()
    {
        $users = User::all();
        foreach($users as $user){

			Radius::Add($user,$user->passwd);
			Da::Add($user->email);

			echo "Send sync mail to user: ".$user->id;
			$subject = Config::get('appName')."-密码更新通知";
			$to = $user->email;
			$text = "您好，为了保证密码系统的统一，刚刚系统已经将您 vpn 等连接方式的用户名已经重置为：".$email."，密码自动重置为您 ss 的密码：". $user->passwd."  了，以后您修改 ss 密码就会自动修改 vpn 等连接方式的密码了，感谢您的支持。 " ;
			try{
				Mail::send($to,$subject,$text);
			}catch(\Exception $e){
				echo $e->getMessage();}
        }
    }
}

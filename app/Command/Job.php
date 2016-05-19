<?php

namespace App\Command;
use App\Models\Node;
use App\Models\User;
use App\Models\RadiusBan;
use App\Models\LoginIp;
use App\Models\Speedtest;
use App\Models\Smartline;
use App\Models\Shop;
use App\Models\Bought;
use App\Models\Coupon;
use App\Models\Ip;
use App\Models\NodeInfoLog;
use App\Models\NodeOnlineLog;
use App\Models\TrafficLog;
use App\Services\Config;
use App\Utils\Radius;
use App\Utils\Tools;
use App\Services\Mail;
use App\Utils\QQWry;
use App\Utils\Duoshuo;
use App\Utils\GA;
use CloudXNS\Api;

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
			if($node->sort==0)
			{
				if(date("d")==$node->bandwidthlimit_resetday)
				{
					$node->node_bandwidth=0;
					$node->save();
				}
			}
		}
		
		
		if(date("d")==14)
		{
			Ip::truncate();
			NodeInfoLog::truncate();
			NodeOnlineLog::truncate();
			TrafficLog::truncate();
		}
		
		
		$users = User::all();
        foreach($users as $user){
			
			$user->last_day_t=($user->u+$user->d);
			$user->save();
				
				
			if(date("d")==$user->auto_reset_day)
			{
				$user->u=0;
				$user->d=0;
				$user->transfer_enable=$user->auto_reset_bandwidth*1024*1024*1024;
				$user->save();
			}
		}
		
		
		
		#https://github.com/shuax/QQWryUpdate/blob/master/update.php
		
		$copywrite = file_get_contents("http://update.cz88.net/ip/copywrite.rar");
		
		$adminUser = User::where("is_admin","=","1")->get();
		
		$newmd5 = md5($copywrite);
		$oldmd5 = file_get_contents(BASE_PATH."/storage/qqwry.md5");
		
		if($newmd5 != $oldmd5)
		{
			file_put_contents(BASE_PATH."/storage/qqwry.md5",$newmd5);
			$qqwry = file_get_contents("http://update.cz88.net/ip/qqwry.rar");
			$key = unpack("V6", $copywrite)[6];
			for($i=0; $i<0x200; $i++)
			{
				$key *= 0x805;
				$key ++;
				$key = $key & 0xFF;
				$qqwry[$i] = chr( ord($qqwry[$i]) ^ $key );
			}
			$qqwry = gzuncompress($qqwry);
			$fp = fopen(BASE_PATH."/app/Utils/qqwry.dat", "wb");
			if($fp)
			{
				fwrite($fp, $qqwry);
				fclose($fp);
			}
			
			
		}
		
		for($i=0;$i<5;$i++)
		{
			$iplocation = new QQWry(); 
			$location=$iplocation->getlocation("8.8.8.8");
			$Userlocation = $location['country'];
			if(iconv('gbk', 'utf-8//IGNORE', $Userlocation)!="美国")
			{
				file_put_contents(BASE_PATH."/storage/qqwry.md5",$newmd5);
				$qqwry = file_get_contents("http://update.cz88.net/ip/qqwry.rar");
				$key = unpack("V6", $copywrite)[6];
				for($i=0; $i<0x200; $i++)
				{
					$key *= 0x805;
					$key ++;
					$key = $key & 0xFF;
					$qqwry[$i] = chr( ord($qqwry[$i]) ^ $key );
				}
				$qqwry = gzuncompress($qqwry);
				$fp = fopen(BASE_PATH."/app/Utils/qqwry.dat", "wb");
				if($fp)
				{
					fwrite($fp, $qqwry);
					fclose($fp);
				}
		
			}
			else
			{
				break;
			}
		}
		
		
		
		
		
	}
	
	public static function CheckJob()
    {
		//auto renew
		$boughts=Bought::where("renew","<",time())->where("renew","<>",0)->get();
		foreach($boughts as $bought)
		{
			$user=User::where("id",$bought->userid)->first();
			
			if($user->money>=$bought->price)
			{
				$shop=Shop::where("id",$bought->shopid);
				
				
				if($shop->auto_reset_bandwidth==1)
				{
					$user->u=0;
					$user->d=0;
					$user->transfer_enable=$shop->bandwidth()*1024*1024*1024;
				}
				
				$user->money=$user->money-$bought->price;
				
				$user->save();
				
				$shop->buy($user);
				
				$bought->renew=time()+$shop->auto_renew*86400;
				$bought->save();
				
				$subject = Config::get('appName')."-续费成功";
				$to = $user->email;
				$text = "您好，系统已经为您自动续费，商品名：".$shop->name.",金额:".$bought->price." 元。" ;
				try {
					Mail::send($to, $subject, 'news/warn.tpl', [
						"user" => $user,"text" => $text
					], [
					]);
				} catch (Exception $e) {
					echo $e->getMessage();
				}
				
				if(file_exists(BASE_PATH."/storage/"+$bought->id+".renew", "w+"))
				{
					unlink(BASE_PATH."/storage/"+$bought->id+".renew");
				}
			}
			else
			{
				if(!file_exists(BASE_PATH."/storage/"+$bought->id+".renew", "w+"))
				{
					if($shop->auto_reset_bandwidth==1)
					{
						$user->transfer_enable=$shop->bandwidth()*1024*1024*1024;
					}
				
					$subject = Config::get('appName')."-续费失败";
					$to = $user->email;
					$text = "您好，系统为您自动续费商品名：".$shop->name.",金额:".$bought->price." 元 时，发现您余额不足，请及时充值，当您充值之后，稍等一会系统就会自动扣费为您续费了。" ;
					try {
						Mail::send($to, $subject, 'news/warn.tpl', [
							"user" => $user,"text" => $text
						], [
						]);
					} catch (Exception $e) {
						echo $e->getMessage();
					}
					$myfile = fopen(BASE_PATH."/storage/"+$bought->id+".renew", "w+") or die("Unable to open file!");
					$txt = "1";
					fwrite($myfile, $txt);
					fclose($myfile);
				}
			}
		}
		
		
		
		
		//DNS
		
		if(Config::get("cloudxns_apikey")!="")
		{
			$api=new Api();
			$api->setApiKey(Config::get("cloudxns_apikey"));//修改成自己API KEY
			$api->setSecretKey(Config::get("cloudxns_apisecret"));//修改成自己的SECERET KEY
			
			$api->setProtocol(true);
			
			$domain_json=json_decode($api->domain->domainList());
			
			foreach($domain_json->data as $domain)
			{
				if(strpos($domain->domain,Config::get('cloudxns_domain'))!==FALSE)
				{
					$domain_id=$domain->id;
				}
			}
			
			$Users=User::where("enable","=","1")->get();
			
			$Class_Array=array();
			foreach($Users as $User)
			{
				$Class_Array[$User->class][$User->node_group]=1;
			}
			
			
			foreach($Class_Array as $Class => $value)
			{
				foreach($Class_Array[$Class] as $Group => $v)
				{
					$Telecom_node=0;
					$Unicom_node=0;
					$Cmcc_node=0;
					
					$Telecom_speed=0;
					$Unicom_speed=0;
					$Cmcc_speed=0;
					
					$Nodes=Node::where("node_class","<=",$Class)->where(
						function ($query) {
							$query->where("node_group","=",$Group)
								->orWhere("node_group","=",0);
						}
					)->where("type","1")->get();
					foreach($Nodes as $Node)
					{
						if($node->node_bandwidth_limit==0||$node->node_bandwidth<$node->node_bandwidth_limit)
						{
							$Speed=Speedtest::where("nodeid","=",$Node->id)->where("datetime",">",time()-Config::get('Speedtest_duration')*3600)->orderBy("datetime","desc")->take(1)->first();
							if($Speed!=null)
							{
								$SpeedArray=explode(" ",$Speed->telecomeupload);
								if($SpeedArray[0]!="null")
								{
									if($SpeedArray[0]>$Telecom_speed)
									{
										$Telecom_speed=$SpeedArray[0];
										$Telecom_node=$Node->id;
										
									}
								}
								
								$SpeedArray=explode(" ",$Speed->unicomupload);
								if($SpeedArray[0]!="null")
								{
									if($SpeedArray[0]>$Unicom_speed)
									{
										$Unicom_speed=$SpeedArray[0];
										$Unicom_node=$Node->id;
									}
								}
								
								$SpeedArray=explode(" ",$Speed->cmccupload);
								if($SpeedArray[0]!="null")
								{
									if($SpeedArray[0]>$Cmcc_speed)
									{
										$Cmcc_speed=$SpeedArray[0];
										$Cmcc_node=$Node->id;
									}
								}
							}
						}
					}
					
					
					$smt=Smartline::where('node_class',$Class)->where("node_group","=",$Group)->where("type",0)->first();
					
					if($smt==null)
					{
						$prefix=Tools::genRandomChar(8);
					}
					else
					{
						$prefix=$smt->domain_prefix;
					}
					
					$Telecom_node=Node::where("id",$Telecom_node)->first();
					if(Tools::is_ip($Telecom_node->server))
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Telecom_node->server, 'A', 55, 60, 1),TRUE);
							$t_id=$result['record_id'][0];
						}
						else
						{
							if($smt->t_id!=$Telecom_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Telecom_node->server, 'A', 55, 60, 1,'',$smt->t_id);
							}
						}
					}
					else
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Telecom_node->server, 'CNAME', 55, 60, 1),TRUE);
							$t_id=$result['record_id'][0];
						}
						else
						{
							if($smt->t_id!=$Telecom_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Telecom_node->server, 'CNAME', 55, 60, 1,'',$smt->t_id);
							}
						}
					}
					
					
					
					$Unicom_node=Node::where("id",$Unicom_node)->first();
					if(Tools::is_ip($Unicom_node->server))
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Unicom_node->server, 'A', 55, 60, 3),TRUE);
							
							$u_id=$result['record_id'][0];
						}
						else
						{
							if($smt->u_node!=$Unicom_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Unicom_node->server, 'A', 55, 60, 3,'',$smt->u_id);
							}
						}
					}
					else
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Unicom_node->server, 'CNAME', 55, 60, 3),TRUE);
							$u_id=$result['record_id'][0];
						}
						else
						{
							if($smt->u_node!=$Unicom_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Unicom_node->server, 'CNAME', 55, 60, 3,'',$smt->u_id);
							}
						}
					}
					
					$Cmcc_node=Node::where("id",$Cmcc_node)->first();
					if(Tools::is_ip($Cmcc_node->server))
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Cmcc_node->server, 'A', 55, 60, 144),TRUE);
							$c_id=$result['record_id'][0];
						}
						else
						{
							if($smt->c_node!=$Cmcc_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Cmcc_node->server, 'A', 55, 60, 144,'',$smt->c_id);
							}
						}
					}
					else
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Cmcc_node->server, 'CNAME', 55, 60, 144),TRUE);
							$c_id=$result['record_id'][0];
						}
						else
						{
							if($smt->c_node!=$Cmcc_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Cmcc_node->server, 'CNAME', 55, 60, 144,'',$smt->c_id);
							}
						}
					}
					
					
					if($smt==null)
					{
						
						$smt=new Smartline();
						$smt->node_class=$Class;
						$smt->node_group=$Group;
						$smt->domain_prefix=$prefix;
						$smt->type=0;
						$smt->t_id=$t_id;
						$smt->u_id=$u_id;
						$smt->c_id=$c_id;
						$smt->t_node=$Telecom_node->id;
						$smt->u_node=$Unicom_node->id;
						$smt->c_node=$Cmcc_node->id;
						$smt->save();
					}
					else
					{
						
						$prefix=$smt->domain_prefix;
						$smt->t_node=$Telecom_node->id;
						$smt->u_node=$Unicom_node->id;
						$smt->c_node=$Cmcc_node->id;
						$smt->save();
					}
					
				
				
				}
			}
			
			
			
			foreach($Class_Array as $Class => $Value)
			{
				foreach($Class_Array[$Class] as $Group => $v)
				{
					$Telecom_node=0;
					$Unicom_node=0;
					$Cmcc_node=0;
					
					$Telecom_ping=0;
					$Unicom_ping=0;
					$Cmcc_ping=0;
					
					$Nodes=Node::where("node_class","<=",$Class)->where(
						function ($query) {
							$query->where("node_group","=",$Group)
								->orWhere("node_group","=",0);
						}
					)->where("type","1")->get();
					foreach($Nodes as $Node)
					{
						if($node->node_bandwidth_limit==0||$node->node_bandwidth<$node->node_bandwidth_limit)
						{
							$Speed=Speedtest::where("nodeid","=",$Node->id)->where("datetime",">",time()-Config::get('Speedtest_duration')*3600)->orderBy("datetime","desc")->take(1)->first();
							if($Speed!=null)
							{
								$SpeedArray=explode(" ",$Speed->telecomping);
								if($SpeedArray[0]!="null")
								{
									if($SpeedArray[0]<$Telecom_ping||$Telecom_ping==0)
									{
										$Telecom_ping=$SpeedArray[0];
										$Telecom_node=$Node->id;
									}
								}
								
								$SpeedArray=explode(" ",$Speed->unicomping);
								if($SpeedArray[0]!="null")
								{
									if($SpeedArray[0]<$Unicom_ping||$Unicom_ping==0)
									{
										$Unicom_ping=$SpeedArray[0];
										$Unicom_node=$Node->id;
									}
								}
								
								$SpeedArray=explode(" ",$Speed->cmccping);
								if($SpeedArray[0]!="null")
								{
									if($SpeedArray[0]<$Cmcc_ping||$Cmcc_ping==0)
									{
										$Cmcc_ping=$SpeedArray[0];
										$Cmcc_node=$Node->id;
									}
								}
							}
						}
					}
					
					$smt=Smartline::where('node_class',$Class)->where("node_group","=",$Group)->where("type",1)->first();
					if($smt==null)
					{
						$prefix=Tools::genRandomChar(8);
					}
					else
					{
						$prefix=$smt->domain_prefix;
					}
					
					
					
					$Telecom_node=Node::where("id",$Telecom_node)->first();
					if(Tools::is_ip($Telecom_node->server))
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Telecom_node->server, 'A', 55, 60, 1),TRUE);
							
							$t_id=$result['record_id'][0];
						}
						else
						{
							if($smt->t_id!=$Telecom_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Telecom_node->server, 'A', 55, 60, 1,'',$smt->t_id);
							}
						}
					}
					else
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Telecom_node->server, 'CNAME', 55, 60, 1),TRUE);
							$t_id=$result['record_id'][0];
						}
						else
						{
							if($smt->t_id!=$Telecom_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Telecom_node->server, 'CNAME', 55, 60, 1,'',$smt->t_id);
							}
						}
					}
					
					
					
					$Unicom_node=Node::where("id",$Unicom_node)->first();
					if(Tools::is_ip($Unicom_node->server))
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Unicom_node->server, 'A', 55, 60, 3),TRUE);
							$u_id=$result['record_id'][0];
						}
						else
						{
							if($smt->u_node!=$Unicom_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Unicom_node->server, 'A', 55, 60, 3,'',$smt->u_id);
							}
						}
					}
					else
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Unicom_node->server, 'CNAME', 55, 60, 3),TRUE);
							$u_id=$result['record_id'][0];
						}
						else
						{
							if($smt->u_node!=$Unicom_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Unicom_node->server, 'CNAME', 55, 60, 3,'',$smt->u_id);
							}
						}
					}
					
					$Cmcc_node=Node::where("id",$Cmcc_node)->first();
					if(Tools::is_ip($Cmcc_node->server))
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Cmcc_node->server, 'A', 55, 60, 144),TRUE);
							$c_id=$result['record_id'][0];
						}
						else
						{
							if($smt->c_node!=$Cmcc_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Cmcc_node->server, 'A', 55, 60, 144,'',$smt->c_id);
							}
						}
					}
					else
					{
						if($smt==null)
						{
							$result=json_decode($api->record->recordAdd($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Cmcc_node->server, 'CNAME', 55, 60, 144),TRUE);
							$c_id=$result['record_id'][0];
						}
						else
						{
							if($smt->c_node!=$Cmcc_node->id)
							{
								$api->record->recordUpdate($domain_id, $prefix.'.'.Config::get('cloudxns_prefix'), $Cmcc_node->server, 'CNAME', 55, 60, 144,'',$smt->c_id);
							}
						}
					}
					
					
					if($smt==null)
					{
						$smt=new Smartline();
						$smt->node_class=$Class;
						$smt->node_group=$Group;
						$smt->domain_prefix=$prefix;
						$smt->type=1;
						$smt->t_id=$t_id;
						$smt->u_id=$u_id;
						$smt->c_id=$c_id;
						$smt->t_node=$Telecom_node->id;
						$smt->u_node=$Unicom_node->id;
						$smt->c_node=$Cmcc_node->id;
						$smt->save();
					}
					else
					{
						$prefix=$smt->domain_prefix;
						$smt->t_node=$Telecom_node->id;
						$smt->u_node=$Unicom_node->id;
						$smt->c_node=$Cmcc_node->id;
						$smt->save();
					}
				
				}
			}
			
			$ping=Node::where("id",Config::get('cloudxns_ping_nodeid'))->first();
			$ping->node_heartbeat=time();
			$ping->save();
			
			$speed=Node::where("id",Config::get('cloudxns_speed_nodeid'))->first();
			$speed->node_heartbeat=time();
			$speed->save();
			
		}
		
		$adminUser = User::where("is_admin","=","1")->get();
		
		$newmd5 = md5(file_get_contents("https://github.com/glzjin/ss-panel-v3-mod/raw/master/bootstrap.php"));
		$oldmd5 = md5(file_get_contents(BASE_PATH."/bootstrap.php"));
		
		if($newmd5 == $oldmd5)
		{
			if(file_exists(BASE_PATH."/storage/update.md5"))
			{
				unlink(BASE_PATH."/storage/update.md5");
			}
		}
		else
		{
			if(!file_exists(BASE_PATH."/storage/update.md5"))
			{
				foreach($adminUser as $user)
				{
					echo "Send offline mail to user: ".$user->id;
					$subject = Config::get('appName')."-系统提示";
					$to = $user->email;
					$text = "管理员您好，系统发现有了新版本，您可以到 <a href=\"https://github.com/glzjin/ss-panel-v3-mod/issues\">https://github.com/glzjin/ss-panel-v3-mod/issues</a> 按照步骤进行升级。" ;
					try {
						Mail::send($to, $subject, 'news/warn.tpl', [
							"user" => $user,"text" => $text
						], [
						]);
					} catch (Exception $e) {
						echo $e->getMessage();
					}
					
					
				}
				
				$myfile = fopen(BASE_PATH."/storage/update.md5", "w+") or die("Unable to open file!");
				$txt = "1";
				fwrite($myfile, $txt);
				fclose($myfile);
			}
		}

		
		//节点掉线检测
		if(Config::get("node_offline_warn")=="true")
		{
			$nodes = Node::all();
			
			foreach($nodes as $node){
				if(time()-$node->node_heartbeat>300&&time()-$node->node_heartbeat<360&&$node->node_heartbeat!=0&&($node->sort==0||$node->sort==7||$node->sort==8))
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
					
					$myfile = fopen(BASE_PATH."/storage/"+$node->id+".offline", "w+") or die("Unable to open file!");
					$txt = "1";
					fwrite($myfile, $txt);
					fclose($myfile);
				}
			}
			
			
			foreach($nodes as $node){
				if(time()-$node->node_heartbeat<60&&file_exists(BASE_PATH."/storage/"+$node->id+".offline")&&$node->node_heartbeat!=0&&($node->sort==0||$node->sort==7||$node->sort==8))
				{
					foreach($adminUser as $user)
					{
						echo "Send offline mail to user: ".$user->id;
						$subject = Config::get('appName')."-系统提示";
						$to = $user->email;
						$text = "管理员您好，系统发现节点 ".$node->name." 恢复上线了。" ;
						try {
							Mail::send($to, $subject, 'news/warn.tpl', [
								"user" => $user,"text" => $text
							], [
							]);
						} catch (Exception $e) {
							echo $e->getMessage();
						}
						
						
					}
					
					unlink(BASE_PATH."/storage/"+$node->id+".offline");
				}
			}
		}
		
		//登录地检测
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
							$nodes2=Node::where("node_ip","=",$userlog->ip)->first();
							if($Userlocation!=$location['country']&&$nodes==null&&$nodes2==null)
							{
								
								$user=User::where("id","=",$userlog->userid)->first();
								echo "Send warn mail to user: ".$user->id."-".iconv('gbk', 'utf-8//IGNORE', $Userlocation)."-".iconv('gbk', 'utf-8//IGNORE', $location['country']);
								$subject = Config::get('appName')."-系统警告";
								$to = $user->email;
								$text = "您好，系统发现您的账号在 ".iconv('gbk', 'utf-8//IGNORE', $Userlocation)." 有异常登录，请您自己自行核实登录行为。有异常请及时修改密码。" ;
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
<?php

namespace App\Controllers;

use App\Models\InviteCode;
use App\Services\Auth;
use App\Models\Node,App\Models\TrafficLog,App\Models\CheckInLog,App\Models\Ann;
use App\Services\Config;
use App\Utils\Hash,App\Utils\Tools,App\Utils\Radius,App\Utils\Da;

use App\Models\User;
use App\Models\Code;



/**
 *  HomeController
 */
class UserController extends BaseController
{

    private $user;

    public function __construct()
    {
        $this->user = Auth::getUser();
    }

    public function index()
    {
		$Anns = Ann::orderBy('id', 'desc')->get();
        return $this->view()->assign('anns',$Anns)->assign('duoshuo_shortname',Config::get('duoshuo_shortname'))->assign('baseUrl',Config::get('baseUrl'))->display('user/index.tpl');
    }
	
	public function code($request, $response, $args)
    {
		$pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
		$codes = Code::where('userid','=',$this->user->id)->orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
		$codes->setPath('/user/code');
        return $this->view()->assign('codes',$codes)->display('user/code.tpl');
    }
	
	public function codepost($request, $response, $args)
    {
		$code = $request->getParam('code');
		$user = $this->user;
		

		
		if ( $code == "") {
            $res['ret'] = 0;
            $res['msg'] = "请填好兑换码";
            return $response->getBody()->write(json_encode($res));
        }
		
		$codeq=Code::where("code","=",$code)->where("isused","=",0)->first();
        if ( $codeq == null) {
            $res['ret'] = 0;
            $res['msg'] = "此兑换码错误";
            return $response->getBody()->write(json_encode($res));
        }
		
		$codeq->isused=1;
		$codeq->usedatetime=date("Y-m-d H:i:s");
		$codeq->userid=$user->id;
		$codeq->save();
		
		if($codeq->type==10001)
		{
			$user->transfer_enable=$user->transfer_enable+$codeq->number*1024*1024*1024;
			$user->save();
		}
		
		if($codeq->type==10002)
		{
			if(time()>strtotime($user->expire_in))
			{
				$user->expire_in=date("Y-m-d H:i:s",time()+$codeq->number*86400);
			}
			else
			{
				$user->expire_in=date("Y-m-d H:i:s",strtotime($user->expire_in)+$codeq->number*86400);
			}
			$user->save();
		}
		
		if($codeq->type>=1&&$codeq->type<=10000)
		{
			if($user->class==0)
			{
				$user->class_expire=date("Y-m-d H:i:s",time());
				$user->save();
			}
			$user->class_expire=date("Y-m-d H:i:s",strtotime($user->class_expire)+$codeq->number*86400);
			$user->class=$codeq->type;
			$user->save();
		}
		
		$res['ret'] = 1;
		$res['msg'] = "兑换成功";
        return $response->getBody()->write(json_encode($res));
    }

    public function node()
    {
        $user = Auth::getUser();
        $nodes = Node::where('type', 1)->orderBy('name')->get();
		$node_prefix=Array();
		$node_method=Array();
		$a=0;
		$node_order=array();
		$node_alive=array();
		$node_prealive=array();
		$node_heartbeat=Array();
		$node_bandwidth=Array();
		
		foreach ($nodes as $node) {
			if($user->class>=$node->node_class)
			{
				$temp=explode(" - ",$node->name);
				if(!isset($node_prefix[$temp[0]]))
				{
					$node_prefix[$temp[0]]=array();
					$node_order[$temp[0]]=$a;
					$node_alive[$temp[0]]=0;
					$node_method[$temp[0]]=$temp[1];
					$a++;
				}

				if($node->sort==0)
				{
					$node_tempalive=$node->getOnlineUserCount();
					$node_prealive[$node->id]=$node_tempalive;
					if(time()-$node->node_heartbeat>90||$node->node_heartbeat==0)
					{
						$node_heartbeat[$temp[0]]="离线";
					}
					else
					{
						$node_heartbeat[$temp[0]]="在线";
					}
					
					if($node->node_bandwidth_limit==0)
					{
						$node_bandwidth[$temp[0]]=(int)($node->node_bandwidth/1024/1024/1024)." GB / 不限";
					}
					else
					{
						$node_bandwidth[$temp[0]]=(int)($node->node_bandwidth/1024/1024/1024)." GB / ".(int)($node->node_bandwidth_limit/1024/1024/1024)." GB - ".$node->bandwidthlimit_resetday." 日重置";
					}
					
					if($node_tempalive!="暂无数据")
					{

						$node_alive[$temp[0]]=$node_alive[$temp[0]]+$node_tempalive;

					}
				}
				else
				{
					$node_prealive[$node->id]="暂无数据";
				}
				
				if(strpos($node_method[$temp[0]],$temp[1])===FALSE)
				{
					$node_method[$temp[0]]=$node_method[$temp[0]]." ".$temp[1];
				}
		
				
				
				array_push($node_prefix[$temp[0]],$node);
				
			}
		}
		$node_prefix=(object)$node_prefix;
		$node_order=(object)$node_order;
        return $this->view()->assign('node_method', $node_method)->assign('node_bandwidth',$node_bandwidth)->assign('node_heartbeat',$node_heartbeat)->assign('node_prefix', $node_prefix)->assign('node_prealive', $node_prealive)->assign('node_order', $node_order)->assign('user', $user)->assign('node_alive', $node_alive)->display('user/node.tpl');
    }


    public function nodeInfo($request, $response, $args)
    {
		$user = Auth::getUser();
        $id = $args['id'];
        $node = Node::find($id);

        if ($node == null) {

        }


		switch ($node->sort) { 

			case 0: 
				if($user->class>=$node->node_class)
				{
					$ary['server'] = $node->server;
					$ary['server_port'] = $this->user->port;
					$ary['password'] = $this->user->passwd;
					$ary['method'] = $node->method;
					if ($node->custom_method) {
						$ary['method'] = $this->user->method;
					}
					$json = json_encode($ary);
					$json_show = json_encode($ary, JSON_PRETTY_PRINT);
					$ssurl = $ary['method'] . ":" . $ary['password'] . "@" . $ary['server'] . ":" . $ary['server_port'];
					$ssqr = "ss://" . base64_encode($ssurl);

					$surge_base = Config::get('baseUrl') . "/downloads/ProxyBase.conf";
					$surge_proxy = "#!PROXY-OVERRIDE:ProxyBase.conf\n";
					$surge_proxy .= "[Proxy]\n";
					$surge_proxy .= "Proxy = custom," . $ary['server'] . "," . $ary['server_port'] . "," . $ary['method'] . "," . $ary['password'] . "," . Config::get('baseUrl') . "/downloads/SSEncrypt.module";
					return $this->view()->assign('ary', $ary)->assign('json', $json)->assign('global_url',Config::get('baseUrl')."/downloads")->assign('json_show', $json_show)->assign('ssqr', $ssqr)->assign('surge_base', $surge_base)->assign('surge_proxy', $surge_proxy)->assign('info_server', $ary['server'])->assign('info_port', $this->user->port)->assign('info_method', $ary['method'])->assign('info_pass', $this->user->passwd)->display('user/nodeinfo.tpl');
				}
			break; 

			case 1: 
				if($user->class>=$node->node_class)
				{
						
					$email=$this->user->email;
					$email=Radius::GetUserName($email);
					$json_show="VPN 信息<br>地址：".$node->server."<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

					return $this->view()->assign('json_show', $json_show)->display('user/nodeinfovpn.tpl');
				}
			break; 

			case 2: 
				if($user->class>=$node->node_class)
				{
					$email=$this->user->email;
					$email=Radius::GetUserName($email);
					$json_show="SSH 信息<br>地址：".$node->server."<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

					return $this->view()->assign('json_show', $json_show)->display('user/nodeinfossh.tpl');

				}

			break; 


			case 3: 
				if($user->class>=$node->node_class)
				{

					$email=$this->user->email;
					$email=Radius::GetUserName($email);
					$json_show="PAC 信息<br>地址：".$node->server."<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

					return $this->view()->assign('json_show', $json_show)->display('user/nodeinfopac.tpl');

				}

			break; 

			case 4: 
				if($user->class>=$node->node_class)
				{
					$email=$this->user->email;
					$email=Radius::GetUserName($email);
					$json_show="APN 信息<br>下载地址：".$node->server."<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

					return $this->view()->assign('json_show', $json_show)->display('user/nodeinfoapn.tpl');

				}

			break; 

			case 5: 
				if($user->class>=$node->node_class)
				{
					$email=$this->user->email;
					$email=Radius::GetUserName($email);
					$json_show="Anyconnect 信息<br>地址：".$node->server."<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

					return $this->view()->assign('json_show', $json_show)->display('user/nodeinfoanyconnect.tpl');
				}


			break; 

			case 6: 
				if($user->class>=$node->node_class)
				{
					$email=$this->user->email;
					$email=Radius::GetUserName($email);
					$json_show="APN 文件<br>移动地址：".Config::get('baseUrl')."/downloads/node_apn.php?server=".$node->server."&isp=cmcc<br>联通地址：".Config::get('baseUrl')."/downloads/node_apn.php?server=".$node->server."&isp=cnunc<br>电信地址：".Config::get('baseUrl')."/downloads/node_apn.php?server=".$node->server."&isp=ctnet<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

					return $this->view()->assign('json_show', $json_show)->display('user/nodeinfoapndownload.tpl');
				}


			break; 

			case 7: 
				if($user->class>=$node->node_class)
				{
					$email=$this->user->email;
					$email=Radius::GetUserName($email);
					$json_show="PAC Plus 信息<br>PAC 地址：".Config::get('baseUrl')."downloads/node_pac.php?address=".$node->server."&port=".($this->user->port-20000)."<br>支持方式：".$node->method."<br>备注：".$node->info;


					return $this->view()->assign('json_show', $json_show)->display('user/nodeinfopacplus.tpl');
				}


			break; 

			case 8: 
				if($user->class>=$node->node_class)
				{
					$email=$this->user->email;
					$email=Radius::GetUserName($email);
					$json_show="PAC Plus Plus信息<br>PAC 一般地址：".Config::get('baseUrl')."/downloads/node_pacpp.php?address=".$node->server."&port=".($this->user->port-20000)."<br>PAC iOS 地址：".Config::get('baseUrl')."/downloads/node_pacpp.php?address=".$node->server."&port=".($this->user->port-20000)."&ios=1<br>"."备注：".$node->info;

					return $this->view()->assign('json_show', $json_show)->display('user/nodeinfopacpp.tpl');
				}


			break; 



			default: 
				echo "微笑"; 

		}








    }

    public function profile()
    {
        return $this->view()->display('user/profile.tpl');
    }

    public function edit()
    {
		$themes=Tools::getDir(BASE_PATH."/resources/views");
        return $this->view()->assign('user',$this->user)->assign('themes',$themes)->display('user/edit.tpl');
    }


    public function invite()
    {
        $codes = $this->user->inviteCodes();
        return $this->view()->assign('codes', $codes)->display('user/invite.tpl');
    }

    public function doInvite($request, $response, $args)
    {
        $n = $this->user->invite_num;
        if ($n < 1) {
            $res['ret'] = 0;
            return $response->getBody()->write(json_encode($res));
        }
        for ($i = 0; $i < $n; $i++) {
            $char = Tools::genRandomChar(32);
            $code = new InviteCode();
            $code->code = $char;
            $code->user_id = $this->user->id;
            $code->save();
        }
        $this->user->invite_num = 0;
        $this->user->save();
        $res['ret'] = 1;
        return $this->echoJson($response, $res);
    }

    public function sys()
    {
        return $this->view()->assign('ana', "")->display('user/sys.tpl');
    }

    public function updatePassword($request, $response, $args)
    {
        $oldpwd = $request->getParam('oldpwd');
        $pwd = $request->getParam('pwd');
        $repwd = $request->getParam('repwd');
        $user = $this->user;
        if (!Hash::checkPassword($user->pass, $oldpwd)) {
            $res['ret'] = 0;
            $res['msg'] = "旧密码错误";
            return $response->getBody()->write(json_encode($res));
        }
        if ($pwd != $repwd) {
            $res['ret'] = 0;
            $res['msg'] = "两次输入不符合";
            return $response->getBody()->write(json_encode($res));
        }

        if (strlen($pwd) < 8) {
            $res['ret'] = 0;
            $res['msg'] = "密码太短啦";
            return $response->getBody()->write(json_encode($res));
        }
        $hashPwd = Hash::passwordHash($pwd);
        $user->pass = $hashPwd;
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = "ok";
        return $this->echoJson($response, $res);
    }
	
	public function updateWechat($request, $response, $args)
    {
        $wechat = $request->getParam('wechat');
        
        $user = $this->user;
		
		if ( $wechat == "") {
            $res['ret'] = 0;
            $res['msg'] = "请填好微信号";
            return $response->getBody()->write(json_encode($res));
        }
		
		$user1 = User::where('wechat',$wechat)->first();
        if ( $user1 != null) {
            $res['ret'] = 0;
            $res['msg'] = "此微信号已经被注册了";
            return $response->getBody()->write(json_encode($res));
        }
        
        $user->wechat = filter_var($wechat, FILTER_SANITIZE_STRING);
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = "ok";
        return $this->echoJson($response, $res);
    }
	
	public function updateTheme($request, $response, $args)
    {
        $theme = $request->getParam('theme');
        
        $user = $this->user;
		
		if ( $theme == "") {
            $res['ret'] = 0;
            $res['msg'] = "???";
            return $response->getBody()->write(json_encode($res));
        }
		
        
        $user->theme = filter_var($theme, FILTER_SANITIZE_STRING);
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = "ok";
        return $this->echoJson($response, $res);
    }
	
	
	public function updateMail($request, $response, $args)
    {
        $mail = $request->getParam('mail');
        
        $user = $this->user;
		
		if ( !($mail == "1"||$mail == "0")) {
            $res['ret'] = 0;
            $res['msg'] = "悟空别闹";
            return $response->getBody()->write(json_encode($res));
        }
		
        
        $user->sendDailyMail = $mail;
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = "ok";
        return $this->echoJson($response, $res);
    }


    public function updateSsPwd($request, $response, $args)
    {
        $user = Auth::getUser();
        $pwd = $request->getParam('sspwd');
        $user->updateSsPwd($pwd);
        $res['ret'] = 1;


        Radius::Add($user,$pwd);




        return $this->echoJson($response, $res);
    }

    public function updateMethod($request, $response, $args)
    {
        $user = Auth::getUser();
        $method = $request->getParam('method');
        $method = strtolower($method);
        $user->updateMethod($method);
        $res['ret'] = 1;
        return $this->echoJson($response, $res);
    }

    public function logout($request, $response, $args)
    {
        Auth::logout();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/auth/login');
        return $newResponse;
    }

    public function doCheckIn($request, $response, $args)
    {
        if (!$this->user->isAbleToCheckin()) {
            $res['msg'] = "您似乎已经续命过了...";
            $res['ret'] = 1;
            return $response->getBody()->write(json_encode($res));
        }
        $traffic = rand(Config::get('checkinMin'), Config::get('checkinMax'));
        $this->user->transfer_enable = $this->user->transfer_enable + Tools::toMB($traffic);
        $this->user->last_check_in_time = time();
        $this->user->save();
        $res['msg'] = sprintf("获得了 %u MB流量.", $traffic);
        $res['ret'] = 1;
        return $this->echoJson($response, $res);
    }

    public function kill($request, $response, $args)
    {
        return $this->view()->display('user/kill.tpl');
    }

    public function handleKill($request, $response, $args)
    {
        $user = Auth::getUser();
		
		Da::delete($email);
			
        $passwd = $request->getParam('passwd');
        // check passwd
        $res = array();
        if (!Hash::checkPassword($user->pass, $passwd)) {
            $res['ret'] = 0;
            $res['msg'] = " 密码错误";
            return $this->echoJson($response, $res);
        }

		Radius::Delete($email);

        Auth::logout();
        $user->delete();
        $res['ret'] = 1;
        $res['msg'] = "GG!您的帐号已经从我们的系统中删除.";
        return $this->echoJson($response, $res);
    }

    public function trafficLog($request, $response, $args){
        $pageNum = 1;
        if(isset($request->getQueryParams()["page"])){
            $pageNum = $request->getQueryParams()["page"];
        }
		$traffic=TrafficLog::where('user_id',$this->user->id)->where("log_time",">",(time()-3*86400))->orderBy('id', 'desc')->get();
		
		
		$a=0;
		$log_order=array();
		$lasttime=0;
		$nodes=array();
		foreach ($traffic as $log) {
			if($lasttime==0||$lasttime-$log->log_time>1800)
			{
				if($a>50)
				{
					break;
				}
				$log_order[$a]=array();
				$log_order[$a]["node"]=Node::find($log->node_id)->name;
				$rate=$log->rate;
				if($log_order[$a]["node"]=="")
				{
					$log_order[$a]["node"]="阿卡林";
				}
				$nodes[$log->node_id]=Node::find($log->node_id)->name;
				$log_order[$a]["d"]=($log->d/1024/1024)*$rate;
				$log_order[$a]["time"]=date("Y-m-d H:i:s", $log->log_time);
				$a++;
				$log_order[$a-1]["id"]=$a;
			}
			else
			{
				$d=$log->d;
				if(!isset($nodes[$log->node_id]))
				{

					$nodes[$log->node_id]=Node::find($log->node_id)->name;
					$rate=$log->rate;


				}

				$node=$nodes[$log->node_id];
				$log_order[$a-1]["d"]=$log_order[$a-1]["d"]+($d/1024/1024)*$log->rate;
				if(strpos($log_order[$a-1]["node"],$node)===FALSE)
				{

					$log_order[$a-1]["node"]=$log_order[$a-1]["node"]." & ".$node;

				}
			}
			$lasttime=$log->log_time;
		}


		$log_order=(object)$log_order;
		//var_dump($log_order);
        //$log_order = $log_order->paginate(15,['*'],'page',$pageNum);
        //$log_order->setPath('/user/trafficlog');
        return $this->view()->assign('logs', $log_order)->display('user/trafficlog.tpl');
    }
}

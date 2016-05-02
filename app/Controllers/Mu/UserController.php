<?php

namespace App\Controllers\Mu;

use App\Models\Node;
use App\Models\TrafficLog;
use App\Models\User;
use App\Controllers\BaseController;
use App\Utils\Tools;

class UserController extends BaseController
{
    // User List
    public function index($request, $response, $args)
    {
		$node = Node::where("node_ip","=",$_SERVER["REMOTE_ADDR"])->where("sort","=","0")->first();
		$node->node_heartbeat=time();
		$node->save();
		
		if($node->node_group!=0)
		{
			$users = User::where("class",">=",$node->node_class)->where("node_group","=",$node->node_group)->where("expire_in",">",date("Y-m-d H:i:s"))->get();
		}
		else
		{
			$users = User::where("class",">=",$node->node_class)->where("expire_in",">",date("Y-m-d H:i:s"))->get();
		}
		if($node->node_bandwidth_limit!=0)
		{
			if($node->node_bandwidth_limit<$node->node_bandwidth)
			{
				$users=null;
			}
			
		}
		
		
		
		$users=(object)$users;
		
        $res = [
            "ret" => 1,
            "msg" => "ok",
            "data" => $users
        ];
        return $this->echoJson($response, $res);
    }

    //   Update Traffic
    public function addTraffic($request, $response, $args)
    {
        $id = $args['id'];
        $u = $request->getParam('u');
        $d = $request->getParam('d');
        $nodeId = $request->getParam('node_id');
        $node = Node::find($nodeId);
		
		$node->node_bandwidth=$node->node_bandwidth+$d+$u;
		
		$node->save();
		
		
        $rate = $node->traffic_rate;
        $user = User::find($id);

        $user->t = time();
        $user->u = $user->u + ($u * $rate);
        $user->d = $user->d + ($d * $rate);
        if (!$user->save()) {
            $res = [
                "ret" => 0,
                "msg" => "update failed",
            ];
            //return $this->echoJson($response, $res);
        }
        // log
        $traffic = new TrafficLog();
        $traffic->user_id = $id;
        $traffic->u = $u;
        $traffic->d = $d;
        $traffic->node_id = $nodeId;
        $traffic->rate = $rate;
        $traffic->traffic = Tools::flowAutoShow(($u + $d) * $rate);
        $traffic->log_time = time();
        $traffic->save();

        $res = [
            "ret" => 1,
            "msg" => "ok",
        ];
        return $this->echoJson($response, $res);
    }
}
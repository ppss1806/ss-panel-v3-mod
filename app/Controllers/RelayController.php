<?php

namespace App\Controllers;

use App\Models\Relay;
use App\Models\Node;
use App\Models\User;
use App\Services\Auth;
use App\Controllers\UserController;

class RelayController extends UserController
{
	public function index($request, $response, $args){
		$pageNum = 1;
		$user = Auth::getUser();
		if (isset($request->getQueryParams()["page"])) {
			$pageNum = $request->getQueryParams()["page"];
		}
		$logs = Relay::where('user_id', $user->id)->paginate(15, ['*'], 'page', $pageNum);
		$logs->setPath('/user/relay');
		return $this->view()->assign('rules',$logs)->display('user/relay/index.tpl');
	}

	public function create($request, $response, $args){
		$user = Auth::getUser();
		$source_nodes = Node::where(
			function ($query) use ($user) {
				$query->Where("node_group","=",$user->node_group)
					->orWhere("node_group","=",0);
			}
		)->where('type', 1)->where('sort',10)->where("node_class","<=",$user->class)->orderBy('name')->get();
		
		$dist_nodes = Node::where(
			function ($query) use ($user) {
				$query->Where("node_group","=",$user->node_group)
					->orWhere("node_group","=",0);
			}
		)->where('type', 1)->where('sort',0)->where("node_class","<=",$user->class)->orderBy('name')->get();
		
		$ports_raw = Node::where(
			function ($query) use ($user) {
				$query->Where("node_group","=",$user->node_group)
					->orWhere("node_group","=",0);
			}
		)->where('type', 1)->where('sort',9)->where("node_class","<=",$user->class)->orderBy('name')->get();
		
		$ports = Array();
		foreach($ports_raw as $port_raw)
		{
			$mu_user = User::where('port', $port_raw->server)->first();
			if($mu_user->is_multi_user == 1)
			{
				array_push($ports, $port_raw->server);
			}
		}
		
		array_push($ports, $user->port);
		
		return $this->view()->assign('source_nodes', $source_nodes)->assign('dist_nodes', $dist_nodes)->assign('ports', $ports)->display('user/relay/add.tpl');
	}

	public function add($request, $response, $args){
		$user = Auth::getUser();
		
		$dist_node_id = $request->getParam('dist_node');
		$source_node_id = $request->getParam('source_node');
		$port = $request->getParam('port');
		$priority = $request->getParam('priority');
		
		$source_node = Node::where('id', $source_node_id)->where(
			function ($query) use ($user) {
				$query->Where("node_group", "=", $user->node_group)
					->orWhere("node_group", "=", 0);
			}
		)->where('type', 1)->where('sort', 10)->where("node_class", "<=", $user->class)->first();
		if($source_node == NULL && $source_node_id != 0)
		{
			$rs['ret'] = 0;
			$rs['msg'] = "美国的华莱士";
			return $response->getBody()->write(json_encode($rs));
		}
		
		$dist_node = Node::where('id', $dist_node_id)->where(
			function ($query) use ($user) {
				$query->Where("node_group", "=", $user->node_group)
					->orWhere("node_group", "=", 0);
			}
		)->where('type', 1)->where('sort', 0)->where("node_class", "<=", $user->class)->first();
		if($dist_node == NULL)
		{
			$rs['ret'] = 0;
			$rs['msg'] = "不知道比你们高到哪里去了";
			return $response->getBody()->write(json_encode($rs));
		}
		
		$port_raw = Node::where('server', $port)->where(
			function ($query) use ($user) {
				$query->Where("node_group","=",$user->node_group)
					->orWhere("node_group","=",0);
			}
		)->where('type', 1)->where('sort',9)->where("node_class","<=",$user->class)->first();
		if($port_raw == NULL && $port != $user->port)
		{
			$rs['ret'] = 0;
			$rs['msg'] = "我和他谈笑风生";
			return $response->getBody()->write(json_encode($rs));
		}
		
		
		$rule = new Relay();
		$rule->user_id = $user->id;
		$rule->dist_node_id = $dist_node_id;
		$rule->dist_ip = $dist_node->node_ip;
		$rule->source_node_id = $source_node_id;
		$rule->port = $port;
		$rule->priority = $priority;

		if(!$rule->save()){
			$rs['ret'] = 0;
			$rs['msg'] = "添加失败";
			return $response->getBody()->write(json_encode($rs));
		}
	
		$rs['ret'] = 1;
		$rs['msg'] = "添加成功";
		return $response->getBody()->write(json_encode($rs));
	}

	public function edit($request, $response, $args){
		$id = $args['id'];
		
		$user = Auth::getUser();
		$rule = Relay::where('id', $id)->where('user_id', $user->id)->first();
		
		if($rule == NULL)
		{
			exit(0);
		}
		
		$user = Auth::getUser();
		$source_nodes = Node::where(
			function ($query) use ($user) {
				$query->Where("node_group","=",$user->node_group)
					->orWhere("node_group","=",0);
			}
		)->where('type', 1)->where('sort',10)->where("node_class","<=",$user->class)->orderBy('name')->get();
		
		$dist_nodes = Node::where(
			function ($query) use ($user) {
				$query->Where("node_group","=",$user->node_group)
					->orWhere("node_group","=",0);
			}
		)->where('type', 1)->where('sort',0)->where("node_class","<=",$user->class)->orderBy('name')->get();
		
		$ports_raw = Node::where(
			function ($query) use ($user) {
				$query->Where("node_group","=",$user->node_group)
					->orWhere("node_group","=",0);
			}
		)->where('type', 1)->where('sort',9)->where("node_class","<=",$user->class)->orderBy('name')->get();
		
		$ports = Array();
		foreach($ports_raw as $port_raw)
		{
			$mu_user = User::where('port', $port_raw->server)->first();
			if($mu_user->is_multi_user == 1)
			{
				array_push($ports, $port_raw->server);
			}
		}
		
		array_push($ports, $user->port);
		
		return $this->view()->assign('rule',$rule)->assign('source_nodes', $source_nodes)->assign('dist_nodes', $dist_nodes)->assign('ports', $ports)->display('user/relay/edit.tpl');
	}

	public function update($request, $response, $args){
		$id = $args['id'];
		$user = Auth::getUser();
		$rule = Relay::where('id', $id)->where('user_id', $user->id)->first();
		
		if($rule == NULL)
		{
			exit(0);
		}

		$dist_node_id = $request->getParam('dist_node');
		$source_node_id = $request->getParam('source_node');
		$port = $request->getParam('port');
		$priority = $request->getParam('priority');
		
		$source_node = Node::where('id', $source_node_id)->where(
			function ($query) use ($user) {
				$query->Where("node_group", "=", $user->node_group)
					->orWhere("node_group", "=", 0);
			}
		)->where('type', 1)->where('sort', 10)->where("node_class", "<=", $user->class)->first();
		if($source_node == NULL && $source_node_id != 0)
		{
			$rs['ret'] = 0;
			$rs['msg'] = "我告诉你们我是身经百战了";
			return $response->getBody()->write(json_encode($rs));
		}
		
		$dist_node = Node::where('id', $dist_node_id)->where(
			function ($query) use ($user) {
				$query->Where("node_group", "=", $user->node_group)
					->orWhere("node_group", "=", 0);
			}
		)->where('type', 1)->where('sort', 0)->where("node_class", "<=", $user->class)->first();
		if($dist_node == NULL)
		{
			$rs['ret'] = 0;
			$rs['msg'] = "见得多了";
			return $response->getBody()->write(json_encode($rs));
		}
		
		$port_raw = Node::where('server', $port)->where(
			function ($query) use ($user) {
				$query->Where("node_group","=",$user->node_group)
					->orWhere("node_group","=",0);
			}
		)->where('type', 1)->where('sort',9)->where("node_class","<=",$user->class)->first();
		if($port_raw == NULL && $port != $user->port)
		{
			$rs['ret'] = 0;
			$rs['msg'] = "西方的哪个国家我没去过";
			return $response->getBody()->write(json_encode($rs));
		}
		
		
		$rule->user_id = $user->id;
		$rule->dist_node_id = $dist_node_id;
		$rule->dist_ip = $dist_node->node_ip;
		$rule->source_node_id = $source_node_id;
		$rule->port = $port;
		$rule->priority = $priority;
		
		
		if(!$rule->save()){
			$rs['ret'] = 0;
			$rs['msg'] = "修改失败";
			return $response->getBody()->write(json_encode($rs));
		}
		
		$rs['ret'] = 1;
		$rs['msg'] = "修改成功";
		return $response->getBody()->write(json_encode($rs));
	}


	public function delete($request, $response, $args){
		$id = $request->getParam('id');
		$user = Auth::getUser();
		$rule = Relay::where('id', $id)->where('user_id', $user->id)->first();
		
		if($rule == NULL)
		{
			exit(0);
		}
		
		if(!$rule->delete()){
			$rs['ret'] = 0;
			$rs['msg'] = "删除失败";
			return $response->getBody()->write(json_encode($rs));
		}
		$rs['ret'] = 1;
		$rs['msg'] = "删除成功";
		return $response->getBody()->write(json_encode($rs));
	}

}

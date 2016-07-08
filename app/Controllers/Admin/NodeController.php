<?php

namespace App\Controllers\Admin;

use App\Models\Node;
use App\Utils\Radius;
use App\Controllers\AdminController;

class NodeController extends AdminController
{
    public function index($request, $response, $args){
		
		$pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
		$nodes = Node::paginate(15, ['*'], 'page', $pageNum);
		$nodes->setPath('/admin/node');
		
        return $this->view()->assign('nodes',$nodes)->display('admin/node/index.tpl');
    }

    public function create($request, $response, $args){
        return $this->view()->display('admin/node/create.tpl');
    }

    public function add($request, $response, $args){
        $node = new Node();
        $node->name =  $request->getParam('name');
        $node->server =  $request->getParam('server');
        $node->method =  $request->getParam('method');
        $node->custom_method =  $request->getParam('custom_method');
        $node->custom_rss =  $request->getParam('custom_rss');
        $node->traffic_rate = $request->getParam('rate');
        $node->info = $request->getParam('info');
        $node->type = $request->getParam('type');
		$node->node_group = $request->getParam('group');
		$node->node_speedlimit = $request->getParam('node_speedlimit');
        $node->status = $request->getParam('status');
		$node->sort = $request->getParam('sort');
		if($node->sort==0)
		{
			$node->node_ip=gethostbyname($request->getParam('server'));
		}
		else
		{
			$node->node_ip="";
		}
		
		if($node->sort==1)
		{
			$node->node_ip=gethostbyname($request->getParam('server'));
			Radius::AddNas($node->node_ip,$request->getParam('server'));
		}
		$node->node_class=$request->getParam('class');
		$node->node_bandwidth_limit=$request->getParam('node_bandwidth_limit')*1024*1024*1024;
		$node->bandwidthlimit_resetday=$request->getParam('bandwidthlimit_resetday');
        
        if(!$node->save()){
            $rs['ret'] = 0;
            $rs['msg'] = "添加失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "节点添加成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function edit($request, $response, $args){
        $id = $args['id'];
        $node = Node::find($id);
        if ($node == null){

        }
        return $this->view()->assign('node',$node)->display('admin/node/edit.tpl');
    }

    public function update($request, $response, $args){
        $id = $args['id'];
        $node = Node::find($id);

        $node->name =  $request->getParam('name');
		$node->node_group =  $request->getParam('group');
        $node->server =  $request->getParam('server');
        $node->method =  $request->getParam('method');
        $node->custom_method =  $request->getParam('custom_method');
        $node->custom_rss =  $request->getParam('custom_rss');
        $node->traffic_rate = $request->getParam('rate');
        $node->info = $request->getParam('info');
		$node->node_speedlimit = $request->getParam('node_speedlimit');
        $node->type = $request->getParam('type');
		$node->sort = $request->getParam('sort');
		if($node->sort==0)
		{
			if(time()-$node->node_heartbeat<300)
			{
				$node->node_ip=gethostbyname($request->getParam('server'));
			}
		}
		else
		{
			$node->node_ip="";
		}
		
		if($node->sort==1)
		{
			$SS_Node=Node::where('sort','=',0)->where('server','=',$request->getParam('server'))->first();
			if($SS_Node!=null)
			{
				if(time()-$SS_Node->node_heartbeat<300||$SS_Node->node_heartbeat==0)
				{
					$node->node_ip=gethostbyname($request->getParam('server'));
					Radius::AddNas($node->node_ip,$request->getParam('server'));
				}
			}
			else
			{
				$node->node_ip=gethostbyname($request->getParam('server'));
				Radius::AddNas($node->node_ip,$request->getParam('server'));
			}
		}

        $node->status = $request->getParam('status');
		$node->node_class=$request->getParam('class');
		$node->node_bandwidth_limit=$request->getParam('node_bandwidth_limit')*1024*1024*1024;
		$node->bandwidthlimit_resetday=$request->getParam('bandwidthlimit_resetday');
        
        if(!$node->save()){
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
        $node = Node::find($id);
		if($node->sort==1)
		{
			Radius::DelNas($node->node_ip);
		}
		
        if(!$node->delete()){
            $rs['ret'] = 0;
            $rs['msg'] = "删除失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "删除成功";
        return $response->getBody()->write(json_encode($rs));
    }

}
<?php

namespace App\Controllers\Admin;

use App\Models\DetectLog;
use App\Models\DetectRule;
use App\Utils\Telegram;
use App\Controllers\AdminController;

class DetectController extends AdminController
{
	public function index($request, $response, $args){
		$pageNum = 1;
		if (isset($request->getQueryParams()["page"])) {
			$pageNum = $request->getQueryParams()["page"];
		}
		$logs = DetectRule::paginate(15, ['*'], 'page', $pageNum);
		$logs->setPath('/admin/detect');
		return $this->view()->assign('rules',$logs)->display('admin/detect/index.tpl');
	}

	public function log($request, $response, $args){
		$pageNum = 1;
		if (isset($request->getQueryParams()["page"])) {
			$pageNum = $request->getQueryParams()["page"];
		}
		$logs = DetectLog::orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
		$logs->setPath('/admin/detect/log');
		return $this->view()->assign('logs',$logs)->display('admin/detect/log.tpl');
	}

	public function create($request, $response, $args){
		return $this->view()->display('admin/detect/add.tpl');
	}

	public function add($request, $response, $args){
		$rule = new DetectRule();
		$rule->name =  $request->getParam('name');
		$rule->text =  $request->getParam('text');
		$rule->regex =  $request->getParam('regex');
		$rule->type =  $request->getParam('type');

		if(!$rule->save()){
		    $rs['ret'] = 0;
		    $rs['msg'] = "添加失败";
		    return $response->getBody()->write(json_encode($rs));
		}
	
		Telegram::SendMarkdown("有新的审计规则：".$rule->name);
	
		$rs['ret'] = 1;
		$rs['msg'] = "添加成功";
		return $response->getBody()->write(json_encode($rs));
	}

	public function edit($request, $response, $args){
		$id = $args['id'];
		$rule = DetectRule::find($id);
		return $this->view()->assign('rule',$rule)->display('admin/detect/edit.tpl');
	}

	public function update($request, $response, $args){
		$id = $args['id'];
		$rule = DetectRule::find($id);

		$rule->name =  $request->getParam('name');
		$rule->text =  $request->getParam('text');
		$rule->regex =  $request->getParam('regex');
		$rule->type =  $request->getParam('type');
	
		if(!$rule->save()){
		    $rs['ret'] = 0;
		    $rs['msg'] = "修改失败";
		    return $response->getBody()->write(json_encode($rs));
		}
	
		Telegram::SendMarkdown("规则更新：".PHP_EOL.$request->getParam('name'));
	
		$rs['ret'] = 1;
		$rs['msg'] = "修改成功";
		return $response->getBody()->write(json_encode($rs));
	}


	public function delete($request, $response, $args){
		$id = $request->getParam('id');
		$rule = DetectRule::find($id);
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

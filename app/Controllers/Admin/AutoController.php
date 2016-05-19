<?php

namespace App\Controllers\Admin;

use App\Models\Auto;
use App\Controllers\AdminController;

class autoController extends AdminController
{
    public function index($request, $response, $args){
		$pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $logs = Auto::orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
		$logs->setPath('/admin/auto');
        return $this->view()->assign('logs',$logs)->display('admin/auto/index.tpl');
    }

    public function create($request, $response, $args){
        return $this->view()->display('admin/auto/add.tpl');
    }

    public function add($request, $response, $args){
        $auto = new Auto();
        $auto->datetime =  time();
		$auto->value =  $request->getParam('content');
		$auto->sign =  $request->getParam('sign');
		$auto->type =  1;
        
        if(!$auto->save()){
            $rs['ret'] = 0;
            $rs['msg'] = "添加失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "添加成功";
        return $response->getBody()->write(json_encode($rs));
    }


	public function delete($request, $response, $args){
        $id = $request->getParam('id');
        $auto = Auto::find($id);
        if(!$auto->delete()){
            $rs['ret'] = 0;
            $rs['msg'] = "删除失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "删除成功";
        return $response->getBody()->write(json_encode($rs));
    }

}
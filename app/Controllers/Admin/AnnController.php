<?php

namespace App\Controllers\Admin;

use App\Models\Ann;
use App\Controllers\AdminController;
use App\Utils\Telegram;

class AnnController extends AdminController
{
    public function index($request, $response, $args){
		$pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $logs = Ann::orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
		$logs->setPath('/admin/announcement');
        return $this->view()->assign('logs',$logs)->display('admin/announcement/index.tpl');
    }

    public function create($request, $response, $args){
        return $this->view()->display('admin/announcement/create.tpl');
    }

    public function add($request, $response, $args){
        $ann = new Ann();
        $ann->date =  date("Y-m-d H:i:s");
		$ann->content =  $request->getParam('content');
		$ann->markdown =  $request->getParam('markdown');
        
        if(!$ann->save()){
            $rs['ret'] = 0;
            $rs['msg'] = "添加失败";
            return $response->getBody()->write(json_encode($rs));
        }
		
		Telegram::Send("新公告：".PHP_EOL.$request->getParam('markdown'));
		
        $rs['ret'] = 1;
        $rs['msg'] = "公告添加成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function edit($request, $response, $args){
        $id = $args['id'];
        $ann = Ann::find($id);
        if ($ann == null){

        }
        return $this->view()->assign('ann',$ann)->display('admin/announcement/edit.tpl');
    }

    public function update($request, $response, $args){
        $id = $args['id'];
        $ann = Ann::find($id);

		$ann->content =  $request->getParam('content');
		$ann->markdown =  $request->getParam('markdown');
		$ann->date =  date("Y-m-d H:i:s");
		
        if(!$ann->save()){
            $rs['ret'] = 0;
            $rs['msg'] = "修改失败";
            return $response->getBody()->write(json_encode($rs));
        }
		
		Telegram::Send("公告更新：".PHP_EOL.$request->getParam('markdown'));
		
        $rs['ret'] = 1;
        $rs['msg'] = "修改成功";
        return $response->getBody()->write(json_encode($rs));
    }


    public function delete($request, $response, $args){
        $id = $request->getParam('id');
        $ann = Ann::find($id);
        if(!$ann->delete()){
            $rs['ret'] = 0;
            $rs['msg'] = "删除失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "删除成功";
        return $response->getBody()->write(json_encode($rs));
    }

}
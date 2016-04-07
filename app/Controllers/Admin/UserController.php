<?php

namespace App\Controllers\Admin;

use App\Models\User;
use App\Controllers\AdminController;
use App\Utils\Hash,App\Utils\Radius,App\Utils\Da;

class UserController extends AdminController
{
    public function index($request, $response, $args){
        $pageNum = 1;
        if(isset($request->getQueryParams()["page"])){
            $pageNum = $request->getQueryParams()["page"];
        }
        $users = User::paginate(60,['*'],'page',$pageNum);
        $users->setPath('/admin/user');
        return $this->view()->assign('users',$users)->display('admin/user/index.tpl');
    }

    public function edit($request, $response, $args){
        $id = $args['id'];
        $user = User::find($id);
        if ($user == null){

        }
        return $this->view()->assign('user',$user)->display('admin/user/edit.tpl');
    }

    public function update($request, $response, $args){
        $id = $args['id'];
        $user = User::find($id);

		$email1=$user->email;

		Da::delete($email1);

        $user->email =  $request->getParam('email');

		$email2=$request->getParam('email');

		Da::add($email2);

		$passwd=$request->getParam('passwd');

		Radius::ChangeUserName($email1,$email2,$passwd);


        if ($request->getParam('pass') != '') {
            $user->pass = Hash::passwordHash($request->getParam('pass'));
        }
        $user->port =  $request->getParam('port');
        $user->passwd = $request->getParam('passwd');
        $user->transfer_enable = $request->getParam('transfer_enable');
        $user->invite_num = $request->getParam('invite_num');
        $user->method = $request->getParam('method');
		$user->node_speedlimit = $request->getParam('node_speedlimit');
        $user->enable = $request->getParam('enable');
        $user->is_admin = $request->getParam('is_admin');
        $user->ref_by = $request->getParam('ref_by');
		$user->class = $request->getParam('class');
		$user->class_expire = $request->getParam('class_expire');
		$user->expire_in = $request->getParam('expire_in');
        if(!$user->save()){
            $rs['ret'] = 0;
            $rs['msg'] = "修改失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "修改成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function delete($request, $response, $args){
        $id = $args['id'];
        $user = User::find($id);

		$email1=$user->email;
		
		Radius::Delete($email1);
			
		Da::delete($email1);
			
        if(!$user->delete()){
            $rs['ret'] = 0;
            $rs['msg'] = "删除失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "删除成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function deleteGet($request, $response, $args){
        $id = $args['id'];
        $user = User::find($id);

		$email1=$user->email;
		Radius::Delete($email1);
			
			
		Da::delete($email1);
			
        $user->delete();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/admin/user');
        return $newResponse;
    }
}

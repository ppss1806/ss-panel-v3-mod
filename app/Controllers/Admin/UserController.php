<?php

namespace App\Controllers\Admin;

use App\Models\User,App\Models\Ip,App\Models\RadiusBan;
use App\Controllers\AdminController;
use App\Utils\Hash,App\Utils\Radius,App\Utils\QQWry;
use App\Utils\Wecenter;
use App\Utils\Tools;

class UserController extends AdminController
{
    public function index($request, $response, $args){
        $pageNum = 1;
        if(isset($request->getQueryParams()["page"])){
            $pageNum = $request->getQueryParams()["page"];
        }
        $users = User::paginate(20,['*'],'page',$pageNum);
        $users->setPath('/admin/user');
		
		

		//Ip::where("datetime","<",time()-90)->get()->delete();
		$total = Ip::where("datetime",">=",time()-90)->orderBy('userid', 'desc')->get();
		
		
		$userip=array();
		$useripcount=array();
		$regloc=array();
		
		$iplocation = new QQWry(); 
		foreach($users as $user)
		{
			$useripcount[$user->id]=0;
			$userip[$user->id]=array();
			
			$location=$iplocation->getlocation($user->reg_ip);
			$regloc[$user->id]=iconv('gbk', 'utf-8//IGNORE', $location['country'].$location['area']);
		}
		
		  
		
		foreach($total as $single)
		{
			if(isset($useripcount[$single->userid]))
			{
				if(!isset($userip[$single->userid][$single->ip]))
				{
					$useripcount[$single->userid]=$useripcount[$single->userid]+1;
					$location=$iplocation->getlocation($single->ip());
					$userip[$single->userid][$single->ip]=iconv('gbk', 'utf-8//IGNORE', $location['country'].$location['area']);
				}
			}
		}

		
        return $this->view()->assign('users',$users)->assign("regloc",$regloc)->assign("useripcount",$useripcount)->assign("userip",$userip)->display('admin/user/index.tpl');
    }
	
	public function search($request, $response, $args){
        $pageNum = 1;
		$text=$args["text"];
        if(isset($request->getQueryParams()["page"])){
            $pageNum = $request->getQueryParams()["page"];
        }
		
		$users = User::where("email","LIKE","%".$text."%")->orWhere("user_name","LIKE","%".$text."%")->orWhere("im_value","LIKE","%".$text."%")->paginate(20,['*'],'page',$pageNum);
        $users->setPath('/admin/user/search/'.$text);
		
		

		//Ip::where("datetime","<",time()-90)->get()->delete();
		$total = Ip::where("datetime",">=",time()-90)->orderBy('userid', 'desc')->get();
		
		
		$userip=array();
		$useripcount=array();
		$regloc=array();
		
		$iplocation = new QQWry(); 
		foreach($users as $user)
		{
			$useripcount[$user->id]=0;
			$userip[$user->id]=array();
			
			$location=$iplocation->getlocation($user->reg_ip);
			$regloc[$user->id]=iconv('gbk', 'utf-8//IGNORE', $location['country'].$location['area']);
		}
		
		  
		
		foreach($total as $single)
		{
			if(isset($useripcount[$single->userid]))
			{
				if(!isset($userip[$single->userid][$single->ip]))
				{
					$useripcount[$single->userid]=$useripcount[$single->userid]+1;
					$location=$iplocation->getlocation($single->ip);
					$userip[$single->userid][$single->ip]=iconv('gbk', 'utf-8//IGNORE', $location['country'].$location['area']);
				}
			}
		}

		
        return $this->view()->assign('users',$users)->assign("regloc",$regloc)->assign("useripcount",$useripcount)->assign("userip",$userip)->display('admin/user/index.tpl');
    }
	
	public function sort($request, $response, $args){
        $pageNum = 1;
		$text=$args["text"];
		$asc=$args["asc"];
        if(isset($request->getQueryParams()["page"])){
            $pageNum = $request->getQueryParams()["page"];
        }
		
		
        $users->setPath('/admin/user/sort/'.$text."/".$asc);
		
		

		//Ip::where("datetime","<",time()-90)->get()->delete();
		$total = Ip::where("datetime",">=",time()-90)->orderBy('userid', 'desc')->get();
		
		
		$userip=array();
		$useripcount=array();
		$regloc=array();
		
		$iplocation = new QQWry(); 
		foreach($users as $user)
		{
			$useripcount[$user->id]=0;
			$userip[$user->id]=array();
			
			$location=$iplocation->getlocation($user->reg_ip);
			$regloc[$user->id]=iconv('gbk', 'utf-8//IGNORE', $location['country'].$location['area']);
		}
		
		  
		
		foreach($total as $single)
		{
			if(isset($useripcount[$single->userid]))
			{
				if(!isset($userip[$single->userid][$single->ip]))
				{
					$useripcount[$single->userid]=$useripcount[$single->userid]+1;
					$location=$iplocation->getlocation($single->ip);
					$userip[$single->userid][$single->ip]=iconv('gbk', 'utf-8//IGNORE', $location['country'].$location['area']);
				}
			}
		}

		
        return $this->view()->assign('users',$users)->assign("regloc",$regloc)->assign("useripcount",$useripcount)->assign("userip",$userip)->display('admin/user/index.tpl');
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

        $user->email =  $request->getParam('email');

		$email2=$request->getParam('email');

		$passwd=$request->getParam('passwd');

		Radius::ChangeUserName($email1,$email2,$passwd);
		

        if ($request->getParam('pass') != '') {
            $user->pass = Hash::passwordHash($request->getParam('pass'));
			Wecenter::ChangeUserName($email1,$email2,$request->getParam('pass'),$user->user_name);
        }
		
		$user->auto_reset_day =  $request->getParam('auto_reset_day');
        $user->auto_reset_bandwidth = $request->getParam('auto_reset_bandwidth');
        $user->port =  $request->getParam('port');
        $user->passwd = $request->getParam('passwd');
        $user->protocol = $request->getParam('protocol');
        $user->protocol_param = $request->getParam('protocol_param');
        $user->obfs = $request->getParam('obfs');
        $user->obfs_param = $request->getParam('obfs_param');
        $user->transfer_enable = Tools::toGB($request->getParam('transfer_enable'));
        $user->invite_num = $request->getParam('invite_num');
        $user->method = $request->getParam('method');
		$user->node_speedlimit = $request->getParam('node_speedlimit');
		$user->node_connector = $request->getParam('node_connector');
        $user->enable = $request->getParam('enable');
        $user->is_admin = $request->getParam('is_admin');
		$user->node_group = $request->getParam('group');
        $user->ref_by = $request->getParam('ref_by');
		$user->remark = $request->getParam('remark');
		$user->class = $request->getParam('class');
		$user->class_expire = $request->getParam('class_expire');
		$user->expire_in = $request->getParam('expire_in');
		
		$user->forbidden_ip = str_replace(PHP_EOL, ",", $request->getParam('forbidden_ip'));
		$user->forbidden_port = str_replace(PHP_EOL, ",", $request->getParam('forbidden_port'));
		
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
        $id = $request->getParam('id');
        $user = User::find($id);

		$email1=$user->email;
		
		Radius::Delete($email1);
		
		RadiusBan::where('userid','=',$user->id)->delete();
		
		Wecenter::Delete($email1);
			
			
        if(!$user->delete()){
            $rs['ret'] = 0;
            $rs['msg'] = "删除失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "删除成功";
        return $response->getBody()->write(json_encode($rs));
    }
	
	
}

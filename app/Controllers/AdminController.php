<?php

namespace App\Controllers;

use App\Models\InviteCode, App\Models\Node, App\Models\TrafficLog, App\Models\Payback, App\Models\Coupon, App\Models\User;
use App\Utils\Tools;
use App\Services\Analytics;

/**
 *  Admin Controller
 */
class AdminController extends UserController
{

    public function index($request, $response, $args)
    {
        $sts = new Analytics();
        return $this->view()->assign('sts', $sts)->display('admin/index.tpl');
    }

    public function node($request, $response, $args)
    {
        $nodes = Node::all();
        return $this->view()->assign('nodes', $nodes)->display('admin/node.tpl');
    }

    public function sys()
    {
        return $this->view()->display('admin/index.tpl');
    }

    public function invite($request, $response, $args)
    {
		
		$pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
		$paybacks = Payback::orderBy("datetime","desc")->paginate(15, ['*'], 'page', $pageNum);
		$paybacks->setPath('/admin/invite');
		
        return $this->view()->assign("paybacks",$paybacks)->display('admin/invite.tpl');
    }

    public function addInvite($request, $response, $args)
    {
        $n = $request->getParam('num');
        $prefix = $request->getParam('prefix');
		
		if($request->getParam('uid')!="0")
		{
			if(strpos($request->getParam('uid'),"@")!=FALSE)
			{
				$user=User::where("email","=",$request->getParam('uid'))->first();
			}
			else
			{
				$user=User::Where("id","=",$request->getParam('uid'))->first();
			}
			
			if($user==null)
			{
				$res['ret'] = 0;
				$res['msg'] = "输入不正确";
				return $response->getBody()->write(json_encode($res));
			}
			$uid = $user->id;
        }
		else
		{
			$uid=0;
		}
		
        if ($n < 1) {
            $res['ret'] = 0;
            return $response->getBody()->write(json_encode($res));
        }
        for ($i = 0; $i < $n; $i++) {
            $char = Tools::genRandomChar(32);
            $code = new InviteCode();
            $code->code = $prefix . $char;
            $code->user_id = $uid;
            $code->save();
        }
        $res['ret'] = 1;
        $res['msg'] = "邀请码添加成功";
        return $response->getBody()->write(json_encode($res));
    }
	
	
	public function coupon($request, $response, $args)
    {
		
		$pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
		$coupons = Coupon::orderBy("expire","desc")->paginate(15, ['*'], 'page', $pageNum);
		$coupons->setPath('/admin/coupon');
		
        return $this->view()->assign("coupons",$coupons)->display('admin/coupon.tpl');
    }

    public function addCoupon($request, $response, $args)
    {
        
		$code = new Coupon();
		$code->onetime=$request->getParam('onetime');
		
		$code->code=$request->getParam('prefix').Tools::genRandomChar(8);
		$code->expire=time()+$request->getParam('expire')*3600;
		$code->shop=$request->getParam('shop');
		$code->credit=$request->getParam('credit');
		
		$code->save();
		
        $res['ret'] = 1;
        $res['msg'] = "优惠码添加成功";
        return $response->getBody()->write(json_encode($res));
    }

    public function trafficLog($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $traffic = TrafficLog::orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
        $traffic->setPath('/admin/trafficlog');
        return $this->view()->assign('logs', $traffic)->display('admin/trafficlog.tpl');
    }

}
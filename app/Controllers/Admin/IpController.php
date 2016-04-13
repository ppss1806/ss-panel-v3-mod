<?php

namespace App\Controllers\Admin;

use App\Models\Ip;
use App\Models\LoginIp;
use App\Controllers\AdminController;
use App\Utils\QQWry;

class IpController extends AdminController
{
    public function index($request, $response, $args){
		$pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $logs = Ip::orderBy('id', 'desc')->where("datetime",">",time()-60)->paginate(15, ['*'], 'page', $pageNum);
		$loc=array();
		
		$iplocation = new QQWry(); 
		foreach($logs as $log)
		{
			if(!isset($loc[$log->ip]))
			{
				$location=$iplocation->getlocation($log->ip);
				$loc[$log->ip]=iconv('gbk', 'utf-8//IGNORE', $location['country'].$location['area']);
			}
		}
		
		
		$logs->setPath('/admin/alive');
        return $this->view()->assign("loc",$loc)->assign('logs',$logs)->display('admin/ip/alive.tpl');
    }
	
    public function index1($request, $response, $args){
		$pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $logs = LoginIp::orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
		$loc=array();
		
		$iplocation = new QQWry(); 
		foreach($logs as $log)
		{
			if(!isset($loc[$log->ip]))
			{
				$location=$iplocation->getlocation($log->ip);
				$loc[$log->ip]=iconv('gbk', 'utf-8//IGNORE', $location['country'].$location['area']);
			}
		}
		
		
		$logs->setPath('/admin/alive');
        return $this->view()->assign("loc",$loc)->assign('logs',$logs)->display('admin/ip/login.tpl');
    }

}
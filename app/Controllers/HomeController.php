<?php

namespace App\Controllers;

use App\Models\InviteCode;
use App\Models\User;
use App\Services\Auth;
use App\Services\Config;
use App\Utils\Tools;

/**
 *  HomeController
 */
class HomeController extends BaseController
{

    public function index()
    {
        return $this->view()->display('index.tpl');
    }

    public function code()
    {
        $codes = InviteCode::where('user_id', '=', '0')->take(10)->get();
        return $this->view()->assign('codes', $codes)->display('code.tpl');
    }

    public function down()
    {

    }

    public function tos()
    {
        return $this->view()->display('tos.tpl');
    }
	
	public function staff()
    {
        return $this->view()->display('staff.tpl');
    }
	
	public function page404($request, $response, $args)
    {
		$pics=scandir(BASE_PATH."/public/theme/".(Auth::getUser()->isLogin==false?Config::get("theme"):Auth::getUser()->theme)."/images/error/404/");
		
		if(count($pics)>2)
		{
			$pic=$pics[rand(2,count($pics)-1)];
		}
		else
		{
			$pic="4041.png";
		}
		
		$newResponse = $response->withStatus(404);
		$newResponse->getBody()->write($this->view()->assign("pic","/theme/".(Auth::getUser()->isLogin==false?Config::get("theme"):Auth::getUser()->theme)."/images/error/404/".$pic)->display('404.tpl'));
        return $newResponse;
    }
	
	public function page405($request, $response, $args)
    {
        $pics=scandir(BASE_PATH."/public/theme/".(Auth::getUser()->isLogin==false?Config::get("theme"):Auth::getUser()->theme)."/images/error/405/");
		if(count($pics)>2)
		{
			$pic=$pics[rand(2,count($pics)-1)];
		}
		else
		{
			$pic="4051.png";
		}
		
		$newResponse = $response->withStatus(405);
		$newResponse->getBody()->write($this->view()->assign("pic","/theme/".(Auth::getUser()->isLogin==false?Config::get("theme"):Auth::getUser()->theme)."/images/error/405/".$pic)->display('405.tpl'));
        return $newResponse;
    }
	
	public function page500($request, $response, $args)
    {
        $pics=scandir(BASE_PATH."/public/theme/".(Auth::getUser()->isLogin==false?Config::get("theme"):Auth::getUser()->theme)."/images/error/500/");
		if(count($pics)>2)
		{
			$pic=$pics[rand(2,count($pics)-1)];
		}
		else
		{
			$pic="5001.png";
		}
		
		$newResponse = $response->withStatus(500);
		$newResponse->getBody()->write($this->view()->assign("pic","/theme/".(Auth::getUser()->isLogin==false?Config::get("theme"):Auth::getUser()->theme)."/images/error/500/".$pic)->display('500.tpl'));
        return $newResponse;
    }
	
	

}
<?php

namespace App\Middleware;

use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Message\ResponseInterface;
use App\Services\Auth as AuthService;
use App\Services\Config;

require PUBLIC_PATH.'/../lib/JWT.php';

class Auth{

    public function __invoke(ServerRequestInterface $request,ResponseInterface $response, $next)
    {
        $user = AuthService::getUser();
        if(!$user->isLogin){
            $newResponse = $response->withStatus(302)->withHeader('Location', '/auth/login');
            return $newResponse;
        }
		
		if($user->wechat==""&&$_SERVER["REQUEST_URI"]!="/user/edit"&&$_SERVER["REQUEST_URI"]!="/user/wechat")
		{
			echo("<script language=\"JavaScript\">alert(\"为了便于身份管理，请各位到 修改资料 面板 填好微信号后再继续操作，谢谢。\");window.location.href='/user/edit';</script>");
		}
		
		$token = array(
			"short_name"=>Config::get('duoshuo_shortname'),
			"user_key"=>$user->id,
			"name"=>$user->user_name,
		);
		
		$duoshuoToken = \JWT::encode($token, Config::get('duoshuo_apptoken'));
		
		setcookie('duoshuo_token',  $duoshuoToken);
		
        $response = $next($request, $response);
        return $response;
    }
}
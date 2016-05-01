<?php


namespace App\Middleware;

use App\Services\Config;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Message\ResponseInterface;
use App\Services\Factory;
use App\Utils\Helper;
use App\Models\Node;

class Mu
{
    public function __invoke(ServerRequestInterface $request, ResponseInterface $response, $next)
    {
        $key = Helper::getMuKeyFromReq($request);
        if ($key == null) {
            $res['ret'] = 0;
            $res['msg'] = "key is null";
            $response->getBody()->write(json_encode($res));
            return $response;
        }
		
		$auth=false;
		$keyset=explode(",",Config::get('muKey'));
		foreach($keyset as $sinkey)
		{
			if($key==$sinkey)
			{
				$auth=true;
				break;
			}
		}
		
		$node = Node::where("node_ip","=",$_SERVER["REMOTE_ADDR"])->first();
		if($node==null)
		{
			$res['ret'] = 0;
            $res['msg'] = "source is  invalid";
            $response->getBody()->write(json_encode($res));
            return $response;

		}

		
		
        if ($auth==false) {
            $res['ret'] = 0;
            $res['msg'] = "token is  invalid";
            $response->getBody()->write(json_encode($res));
            return $response;
        }
        $response = $next($request, $response);
        return $response;
    }
}
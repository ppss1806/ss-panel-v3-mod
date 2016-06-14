<?php

namespace App\Controllers;

use App\Models\InviteCode;
use App\Models\User;
use App\Models\Code;
use App\Models\Payback;
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
	
	public function pmw_pingback($request, $response, $args)
    {
        require_once(BASE_PATH.'/vendor/paymentwall/paymentwall-php/lib/paymentwall.php');
		
		if(Config::get('pmw_publickey')!="")
		{
			\Paymentwall_Config::getInstance()->set(array(
				'api_type' => \Paymentwall_Config::API_VC,
				'public_key' => Config::get('pmw_publickey'),
				'private_key' => Config::get('pmw_privatekey')
			));
			
			
			
			$pingback = new \Paymentwall_Pingback($_GET, $_SERVER['REMOTE_ADDR']);
			if ($pingback->validate()) {
				$virtualCurrency = $pingback->getVirtualCurrencyAmount();
				if ($pingback->isDeliverable()) {
				// deliver the virtual currency
				} else if ($pingback->isCancelable()) {
				// withdraw the virual currency
				} 
				
				$user=User::find($pingback->getUserId());
				$user->money=$user->money+$pingback->getVirtualCurrencyAmount();
				$user->save();
				
				$codeq=new Code();
				$codeq->code="Payment Wall 充值";
				$codeq->isused=1;
				$codeq->type=-1;
				$codeq->number=$pingback->getVirtualCurrencyAmount();
				$codeq->usedatetime=date("Y-m-d H:i:s");
				$codeq->userid=$user->id;
				$codeq->save();
			  
			  
				
				
				if($user->ref_by!=""&&$user->ref_by!=0&&$user->ref_by!=NULL)
				{
					$gift_user=User::where("id","=",$user->ref_by)->first();
					$gift_user->money=($gift_user->money+($codeq->number*(Config::get('code_payback')/100)));
					$gift_user->save();
					
					$Payback=new Payback();
					$Payback->total=$pingback->getVirtualCurrencyAmount();
					$Payback->userid=$user->id;
					$Payback->ref_by=$user->ref_by;
					$Payback->ref_get=$codeq->number*(Config::get('code_payback')/100);
					$Payback->datetime=time();
					$Payback->save();
					
				}
			  
			  
			  
				echo 'OK'; // Paymentwall expects response to be OK, otherwise the pingback will be resent
			} else {
				echo $pingback->getErrorSummary();
			}
		}
		else
		{
			echo 'error';
		}
    }
	
	

}
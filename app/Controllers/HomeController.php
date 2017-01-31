<?php

namespace App\Controllers;

use App\Models\InviteCode;
use App\Models\User;
use App\Models\Code;
use App\Models\Payback;
use App\Models\Paylist;
use App\Services\Auth;
use App\Services\Config;
use App\Utils\Tools;
use App\Utils\Telegram;
use App\Utils\Tuling;
use App\Utils\TelegramSessionManager;
use App\Utils\QRcode;
use App\Utils\Pay;

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
	
	
	public static function telegram_process($bot, $message, $command)
	{
		
		if($message->getChat()->getId() > 0)
		{
			//个人
			
			$user = User::where('telegram_id', $message->getFrom()->getId())->first();
			
			switch($command)
			{
				case 'ping':
					$bot->sendMessage($message->getChat()->getId(), 'Pong!这个群组的 ID 是 '.$message->getChat()->getId().'!');
					break;
				case 'chat':
					$bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), substr($message->getText(),5)));
					break;
				default:
					if($message->getPhoto() != NULL)
					{
						$bot->sendMessage($message->getChat()->getId(), "正在解码，请稍候。。。");
						$photos = $message->getPhoto();
						
						$photo_size_array = array();
						$photo_id_array = array();
						
						
						foreach($photos as $photo)
						{
							$file = $bot->getFile($photo->getFileId());
							$real_id = substr($file->getFileId(), 0, 36);
							if(!isset($photo_size_array[$real_id]))
							{
								$photo_size_array[$real_id] = 0;
							}
							
							if($photo_size_array[$real_id] < $file->getFileSize())
							{
								$photo_size_array[$real_id] = $file->getFileSize();
								$photo_id_array[$real_id] = $file->getFileId();
							}
						}
						
						foreach($photo_id_array as $key => $value)
						{
							$file = $bot->getFile($value);
							$qrcode_text = QRcode::decode("https://api.telegram.org/file/bot".Config::get('telegram_token')."/".$file->getFilePath());
							if(substr($qrcode_text, 0, 11) == 'mod://bind/')
							{
								$uid = TelegramSessionManager::verify_bind_session(substr($qrcode_text, 11));
								if($uid != 0)
								{
									$user = User::where('id', $uid)->first();
									$user->telegram_id = $message->getFrom()->getId();
									$user->im_type = 3;
									$user->im_type = $message->getFrom()->getUsername();
									$user->save();
									$bot->sendMessage($message->getChat()->getId(), "绑定成功。邮箱：".$user->email);
								}
								else
								{
									$bot->sendMessage($message->getChat()->getId(), "绑定失败，二维码无效。".substr($qrcode_text, 11));
								}
								
							}
							
							if(substr($qrcode_text, 0, 12) == 'mod://login/')
							{
								if($user != NULL)
								{
									$uid = TelegramSessionManager::verify_login_session(substr($qrcode_text, 12), $user->id);
									if($uid != 0)
									{
										$bot->sendMessage($message->getChat()->getId(), "登录验证成功。邮箱：".$user->email);
									}
									else
									{
										$bot->sendMessage($message->getChat()->getId(), "登录验证失败，二维码无效。".substr($qrcode_text, 12));
									}
								}
								else
								{
									$bot->sendMessage($message->getChat()->getId(), "登录验证失败，您未绑定本站账号。".substr($qrcode_text, 12));
								}
								
							}
						}
					}
					else
					{
						$bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), $message->getText()));
					}
			}
		}
		else
		{
			//群组
			switch($command)
			{
				case 'ping':
					$bot->sendMessage($message->getChat()->getId(), 'Pong!这个群组的 ID 是 '.$message->getChat()->getId().'!', $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
					break;
				case 'chat':
					if($message->getChat()->getId() == Config::get('telegram_chatid'))
					{
						$bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), substr($message->getText(),5)), $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
					}
					else
					{
						$bot->sendMessage($message->getChat()->getId(), '不约，叔叔我们不约。', $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
					}
					break;
				default:
					if($message->getChat()->getId() == Config::get('telegram_chatid'))
					{
						$bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), $message->getText()), $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
					}
					else
					{
						$bot->sendMessage($message->getChat()->getId(), '不约，叔叔我们不约。', $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
					}
			}
		}
	}
	
	public function telegram()
	{
		try {
			$bot = new \TelegramBot\Api\Client(Config::get('telegram_token'));
			// or initialize with botan.io tracker api key
			// $bot = new \TelegramBot\Api\Client('YOUR_BOT_API_TOKEN', 'YOUR_BOTAN_TRACKER_API_KEY');

			$bot->command('ping', function ($message) use ($bot) {
				HomeController::telegram_process($bot, $message, 'ping');
			});
			
			$bot->command('chat', function ($message) use ($bot) {
				HomeController::telegram_process($bot, $message, 'chat');
			});
			
			$bot->on($bot->getEvent(function ($message) use ($bot) {
				HomeController::telegram_process($bot, $message, '');
			}), function () {
				return true;
			});
			
			$bot->run();
			
		} catch (\TelegramBot\Api\Exception $e) {
			$e->getMessage();
		}
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
	
	public function pay_callback($request, $response, $args)
	{
		Pay::callback($request);
	}
}

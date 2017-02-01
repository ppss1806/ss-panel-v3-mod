<?php

namespace App\Utils;

use App\Models\User;
use App\Services\Config;

Class TelegramProcess
{
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
									$user->im_type = 4;
									$user->im_value = $message->getFrom()->getUsername();
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
	
	public static function process() 
	{
		try {
			$bot = new \TelegramBot\Api\Client(Config::get('telegram_token'));
			// or initialize with botan.io tracker api key
			// $bot = new \TelegramBot\Api\Client('YOUR_BOT_API_TOKEN', 'YOUR_BOTAN_TRACKER_API_KEY');

			$bot->command('ping', function ($message) use ($bot) {
				TelegramProcess::telegram_process($bot, $message, 'ping');
			});
			
			$bot->command('chat', function ($message) use ($bot) {
				TelegramProcess::telegram_process($bot, $message, 'chat');
			});
			
			$bot->on($bot->getEvent(function ($message) use ($bot) {
				TelegramProcess::telegram_process($bot, $message, '');
			}), function () {
				return true;
			});
			
			$bot->run();
			
		} catch (\TelegramBot\Api\Exception $e) {
			$e->getMessage();
		}
	}
}

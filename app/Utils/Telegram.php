<?php

namespace App\Utils;

use App\Services\Config;


Class Telegram
{

    /**
     * ·¢ËÍÏûÏ¢
     */
    static function Send($messageText)
    {
		if(Config::get('enable_telegram') == 'true')
		{
			$bot = new \TelegramBot\Api\BotApi(Config::get('telegram_token'));

			$bot->sendMessage(Config::get('telegram_chatid'), $messageText);
		}
    }
	
	
	static function SendMarkdown($messageText)
    {
		if(Config::get('enable_telegram') == 'true')
		{
			$bot = new \TelegramBot\Api\BotApi(Config::get('telegram_token'));

			$bot->sendMessage(Config::get('telegram_chatid'), $messageText, "Markdown");
		}
    }
    
}
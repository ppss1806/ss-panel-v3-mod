<?php


namespace App\Command;

use App\Models\User;
use App\Models\Ann;
use App\Services\Config;
use App\Services\Mail;

class DailyMail
{

    public static function sendDailyMail()
    {
        $users = User::all();
		$logs = Ann::orderBy('id', 'desc')->get();
		$text1="";
		
		foreach($logs as $log){
			$text1=$text1.$log->content."\n\n";
		}
		
        foreach($users as $user){
			if($user->sendDailyMail==1)
			{
				echo "Send daily mail to user: ".$user->id;
				$subject = Config::get('appName')."-每日流量报告以及公告";
				$to = $user->email;
				$lastday=(($user->u+$user->d)-$user->last_day_t)/1024/1024;
				$text = "Hi，接下来系统为您报告一下您目前的流量使用情况~\n\n总流量:". $user->enableTraffic()."  \n\n已用流量: ". $user->usedTraffic()." \n\n剩余流量:". $user->unusedTraffic()."\n\n在过去的一天里您消耗的流量：".$lastday." MB\n\n以及下面是系统中目前的公告:\n\n".$text1."\n\n晚安！";
				$user->last_day_t=($user->u+$user->d);
				$user->save();
				try{
					Mail::send($to,$subject,$text);
				}catch(\Exception $e){
					echo $e->getMessage();
				}
				$text="";
			}
        }
    }


	public static function reall()
    {
        $users = User::all();
        foreach($users as $user){

			$user->last_day_t=($user->u+$user->d);
            $user->save();

        }
    }






}
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
			if(strpos($log->content,"Links")===FALSE)
			{
				$text1=$text1.$log->content."<br><br>";
			}
		}
		
        foreach($users as $user){
			if($user->sendDailyMail==1)
			{
				echo "Send daily mail to user: ".$user->id;
				$subject = Config::get('appName')."-每日流量报告以及公告";
				$to = $user->email;
				$lastday=(($user->u+$user->d)-$user->last_day_t)/1024/1024;
				$text = "下面是系统中目前的公告:<br><br>".$text1."<br><br>晚安！";
				
				
				try {
					Mail::send($to, $subject, 'news/daily-traffic-report.tpl', [
						"user" => $user,"text" => $text,"lastday"=>$lastday
					], [
					]);
				} catch (Exception $e) {
					echo $e->getMessage();
				}
				$text="";
			}
			else
			{
				$lastday=(($user->u+$user->d)-$user->last_day_t)/1024/1024;
				$user->last_day_t=($user->u+$user->d);
				$user->save();
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
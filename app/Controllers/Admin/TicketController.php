<?php

namespace App\Controllers\Admin;

use App\Models\Ticket;
use App\Models\User;

use voku\helper\AntiXSS;
use App\Services\Auth;

use App\Services\Mail;
use App\Services\Config;

use App\Controllers\AdminController;

class TicketController extends AdminController
{
    public function index($request, $response, $args){
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
		$tickets = Ticket::where("rootid",0)->orderBy("datetime","desc")->paginate(15, ['*'], 'page', $pageNum);
		$tickets->setPath('/admin/ticket');
		
        return $this->view()->assign('tickets',$tickets)->display('admin/ticket/index.tpl');
    }

	
	
	public function update($request, $response, $args){
        $id = $args['id'];
		$content = $request->getParam('content');
		$status = $request->getParam('status');
		
		
		if($content==""||$status=="")
		{
			$res['ret'] = 0;
			$res['msg'] = "请填全";
			return $this->echoJson($response, $res);
		}
		
		if(strpos($content,"admin")!=FALSE||strpos($content,"user")!=FALSE)
		{
			$res['ret'] = 0;
			$res['msg'] = "请求中有不正当的词语。";
			return $this->echoJson($response, $res);
		}
		
        
        $ticket_main=Ticket::where("id","=",$id)->where("rootid","=",0)->first();
		
		//if($status==1&&$ticket_main->status!=$status)
		{
			$adminUser = User::where("id","=",$ticket_main->userid)->get();
			foreach($adminUser as $user)
			{
				$subject = Config::get('appName')."-工单被回复";
				$to = $user->email;
				$text = "您好，有人回复了<a href=\"".Config::get('baseUrl')."/user/ticket/".$ticket_main->id."/view\">工单</a>，请您查看。" ;
				try {
					Mail::send($to, $subject, 'news/warn.tpl', [
						"user" => $user,"text" => $text
					], [
					]);
				} catch (Exception $e) {
					echo $e->getMessage();
				}
			}
		}
		
		$antiXss = new AntiXSS();
		
		$ticket=new Ticket();
		$ticket->title=$antiXss->xss_clean($ticket_main->title);
		$ticket->content=$antiXss->xss_clean($content);
		$ticket->rootid=$ticket_main->id;
		$ticket->userid=Auth::getUser()->id;
		$ticket->datetime=time();
		$ticket_main->status=$status;
		
		$ticket_main->save();
		$ticket->save();

        $res['ret'] = 1;
        $res['msg'] = "提交成功";
        return $this->echoJson($response, $res);
    }
	
	public function show($request, $response, $args){
		$id = $args['id'];
		
		$pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
		
		
		$ticketset=Ticket::where("id",$id)->orWhere("rootid","=",$id)->orderBy("datetime","desc")->paginate(5, ['*'], 'page', $pageNum);
		$ticketset->setPath('/admin/ticket/'.$id."/view");
		
		return $this->view()->assign('ticketset',$ticketset)->assign("id",$id)->display('admin/ticket/view.tpl');
    }
	
}
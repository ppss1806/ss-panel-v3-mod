<?php

namespace App\Utils;

use App\Models\User;
use App\Models\Code;
use App\Models\Paylist;
use App\Models\Payback;
use App\Services\Config;

class Pay
{
    public static function getHTML($user)
    {
        $driver = Config::get("payment_system");
        switch ($driver) {
            case "paymentwall":
                return Pay::pmw_html($user);
            case 'spay':
                return Pay::spay_html($user);
            case 'zfbjk':
                return Pay::zfbjk_html($user);
            default:
                return "";
        }
        return null;
    }


    private static function spay_html($user)
    {
        return '
						<form action="/user/alipay" method="get" target="_blank" >
							<h3>支付宝充值</h3>
							<p>充值金额: <input type="text" name="amount" /></p>
							<input type="submit" value="提交" />
						</form>
';
    }

    private static function zfbjk_html($user)
    {
        return '
						<p>请扫码，给我转账来充值，记得备注上 <code>'.$user->id.'</code>。<br></p>
						<img src="'.Config::get('zfbjk_qrcodeurl').'"/>
';
    }

    private static function pmw_html($user)
    {
        \Paymentwall_Config::getInstance()->set(array(
            'api_type' => \Paymentwall_Config::API_VC,
            'public_key' => Config::get('pmw_publickey'),
            'private_key' => Config::get('pmw_privatekey')
        ));

        $widget = new \Paymentwall_Widget(
            $user->id, // id of the end-user who's making the payment
            Config::get('pmw_widget'),      // widget code, e.g. p1; can be picked inside of your merchant account
            array(),     // array of products - leave blank for Virtual Currency API
            array(
                'email' => $user->email,
                'history'=>
                    array(
                    'registration_date'=>strtotime($user->reg_date),
                    'registration_ip'=>$user->reg_ip,
                    'payments_number'=>Code::where('userid', '=', $user->id)->where('type', '=', -1)->count(),
                    'membership'=>$user->class),
                    'customer'=>array(
                        'username'=>$user->user_name
                    )
            ) // additional parameters
        );

        return $widget->getHtmlCode(array("height"=>Config::get('pmw_height'),"width"=>"100%"));
    }

    private static function spay_gen($user, $amount)
    {

        /**************************请求参数**************************/

        $alipay_config = Spay_tool::getConfig();

        $pl = new Paylist();
        $pl->userid = $user->id;
        $pl->total = $amount;
        $pl->save();

        //商户订单号，商户网站订单系统中唯一订单号，必填
        $out_trade_no = $pl->id;

        //订单名称，必填
        $subject = $pl->id."UID".$user->id." 充值".$amount."元";

        //付款金额，必填
        $total_fee = (float)$amount;

        //商品描述，可空
        $body = $user->id;
        /************************************************************/

        //构造要请求的参数数组，无需改动
        $parameter = array(
        "service" => "create_direct_pay_by_user",
        "partner" => trim($alipay_config['partner']),
        "notify_url"    => $alipay_config['notify_url'],
        "return_url"    => $alipay_config['return_url'],
        "out_trade_no"    => $out_trade_no,
        "total_fee"    => $total_fee
        );

        //建立请求
        $alipaySubmit = new Spay_submit($alipay_config);
        $html_text = $alipaySubmit->buildRequestForm($parameter, "get", "确认");
        echo $html_text;
        exit(0);
    }


    public static function getGen($user, $amount)
    {
        $driver = Config::get("payment_system");
        switch ($driver) {
            case "paymentwall":
                return Pay::pmw_html();
            case 'spay':
                return Pay::spay_gen($user, $amount);
            case 'zfbjk':
                return Pay::alipay_html();
            default:
                return "";
        }
        return null;
    }

    private static function spay_callback()
    {
        //计算得出通知验证结果
        $alipayNotify = new Spay_notify(Spay_tool::getConfig());
        $verify_result = $alipayNotify->verifyNotify();

        if ($verify_result) {//验证成功
              /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              //请在这里加上商户的业务逻辑程序代


              //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——

              //获取支付宝的通知返回参数，可参考技术文档中服务器异步通知参数列表

              //商户订单号

              $out_trade_no = $_POST['out_trade_no'];

              //支付宝交易号

              $trade_no = $_POST['trade_no'];

              //交易状态
              $trade_status = $_POST['trade_status'];

              $trade = Paylist::where("id", '=', $out_trade_no)->where('status', 0)->where('total', $_POST['total_fee'])->first();

              if ($trade == null) {
                  exit("success");
              }

              $trade->tradeno = $trade_no;
              $trade->status = 1;
              $trade->save();

              //status
              $trade_status = $_POST['trade_status'];


            if ($_POST['trade_status'] == 'TRADE_FINISHED') {
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
                //如果有做过处理，不执行商户的业务程序

                //注意：
                //退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知

                //调试用，写文本函数记录程序运行情况是否正常
                //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");



                $user=User::find($trade->userid);
                $user->money=$user->money+$_POST['total_fee'];
                $user->save();

                $codeq=new Code();
                $codeq->code="支付宝 充值";
                $codeq->isused=1;
                $codeq->type=-1;
                $codeq->number=$_POST['total_fee'];
                $codeq->usedatetime=date("Y-m-d H:i:s");
                $codeq->userid=$user->id;
                $codeq->save();




                if ($user->ref_by!=""&&$user->ref_by!=0&&$user->ref_by!=null) {
                    $gift_user=User::where("id", "=", $user->ref_by)->first();
                    $gift_user->money=($gift_user->money+($codeq->number*(Config::get('code_payback')/100)));
                    $gift_user->save();

                    $Payback=new Payback();
                    $Payback->total=$_POST['total_fee'];
                    $Payback->userid=$user->id;
                    $Payback->ref_by=$user->ref_by;
                    $Payback->ref_get=$codeq->number*(Config::get('code_payback')/100);
                    $Payback->datetime=time();
                    $Payback->save();
                }
            } elseif ($_POST['trade_status'] == 'TRADE_SUCCESS') {
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
                //如果有做过处理，不执行商户的业务程序

                //注意：
                //付款完成后，支付宝系统发送该交易状态通知

                //调试用，写文本函数记录程序运行情况是否正常
                //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");

                $user=User::find($trade->userid);
                $user->money=$user->money+$_POST['total_fee'];
                $user->save();

                $codeq=new Code();
                $codeq->code="支付宝 充值";
                $codeq->isused=1;
                $codeq->type=-1;
                $codeq->number=$_POST['total_fee'];
                $codeq->usedatetime=date("Y-m-d H:i:s");
                $codeq->userid=$user->id;
                $codeq->save();




                if ($user->ref_by!=""&&$user->ref_by!=0&&$user->ref_by!=null) {
                    $gift_user=User::where("id", "=", $user->ref_by)->first();
                    $gift_user->money=($gift_user->money+($codeq->number*(Config::get('code_payback')/100)));
                    $gift_user->save();

                    $Payback=new Payback();
                    $Payback->total=$_POST['total_fee'];
                    $Payback->userid=$user->id;
                    $Payback->ref_by=$user->ref_by;
                    $Payback->ref_get=$codeq->number*(Config::get('code_payback')/100);
                    $Payback->datetime=time();
                    $Payback->save();
                }
            }

              //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

              echo "success";    //请不要修改或删除

              if (Config::get('enable_donate') == 'true') {
                  if ($user->is_hide == 1) {
                      Telegram::Send("姐姐姐姐，一位不愿透露姓名的大老爷给我们捐了 ".$codeq->number." 元呢~");
                  } else {
                      Telegram::Send("姐姐姐姐，".$user->user_name." 大老爷给我们捐了 ".$codeq->number." 元呢~");
                  }
              }

              /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        } else {
            //验证失败
          echo "fail";

          //调试用，写文本函数记录程序运行情况是否正常
          //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");
        }
    }

    private static function pmw_callback()
    {
        if (Config::get('pmw_publickey')!="") {
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
                } elseif ($pingback->isCancelable()) {
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




                if ($user->ref_by!=""&&$user->ref_by!=0&&$user->ref_by!=null) {
                    $gift_user=User::where("id", "=", $user->ref_by)->first();
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


                if (Config::get('enable_donate') == 'true') {
                    if ($user->is_hide == 1) {
                        Telegram::Send("姐姐姐姐，一位不愿透露姓名的大老爷给我们捐了 ".$codeq->number." 元呢~");
                    } else {
                        Telegram::Send("姐姐姐姐，".$user->user_name." 大老爷给我们捐了 ".$codeq->number." 元呢~");
                    }
                }
            } else {
                echo $pingback->getErrorSummary();
            }
        } else {
            echo 'error';
        }
    }

    private static function zfbjk_callback($request)
    {
        //您在www.zfbjk.com的商户ID
        $alidirect_pid = Config::get("zfbjk_pid");
        //您在www.zfbjk.com的商户密钥
        $alidirect_key = Config::get("zfbjk_key");


        $tradeNo = $request->getParam('tradeNo');
        $Money = $request->getParam('Money');
        $title = $request->getParam('title');
        $memo = $request->getParam('memo');
        $alipay_account = $request->getParam('alipay_account');
        $Gateway = $request->getParam('Gateway');
        $Sign = $request->getParam('Sign');
        if (!is_numeric($title)) {
            exit("fail");
        }
        if (strtoupper(md5($alidirect_pid . $alidirect_key . $tradeNo . $Money . $title . $memo)) == strtoupper($Sign)) {
            $trade = Paylist::where("tradeno", '=', $tradeNo)->first();

            if ($trade != null) {
                exit("success");
            } else {
                $user=User::where('id', '=', $title)->first();
                if ($user == null) {
                    exit("IncorrectOrder");
                }
                $pl = new Paylist();
                $pl->userid=$title;
                $pl->tradeno=$tradeNo;
                $pl->total=$Money;
                $pl->datetime=time();
                $pl->status=1;
                $pl->save();
                $user->money=$user->money+$Money;
                $user->save();

                $codeq=new Code();
                $codeq->code="支付宝充值";
                $codeq->isused=1;
                $codeq->type=-1;
                $codeq->number=$Money;
                $codeq->usedatetime=date("Y-m-d H:i:s");
                $codeq->userid=$user->id;
                $codeq->save();




                if ($user->ref_by!=""&&$user->ref_by!=0&&$user->ref_by!=null) {
                    $gift_user=User::where("id", "=", $user->ref_by)->first();
                    $gift_user->money=($gift_user->money+($codeq->number*(Config::get('code_payback')/100)));
                    $gift_user->save();

                    $Payback=new Payback();
                    $Payback->total=$Money;
                    $Payback->userid=$user->id;
                    $Payback->ref_by=$user->ref_by;
                    $Payback->ref_get=$codeq->number*(Config::get('code_payback')/100);
                    $Payback->datetime=time();
                    $Payback->save();
                }

                if (Config::get('enable_donate') == 'true') {
                    if ($user->is_hide == 1) {
                        Telegram::Send("姐姐姐姐，一位不愿透露姓名的大老爷给我们捐了 ".$codeq->number." 元呢~");
                    } else {
                        Telegram::Send("姐姐姐姐，".$user->user_name." 大老爷给我们捐了 ".$codeq->number." 元呢~");
                    }
                }


                exit("Success");
            }
        } else {
            exit('Fail');
        }
    }


    public static function callback($request)
    {
        $driver = Config::get("payment_system");
        switch ($driver) {
            case "paymentwall":
                return Pay::pmw_callback();
            case 'spay':
                return Pay::spay_callback();
            case 'zfbjk':
                return Pay::zfbjk_callback($request);
            default:
                return "";
        }
        return null;
    }
}

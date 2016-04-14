{include file='user/main.tpl'}

<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
			<h1>
				修改资料
			</h1>
		
	
	<pre class="12u 12u$(xsmall)" id="msg-success" style="display: none;">

				<h4>成功!</h4>
				<p id="msg-success-p"></p>
	</pre>
	
	

	<pre class="12u 12u$(xsmall)" id="msg-error" style="display: none;" >
		
			<div style="float:right;"><button type="button" id="error-close" aria-hidden="true">&times;</button></div>
				<h4>出错了!</h4>
				<p id="msg-error-p"></p>
		
	</pre>
	
	<section>
		<legend>网站登录密码修改</legend>
		<div class="12u 12u$(xsmall)">
			<label class="control-label">当前密码</label>
			<input type="password" class="form-control" placeholder="当前密码(必填)" id="oldpwd">
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">新密码</label>
			<input type="password" class="form-control" placeholder="新密码" id="pwd">
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">确认密码</label>
			<input type="password" placeholder="确认密码" class="form-control" id="repwd">
		</div>
		
		<div class="12u 12u$(xsmall)">
			<button type="submit" id="pwd-update" class="special fit">修改</button>
		</div>
	</section>
	
	
	<section>
		<legend>微信号修改</legend>
		<div class="12u 12u$(xsmall)">
			<p>当前微信号：{$user->wechat}</p>


                                
			<input type="text" class="form-control" placeholder="新的微信号，请填写真实的微信号，填写虚假信息可能会导致账号被删除。" id="wechat">
  
		</div>
		
		<div class="12u 12u$(xsmall)">
			<button type="submit" id="wechat-update" class="special fit">修改</button>
		</div>
	</section>
	
	<section>
		<legend>连接密码修改</legend>
		<div class="12u 12u$(xsmall)">
			<p>当前连接密码：{$user->passwd}</p>


                       
			<input type="text" id="sspwd" placeholder="输入新连接密码" class="form-control">
 
		</div>

		<div class="12u 12u$(xsmall)">
			<button type="submit" id="ss-pwd-update" class="special fit">修改</button>
		</div>
	</section>
	
	<section>
		<legend>加密方式修改</legend>
		<div class="12u 12u$(xsmall)">
			<p>当前加密方式：{$user->method}</p>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<div class="select-wrapper">
			<select id="method">
				<option value="rc4-md5">RC4-MD5</option>
				<option value="aes-128-cfb">AES-128-CFB</option>
				<option value="aes-192-cfb">AES-192-CFB</option>
				<option value="aes-256-cfb">AES-256-CFB</option>
				<option value="camellia-128-cfb">CAMELLIA-128-CFB</option>
				<option value="camellia-192-cfb">CAMELLIA-192-CFB</option>
				<option value="camellia-256-cfb">CAMELLIA-256-CFB</option>
				<option value="cast5-cfb">CAST5-CFB</option>
				<option value="des-cdb">DES-CDB</option>
				<option value="idea-cfb">IDEA-CFB</option>
				<option value="rc2-cfb">RC2-CFB</option>
				<option value="seed-cfb">SEED-CFB</option>
				<option value="salsa20">SALSA20</option>
				<option value="chacha20">CHACHA20</option>
				<option value="chacha20-ietf">CHACHA20-IETF</option>
			</select>
			</div>
		</div>
		
		
		<div class="12u 12u$(xsmall)">
			<button type="submit" id="method-update" class="special fit">修改</button>
		</div>
	</section>
	
	
	<section>
		<legend>主题修改</legend>
		<div class="12u 12u$(xsmall)">
			<p>当前主题：{$user->theme}</p>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<div class="select-wrapper">
			<select id="theme">
				{foreach $themes as $theme}
					<option value="{$theme}">{$theme}</option>
				{/foreach}
			</select>
			</div>
		</div>
		
		
		<div class="12u 12u$(xsmall)">
			<button type="submit" id="theme-update" class="special fit">修改</button>
		</div>
	</section>
	
	
	<section>
		<legend>每日邮件接收设置</legend>
		<div class="12u 12u$(xsmall)">
			<p>当前设置：{if $user->sendDailyMail==1} 发送 {else} 不发送 {/if}</p>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<div class="select-wrapper">
			<select id="mail">
				<option value="1">发送</option>
				<option value="0">不发送</option>
			</select>
			</div>
		</div>
		
		
		<div class="12u 12u$(xsmall)">
			<button type="submit" id="mail-update" class="special fit">修改</button>
		</div>
	</section>
	
	
	
	<section>
		<legend>两步验证</legend>
		<div class="12u 12u$(xsmall)">
			<p>请下载 Google 的两步验证器，扫描下面的二维码。</p>
			<p><i class="fa fa-android" aria-hidden="true"></i><a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2">Android</a></p>
			<p><i class="fa fa-apple" aria-hidden="true"></i><a href="https://itunes.apple.com/cn/app/google-authenticator/id388497605?mt=8">iOS</a></p>
			<p>当前设置：{if $user->ga_enable==1} 登陆时要求验证 {else} 不验证 {/if}</p>
			<p>当前服务器时间：{date("Y-m-d H:i:s")}</p>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<div class="select-wrapper">
			<select id="ga-enable">
				<option value="1">要求验证</option>
				<option value="0">不要求</option>
			</select>
			</div>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<div class="text-center">
				<div id="ga-qr"></div>
			</div>
		</div>
		
		<h3>测试一下</h3>

		<div class="12u 12u$(xsmall)">
			<input type="text" id="code" placeholder="输入验证器生成的数字来测试">
		</div>
		
		<div class="12u 12u$(xsmall)">
			<a class="special fit" href="/user/gareset">重置二维码</a></button><button type="submit" id="ga-test" class="special fit">测试</button><button type="submit" id="ga-set" class="special fit">设置</button>
		</div>
	</section>
	
	
	</div>
</div>



<script>
    $("#msg-success").hide();
    $("#msg-error").hide();
    $("#ss-msg-success").hide();
</script>



<script>
    $(document).ready(function () {
        $("#ga-test").click(function () {
            $.ajax({
                type: "POST",
                url: "gacheck",
                dataType: "json",
                data: {
                    code: $("#code").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide();
                        $("#msg-success").show();
                        $("#msg-success-p").html(data.msg);
                    } else {
                        $("#msg-error").show();
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>

<script src=" /assets/public/js/jquery.qrcode.min.js "></script>
<script>
	var ga_qrcode = '{$user->getGAurl()}';
	jQuery('#ga-qr').qrcode({
		"text": ga_qrcode
	});
</script>


<script>
    $(document).ready(function () {
        $("#ga-set").click(function () {
            $.ajax({
                type: "POST",
                url: "gaset",
                dataType: "json",
                data: {
                    enable: $("#ga-enable").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide();
                        $("#msg-success").show();
                        $("#msg-success-p").html(data.msg);
                    } else {
                        $("#msg-error").show();
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "password",
                dataType: "json",
                data: {
                    oldpwd: $("#oldpwd").val(),
                    pwd: $("#pwd").val(),
                    repwd: $("#repwd").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide();
                        $("#msg-success").show();
                        $("#msg-success-p").html(data.msg);
                    } else {
                        $("#msg-error").show();
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#wechat-update").click(function () {
            $.ajax({
                type: "POST",
                url: "wechat",
                dataType: "json",
                data: {
                    wechat: $("#wechat").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide();
                        $("#msg-success").show();
                        $("#msg-success-w").html(data.msg);
                    } else {
                        $("#msg-error").show();
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#ss-pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "sspwd",
                dataType: "json",
                data: {
                    sspwd: $("#sspwd").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-success").show();
                        $("#msg-success-p").html(data.msg);
                    } else {
                        $("#msg-error").show();
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#mail-update").click(function () {
            $.ajax({
                type: "POST",
                url: "mail",
                dataType: "json",
                data: {
                    mail: $("#mail").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-success").show();
                        $("#msg-success-p").html(data.msg);
                    } else {
                        $("#msg-error").show();
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#theme-update").click(function () {
            $.ajax({
                type: "POST",
                url: "theme",
                dataType: "json",
                data: {
                    theme: $("#theme").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-success").show();
                        $("#msg-success-p").html(data.msg);
                    } else {
                        $("#msg-error").show();
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#method-update").click(function () {
            $.ajax({
                type: "POST",
                url: "method",
                dataType: "json",
                data: {
                    method: $("#method").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-success").show();
                        $("#msg-success-p").html(data.msg);
                    } else {
                        $("#msg-error").show();
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>


{include file='user/footer.tpl'}
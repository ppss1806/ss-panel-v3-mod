{include file='auth/header.tpl'}
<body>
<div id="main">
	<div class="inner">

			<div class="row uniform">
				<p>和我签订契约，成为魔法少女吧。</p>

				<div class="12u 12u$(xsmall)">
					<input type="text" id="name" class="form-control" placeholder="昵称"/>
				</div>
				<div class="12u 12u$(xsmall)">
					<input type="text" id="email" class="form-control" placeholder="邮箱"/>
				</div>
				<div class="12u 12u$(xsmall)">
					<input type="password" id="passwd" class="form-control" placeholder="密码"/>
				</div>
				<div class="12u 12u$(xsmall)">
					<input type="password" id="repasswd" class="form-control" placeholder="重复密码"/>
				</div>
				
				<div class="12u 12u$(xsmall)">
					<input type="text" id="wechat" class="form-control" placeholder="微信号"/>
				</div>
				
				<div class="12u 12u$(xsmall)">
					<input type="text" id="code" value="{$code}" class="form-control" placeholder="邀请码"/>
				</div>


				<div class="12u 12u$(xsmall)">
					<p>注册即代表同意<a href="/tos">服务条款</a>，以及保证所录入信息的真实性，如有不实信息会导致账号被删除。</p>
				</div>

				<div class="12u 12u$(xsmall)">
					<button type="submit" id="reg" class="special fit">同意服务条款并提交注册</button>
				</div>

				<pre class="12u 12u$(xsmall)" id="msg-success" style="display: none;">
					
						<div style="float:right;"><button type="button" class="close" id="ok-close" aria-hidden="true" >&times;</button></div>
							<h4>成功!</h4>
							<p id="msg-success-p"></p>
					
				</pre>
				
				<pre class="12u 12u$(xsmall)" id="msg-error" style="display: none;">
					
						<div style="float:right;"><button type="button" class="close" id="error-close" aria-hidden="true">&times;</button></div>
							<h4>出错了!</h4>
							<p id="msg-error-p"></p>
					
				</pre>

				<div class="12u 12u$(xsmall)">
					<a href="/auth/login" class="text-center">已经注册？请登录</a>
				</div>
			</div><!-- /.form-box -->
	</div>
</div>


</body>
</html>



{include file='footer.tpl'}


<script>
    $(document).ready(function(){
        function register(){
            $.ajax({
                type:"POST",
                url:"/auth/register",
                dataType:"json",
                data:{
                    email: $("#email").val(),
                    name: $("#name").val(),
                    passwd: $("#passwd").val(),
                    repasswd: $("#repasswd").val(),
					wechat: $("#wechat").val(),
                    code: $("#code").val(),
                    agree: $("#agree").val()
                },
                success:function(data){
                    if(data.ret == 1){
                        $("#msg-error").hide(10);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/auth/login'", 2000);
                    }else{
                        $("#msg-success").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error:function(jqXHR){
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误："+jqXHR.status);
                }
            });
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                register();
            }
        });
        $("#reg").click(function(){
            register();
        });
        $("#ok-close").click(function(){
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function(){
            $("#msg-error").hide(100);
        });
    })
</script>
</body>
</html>

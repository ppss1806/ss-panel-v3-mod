{include file='auth/header.tpl'}



<div id="main">
	<div class="inner">

			<div class="row uniform">
				<p>重置密码</p>
				
				<div class="12u 12u$(xsmall)">
					<input type="password" id="password" class="form-control" placeholder="在这里输入新密码"/>
				</div>
				

				<div class="12u 12u$(xsmall)">
					<button type="submit" id="reset" class="special fit">确定</button>
				</div>

				<pre class="12u 12u$(xsmall)" id="msg-success" style="display: none;">
					
						<div style="float:right;"><button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button></div>
							<h4>成功!</h4>
							<p id="msg-success-p"></p>
					
				
				
				<pre class="12u 12u$(xsmall)" id="msg-error" style="display: none;">
					
						<div style="float:right;"><button type="button" class="close" id="error-close" aria-hidden="true">&times;</button></div>
							<h4>出错了!</h4>
							<p id="msg-error-p"></p>
					
				</pre>

				<div class="12u 12u$(xsmall)">
					<a href="/password/reset">忘记密码</a><br>
					<a href="/auth/register" class="text-center">注册个帐号</a>
				</div>
			</div>
	</div><!-- /.form-box -->
</div>







{include file='footer.tpl'}




<script>
    $(document).ready(function(){
        function reset(){
            $.ajax({
                type:"POST",
                url:"/password/token/{$token}",
                dataType:"json",
                data:{
                    password: $("#password").val(),
                    repasswd: $("#repasswd").val(),
                },
                success:function(data){
                    if(data.ret){
                        $("#msg-error").hide(100);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/auth/login'", 2000);
                    }else{
                        $("#msg-error").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error:function(jqXHR){
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误："+jqXHR.status);
                    // 在控制台输出错误信息
                    console.log(removeHTMLTag(jqXHR.responseText));
                }
            });
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                reset();
            }
        });
        $("#reset").click(function(){
            reset();
        });
        $("#ok-close").click(function(){
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function(){
            $("#msg-error").hide(100);
        });
    })
</script>


{include file='auth/header.tpl'}
<body>


<div id="main">
	<div class="inner">

			<div class="row uniform">
				<p>重置密码</p>
				
				<div class="12u 12u$(xsmall)">
					<input type="text" id="email" class="form-control" placeholder="邮箱"/>
				</div>
				

				<div class="12u 12u$(xsmall)">
					<button type="submit" id="reset" class="special fit">发送重置请求</button>
				</div>

				<pre class="12u 12u$(xsmall)" id="msg-success" style="display: none;">
					
						<div style="float:right;"><button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button></div>
							<h4>登陆成功!</h4>
							<p id="msg-success-p"></p>
					
				</pre>
				
				<pre  class="12u 12u$(xsmall)" id="msg-error" style="display: none;">
					
						<div style="float:right;"><button type="button" class="close" id="error-close" aria-hidden="true">&times;</button></div>
							<h4>出错了!</h4>
							<p id="msg-error-p"></p>
					
				</pre>

				<div class="12u 12u$(xsmall)">
					<a href="/auth/register" class="text-center">注册个帐号</a>
				</div>
			</div><!-- /.form-box -->
	</div>
</div>






</body>
</html>





				<!-- Footer -->
					<footer id="footer">
						<div class="inner">
							<section>
								<h2>Follow</h2>
								<ul class="icons">
									<li><a class="white-text" href="/user">用户中心</a></li>
									<li><a class="white-text" href="/auth/login">登录</a></li>
									<li><a class="white-text" href="/auth/register">注册</a></li>
									<li><a class="white-text" href="/code">邀请码</a></li>
									<li><a class="white-text" href="/tos">TOS</a></li>
								</ul>
							</section>
							<ul class="copyright">
								<li>&copy; {$config["appName"]}  Powered by <a class="orange-text text-lighten-3" href="https://github.com/orvice/ss-panel">ss-panel</a> {$config["version"]}   &copy; Untitled. All rights reserved</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
							</ul>
						</div>
					</footer>

			</div>

		<!-- Scripts -->
			<script src="/assets/js/jquery.min.js"></script>
			<script src="/assets/js/skel.min.js"></script>
			<script src="/assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="/assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="/assets/js/main.js"></script>

	</body>
</html>









<script>
    $(document).ready(function(){
        function reset(){
            $.ajax({
                type:"POST",
                url:"/password/reset",
                dataType:"json",
                data:{
                    email: $("#email").val(),
                },
                success:function(data){
                    if(data.ret == 1){
                        $("#msg-error").hide(100);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                       // window.setTimeout("location.href='/auth/login'", 2000);
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
                }
            });
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                login();
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
</body>
</html>

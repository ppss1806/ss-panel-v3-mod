

{include file='header.tpl'}


<main class="content">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-lg-push-4 col-sm-6 col-sm-push-3">
					<section class="content-inner">
						<div class="card">
							<div class="card-main">
								<div class="card-header">
									<div class="card-inner">
										<h1 class="card-heading">和我签订契约，成为魔法少女吧。</h1>
									</div>
								</div>
								<div class="card-inner">
									<p class="text-center">
										<span class="avatar avatar-inline avatar-lg">
											<img alt="Login" src="/theme/material/images/users/avatar-001.jpg">
										</span>
									</p>
									
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="name">昵称</label>
													<input class="form-control" id="name" type="text">
												</div>
											</div>
										</div>
										
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="email">邮箱</label>
													<input class="form-control" id="email" type="text">
												</div>
											</div>
										</div>
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="passwd">密码</label>
													<input class="form-control" id="passwd" type="password">
												</div>
											</div>
										</div>
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="repasswd">重复密码</label>
													<input class="form-control" id="repasswd" type="password">
												</div>
											</div>
										</div>
										
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="wechat">微信</label>
													<input class="form-control" id="wechat" type="text">
												</div>
											</div>
										</div>
										
										
										
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="code">邀请码</label>
													<input class="form-control" id="code" type="text" value="{$code}">
												</div>
											</div>
										</div>
										
										<div class="form-group">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<button id="reg" type="submit" class="btn btn-block btn-brand waves-attach waves-light">注册</button>
												</div>
											</div>
										</div>
										
										<div class="form-group">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<p>注册即代表同意<a href="/tos">服务条款</a>，以及保证所录入信息的真实性，如有不实信息会导致账号被删除。</p>
												</div>
											</div>
										</div>
									
								</div>
							</div>
						</div>
						<div class="clearfix">
							<p class="margin-no-top pull-left"><a class="btn btn-flat btn-brand waves-attach" href="/auth/login">已经注册？请登录</a></p>
						</div>
						
						
						
								
						<div aria-hidden="true" class="modal fade" id="result" role="dialog" tabindex="-1">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-heading">
										<a class="modal-close" data-dismiss="modal">×</a>
										<h2 class="modal-title">操作结果</h2>
									</div>
									<div class="modal-inner">
										<p id="msg"></p>
									</div>
									<div class="modal-footer">
										<button class="btn btn-flat btn-brand waves-attach" data-dismiss="modal" type="button">知道了</button></p>
									</div>
								</div>
							</div>
						</div>
						
						
						
					</section>
				</div>
			</div>
		</div>
	</main>
	
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
                        $("#result").modal();
                        $("#msg").html(data.msg+"  五秒后跳转。");
                        window.setTimeout("location.href='/auth/login'", 5000);
                    }else{
                        $("#result").modal();
                        $("#msg").html(data.msg);
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
    })
</script>







	

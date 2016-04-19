


{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">添加兑换码</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-lg-push-0 col-sm-10 col-sm-push-1">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<h4>注意!</h4>
								<p>类型 10001=流量充值，数量则为要充值的流量大小(单位 GB)，10002=用户有效期充值，数量为要续的天数，1～10000=用户级别充值，类型就是你要充值的级别啦，数量就是要续的天数.</p>
								
								
							</div>
						</div>
					</div>
					
					
					
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<div class="form-group form-group-label">
									<label class="floating-label" for="amount">兑换码数目</label>
									<input class="form-control" id="amount" type="text" >
								</div>
								
								
								<div class="form-group form-group-label">
									<label class="floating-label" for="type">兑换码类型</label>
									<input class="form-control" id="type" type="text" >
								</div>
								
								<div class="form-group form-group-label">
									<label class="floating-label" for="number">数量</label>
									<input class="form-control" id="number" type="text" >
								</div>

								
								
							</div>
						</div>
					</div>

					
					
					
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								
								<div class="form-group">
									<div class="row">
										<div class="col-md-10 col-md-push-1">
											<button id="submit" type="submit" class="btn btn-block btn-brand waves-attach waves-light">添加</button>
										</div>
									</div>
								</div>
							</div>
						</div>
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

			</div>
			
			
			
		</div>
	</main>

	
	
	
	






{include file='admin/footer.tpl'}


<script>
    $(document).ready(function () {
        function submit() {
            $.ajax({
                type: "POST",
                url: "/admin/code",
                dataType: "json",
                data: {
                    amount: $("#amount").val(),
                    type: $("#type").val(),
                    number: $("#number").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
                        $("#msg").html(data.msg+"  五秒后跳转。");
                        window.setTimeout("location.href='/admin/code'", 5000);
                    } else {
                        $("#msg-error").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
                        $("#msg").html(data.msg+"  发生错误了。");
                }
            });
        }

        $("html").keydown(function (event) {
            if (event.keyCode == 13) {
                login();
            }
        });
        $("#submit").click(function () {
            submit();
        });
       
    })
</script>
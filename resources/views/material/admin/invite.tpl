





{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">邀请码</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-6 col-lg-push-3 col-sm-10 col-sm-push-1">
				<section class="content-inner margin-top-no">
				
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>公共邀请码（类别为0的邀请码）请<a href="/code">在这里查看</a>。</p>
							</div>
						</div>
					</div>
					
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<div class="form-group form-group-label">
									<label class="floating-label" for="prefix">邀请码前缀</label>
									<input class="form-control" id="prefix" type="text">
								</div>
								
								<div class="form-group form-group-label">
									<label class="floating-label" for="uid">邀请码类别(0为公开，其他数字为对应用户的UID)</label>
									<input class="form-control" id="uid" type="text">
								</div>
								
								<div class="form-group form-group-label">
									<label class="floating-label" for="prefix">邀请码数量</label>
									<input class="form-control" id="num" type="number">
								</div>
								
								
								<div class="form-group">
									<div class="row">
										<div class="col-md-10 col-md-push-1">
											<button id="invite" type="submit" class="btn btn-block btn-brand waves-attach waves-light">生成</button>
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
        $("#invite").click(function () {
            $.ajax({
                type: "POST",
                url: "/admin/invite",
                dataType: "json",
                data: {
                    prefix: $("#prefix").val(),
                    uid: $("#uid").val(),
                    num: $("#num").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
                        $("#msg").html(data.msg+"  五秒后跳转。");
                        window.setTimeout("location.href='/admin/invite'", 5000);
                    }
                    // window.location.reload();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>


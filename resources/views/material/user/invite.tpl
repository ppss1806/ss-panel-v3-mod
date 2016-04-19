















{include file='user/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">邀请</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="row">
				
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">注意！</p>

										<p>邀请码请给认识的需要的人。</p>

										<p>邀请有记录，若被邀请的人违反用户协议，您将会有连带责任。</p>
									</div>
									
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">说明</p>

										<p>用户注册48小时后，才可以生成邀请码。</p>

										<p>邀请码暂时无法购买，请珍惜。</p>

										<p>公共页面不定期发放邀请码，如果用完邀请码可以关注公共邀请。</p>
									</div>
									
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">邀请</p>
										<p>当前您可以生成<code>{$user->invite_num}</code>个邀请码。 </p>
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											{if $user->invite_num }
												<button id="invite" class="btn btn-flat waves-attach">生成我的邀请码</button>
											{/if}
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<div class="card-table">
											<div class="table-responsive">
												<table class="table">
													<thead>
													<tr>
														<th>###</th>
														<th>邀请码(点右键复制链接)</th>
														<th>状态</th>
													</tr>
													</thead>
													<tbody>
													{foreach $codes as $code}
														<tr>
															<td><b>{$code->id}</b></td>
															<td><a href="/auth/register?code={$code->code}" target="_blank">{$code->code}</a>
															</td>
															<td>可用</td>
														</tr>
													{/foreach}
													</tbody>
												</table>
											</div>
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
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}


<script>
    $(document).ready(function () {
        $("#invite").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/invite",
                dataType: "json",
                success: function (data) {
                    window.location.reload();
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>


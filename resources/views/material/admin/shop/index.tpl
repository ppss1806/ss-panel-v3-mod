


{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">商品列表</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-lg-push-0 col-sm-10 col-sm-push-1">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>系统中所有商品的列表。</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$shops->render()}
						<table class="table ">
                            <tr>
								<th>操作</th>
                                <th>ID</th>
                                <th>名称</th>
								<th>价格</th>
								<th>内容</th>
                                <th>自动续费天数</th>
                                
                            </tr>
                            {foreach $shops as $shop}
                            <tr>
								<td>
                                    <a class="btn btn-brand" href="/admin/shop/{$shop->id}/edit">编辑</a>
                                    <a class="btn btn-brand-accent" id="delete" href="javascript:void(0);" onClick="delete_modal_show('{$shop->id}')">删除</a>
                                </td>
                                <td>#{$shop->id}</td>
                                <td>{$shop->name}</td>
								<td>{$shop->price} 元</td>
                                <td>{$shop->content()}</td>
								{if $shop->auto_renew==0}
                                <td>不自动续费</td>
								{else}
								<td>在 {$shop->auto_renew} 天后自动续费</td>
								{/if}
                                
                            </tr>
                            {/foreach}
                        </table>
						{$shops->render()}
					</div>
					
					<div class="fbtn-container">
						<div class="fbtn-inner">
							<a class="fbtn fbtn-lg fbtn-brand-accent waves-attach waves-circle waves-light" href="/admin/shop/create">+</a>
							
						</div>
					</div>
					
					<div aria-hidden="true" class="modal fade" id="delete_modal" role="dialog" tabindex="-1">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-heading">
									<a class="modal-close" data-dismiss="modal">×</a>
									<h2 class="modal-title">确认要删除？</h2>
								</div>
								<div class="modal-inner">
									<p>请您确认。</p>
								</div>
								<div class="modal-footer">
									<p class="text-right"><button class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal" type="button">取消</button><button class="btn btn-flat btn-brand-accent waves-attach" data-dismiss="modal" id="delete_input" type="button">确定</button></p>
								</div>
							</div>
						</div>
					</div>

							
			</div>
			
			
			
		</div>
	</main>






{include file='admin/footer.tpl'}


<script>
function delete_modal_show(id) {
	deleteid=id;
	$("#delete_modal").modal();
}


$("#delete_input").click(function () {
	window.setTimeout("location.href='/admin/shop/"+deleteid+"/delete'", 1000);
});
	
</script>








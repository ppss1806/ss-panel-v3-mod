


{include file='user/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">购买记录</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-lg-push-0 col-sm-10 col-sm-push-1">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>系统中您的购买记录。</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$shops->render()}
						<table class="table ">
                            <tr>
								<th>操作</th>
                                <th>ID</th>
                                <th>商品名称</th>
								<th>内容</th>
								<th>价格</th>
                                <th>续费时间</th>
                                
                            </tr>
                            {foreach $shops as $shop}
                            <tr>
								<td>
                                    <a class="btn btn-brand" {if $shop->renew==0}disabled{/if} href="/user/bought/{$shop->id}/delete">退订</a>
                                </td>
                                <td>#{$shop->id}</td>
                                <td>{$shop->shop()->name}</td>
								<td>{$shop->shop()->content()}</td>
								<td>{$shop->price} 元</td>
								{if $shop->renew==0}
                                <td>不自动续费</td>
								{else}
								<td>在 {$shop->renew_date()} 续费</td>
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

							
			</div>
			
			
			
		</div>
	</main>






{include file='user/footer.tpl'}











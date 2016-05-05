


{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">节点列表</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-lg-push-0 col-sm-10 col-sm-push-1">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>系统中所有节点的列表。</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$nodes->render()}
						<table class="table ">
                            <tr>
								<th>操作</th>
                                <th>ID</th>
                                <th>节点</th>
								<th>IP</th>
                                <th>加密</th>
                                <th>描述</th>
                                <th>类型</th>
                                
                            </tr>
                            {foreach $nodes as $node}
                            <tr>
								<td>
                                    <a class="btn btn-brand" href="/admin/node/{$node->id}/edit">编辑</a>
                                    <a class="btn btn-brand-accent" id="delete" value="{$node->id}" href="/admin/node/{$node->id}/delete">删除</a>
                                </td>
                                <td>#{$node->id}</td>
                                <td>{$node->name}</td>
								<td>{$node->node_ip}</td>
                                <td>{$node->method}</td>
                                <td>{$node->info}</td>
                                <td>{$node->sort}</td>
                                
                            </tr>
                            {/foreach}
                        </table>
						{$nodes->render()}
					</div>
					
					<div class="fbtn-container">
						<div class="fbtn-inner">
							<a class="fbtn fbtn-lg fbtn-brand-accent waves-attach waves-circle waves-light" href="/admin/node/create">+</a>
							
						</div>
					</div>

							
			</div>
			
			
			
		</div>
	</main>






{include file='admin/footer.tpl'}











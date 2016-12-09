


{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">审计规则管理</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-md-12">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>系统中所有过滤规则。</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$rules->render()}
						<table class="table">
						    <tr>
							<th>操作</th>
						        <th>ID</th>
						        <th>名称</th>
						        <th>描述</th>
							<th>正则表达式</th>
							<th>类型</th>
								
						    </tr>
						    {foreach $rules as $rule}
						        <tr>
								<td>
									<a class="btn btn-brand" href="/admin/detect/{$rule->id}/edit">编辑</a>
									<a class="btn btn-brand-accent" id="delete" value="{$rule->id}" href="javascript:void(0);" onClick="delete_modal_show('{$rule->id}')">删除</a>
								</td>
								<td>#{$rule->id}</td>
								<td>{$rule->name}</td>
								<td>{$rule->text}</td>
								<td>{$rule->regex}</td>
								{if $rule->type == 1}
									<td>数据包明文匹配</td>
								{/if}		
								{if $rule->type == 2}
									<td>数据包 hex 匹配</td>
								{/if}								
						        </tr>
						    {/foreach}
						</table>
						{$rules->render()}
					</div>
					
					<div class="fbtn-container">
						<div class="fbtn-inner">
							<a class="fbtn fbtn-lg fbtn-brand-accent waves-attach waves-circle waves-light" href="/admin/detect/create">+</a>
							
						</div>
					</div>
					
					<div aria-hidden="true" class="modal modal-va-middle fade" id="delete_modal" role="dialog" tabindex="-1">
						<div class="modal-dialog modal-xs">
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
					
					{include file='dialog.tpl'}

							
			</div>
			
			
			
		</div>
	</main>






{include file='admin/footer.tpl'}




<script>
function delete_modal_show(id) {
	deleteid=id;
	$("#delete_modal").modal();
}


$(document).ready(function(){
	function delete_id(){
		$.ajax({
			type:"DELETE",
			url:"/admin/detect",
			dataType:"json",
			data:{
				id: deleteid
			},
			success:function(data){
				if(data.ret){
					$("#result").modal();
					$("#msg").html(data.msg);
					window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
				}else{
					$("#result").modal();
					$("#msg").html(data.msg);
				}
			},
			error:function(jqXHR){
				$("#result").modal();
				$("#msg").html(data.msg+"  发生错误了。");
			}
		});
	}
	$("#delete_input").click(function(){
		delete_id();
	});
})
	
</script>








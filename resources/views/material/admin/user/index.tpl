{include file='admin/main.tpl'}







<main class="content">
	<div class="content-header ui-content-header">
		<div class="container">
			<h1 class="content-heading">用户列表</h1>
		</div>
	</div>
	<div class="container">
		<div class="col-lg-12 col-sm-12">
			<section class="content-inner margin-top-no">

				<div class="card">
					<div class="card-main">
						<div class="card-inner">
							<p>系统中所有用户的列表。</p>
							<p>显示表项：
								{foreach $total_array as $key => $value}
									<div class="checkbox checkbox-adv checkbox-inline">
										<label for="checkbox_{$key}">
											<input href="javascript:void(0);" onClick="modify_table_visible('checkbox_{$key}', '{$key}')" {if in_array($key, $default_show_array)}checked=""{/if} class="access-hide" id="checkbox_{$key}" name="checkbox_{$key}" type="checkbox">{$value}
											<span class="checkbox-circle"></span><span class="checkbox-circle-check"></span><span class="checkbox-circle-icon icon">done</span>
										</label>
									</div>
								{/foreach}
							</p>
						</div>
					</div>
				</div>

				<div class="table-responsive">
					<table class="table" id="table_users" cellspacing="0" width="100%">
						<thead>
							<tr>
								{foreach $total_array as $key => $value}
									<th class="{$key}">{$value}</th>
								{/foreach}
							</tr>
						</thead>
						<tfoot>
							<tr>
								{foreach $total_array as $key => $value}
									<th class="{$key}">{$value}</th>
								{/foreach}
							</tr>
						</tfoot>
					</table>
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

function modify_table_visible(id, key) {
	if(document.getElementById(id).checked)
	{
		table.columns( '.' + key ).visible( true );
	}
	else
	{
		table.columns( '.' + key ).visible( false );
	}
}

$(document).ready(function(){
 	table = $('#table_users').DataTable({
      "ajax": {
				"url": "user/ajax",
				"dataSrc": function ( json ) {
		      for ( var i=0, ien=json.data.length ; i<ien ; i++ ) {
		        json.data[i][0] = '<a class="btn btn-brand" href="/admin/user/' + json.data[i][0] + '/edit">编辑</a>' +
						'<a class="btn btn-brand-accent" id="delete" href="javascript:void(0);" onClick="delete_modal_show(\'' + json.data[i][0] + '\')">删除</a>';
		      }
		      return json.data;
		    }
			}
  });

	{foreach $total_array as $key => $value}
		modify_table_visible('checkbox_{$key}', '{$key}');
	{/foreach}

	function delete_id(){
		$.ajax({
			type:"DELETE",
			url:"/admin/user",
			dataType:"json",
			data:{
				id: deleteid
			},
			success:function(data){
				if(data.ret){
					$("#result").modal();
					$("#msg").html(data.msg);
					table
							.row('#row_user_' + deleteid)
							.remove()
							.draw();
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

	function search(){
		window.location="/admin/user/search/"+$("#search").val();
	}

	$("#delete_input").click(function(){
		delete_id();
	});

	$("#search_button").click(function(){
		if($("#search").val()!="")
		{
			search();
		}
	});
})


</script>

{include file='admin/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
		<section>
			<h1>
				节点列表
			</h1>
		</section>
		
		<div class="12u 12u$(xsmall)">
			<p> <a class="button special" href="/admin/node/create">添加</a> </p>
		</div>
		
		
		<div class="12u 12u$(xsmall)">
			<div class="table-wrapper">
				<table>
					<tr>
						<th>ID</th>
						<th>节点</th>
						<th>IP</th>
						<th>加密</th>
						<th>描述</th>
						<th>类型</th>
						<th>操作</th>
					</tr>
					{foreach $nodes as $node}
					<tr>
						<td>#{$node->id}</td>
						<td>{$node->name}</td>
						<td>{$node->node_ip}</td>
						<td>{$node->method}</td>
						<td>{$node->info}</td>
						<td>{$node->sort}</td>
						<td>
							<a class="btn btn-info btn-sm" href="/admin/node/{$node->id}/edit">编辑</a>
							<a class="btn btn-danger btn-sm" id="delete" value="{$node->id}" href="/admin/node/{$node->id}/delete">删除</a>
						</td>
					</tr>
					{/foreach}
				</table>
			</div>
		</div>
		
	</div>
</div>





<script>
    $(document).ready(function(){
        function delete(){
            $.ajax({
                type:"DELETE",
                url:"/admin/node/",
                dataType:"json",
                data:{
                    name: $("#name").val()
                },
                success:function(data){
                    if(data.ret){
                        $("#msg-error").hide(100);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/admin/node'", 2000);
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
        $("#delete").click(function(){
            delete();
        });
        $("#ok-close").click(function(){
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function(){
            $("#msg-error").hide(100);
        });
    })
</script>

{include file='admin/footer.tpl'}
{include file='admin/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
			<h1>
				编辑节点 #{$node->id}
			</h1>
	
	
	<pre class="12u 12u$(xsmall)" id="msg-success" style="display: none;">

			<div style="float:right;"><button type="button" id="ok-close" aria-hidden="true">&times;</button></div>
				<h4>成功!</h4>
				<p id="msg-success-p"></p>
	</pre>

	<pre class="12u 12u$(xsmall)" id="msg-error" style="display: none;" >
		
			<div style="float:right;"><button type="button" id="error-close" aria-hidden="true">&times;</button></div>
				<h4>出错了!</h4>
				<p id="msg-error-p"></p>
		
	</pre>
	
	<section>
		<legend>节点信息</legend>
		<div class="12u 12u$(xsmall)">
			<label class="control-label">节点名称</label>
			<input type="text" id="name" class="form-control" value=""/>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">节点地址</label>
			<input type="text" id="address" class="form-control" value=""/>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">加密方式</label>
			<input type="text" id="method" class="form-control" value=""/>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">流量比率</label>
			<input type="text" id="rate" class="form-control" value=""/>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label>自定义加密</label>
			<div class="select-wrapper">
				<select id="custom_method">
					<option value="0" >
						不支持
					</option>
					<option value="1" >
						支持
					</option>
				</select>
			</div>
		</div>
	</section>
	<section>
		<legend>描述信息</legend>
			<label>自定义加密</label>
			
			<div class="select-wrapper">
				<select id="type">
					<option value="1" >显示
					</option>
					<option value="0" >隐藏
					</option>
				</select>
			</div>
			
			
			<div class="12u 12u$(xsmall)">
				<label class="control-label">节点状态</label>
				<input type="text" id="status" class="form-control" value=""/>
			</div>
			
			<div class="12u 12u$(xsmall)">
				<label class="control-label">类型（SS=0,VPN=1.....请看 zhaojin97.cn）</label>
				<input type="text" id="sort" class="form-control" value=""/>
			</div>
			
			<div class="12u 12u$(xsmall)">
				<label class="control-label">节点描述</label>
				<input type="text" id="info" class="form-control" value=""/>
			</div>
			
			<div class="12u 12u$(xsmall)">
				<label class="control-label">节点类别（不分类请填0，分类为数字）</label>
				<input type="text" id="class" class="form-control" value="0"/>
			</div>

			<div class="12u 12u$(xsmall)">
				<label class="control-label">节点流量上限（不使用的话请填0）</label>
				<input type="text" id="node_bandwidth_limit" class="form-control" value="0"/>
			</div>
			
			<div class="12u 12u$(xsmall)">
				<label class="control-label">节点流量上限清空日</label>
				<input type="text" id="bandwidthlimit_resetday" class="form-control" value="0"/>
			</div>
			
			<div class="12u 12u$(xsmall)">
				<label class="control-label">节点限速(对于每个用户端口)</label>
				<input type="text" id="node_speedlimit" class="form-control" value="0"/><div class="input-group-addon">Mbps</div>
			</div>
			
	</section>
	<section>
		<div class="12u 12u$(xsmall)">
			<button type="submit" id="submit" class="special fit">添加</button>
		</div>
	</section>
	</div>
</div>


<script>
    $(document).ready(function () {
        function submit() {
            $.ajax({
                type: "POST",
                url: "/admin/node",
                dataType: "json",
                data: {
                    name: $("#name").val(),
                    server: $("#server").val(),
                    method: $("#method").val(),
                    custom_method: $("#custom_method").val(),
                    rate: $("#rate").val(),
                    info: $("#info").val(),
                    type: $("#type").val(),
                    status: $("#status").val(),
                    sort: $("#sort").val(),
					node_speedlimit: $("#node_speedlimit").val(),
					class: $("#class").val(),
					node_bandwidth_limit: $("#node_bandwidth_limit").val(),
					bandwidthlimit_resetday: $("#bandwidthlimit_resetday").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide(100);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/admin/node'", 2000);
                    } else {
                        $("#msg-error").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误：" + jqXHR.status);
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
        $("#ok-close").click(function () {
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function () {
            $("#msg-error").hide(100);
        });
    })
</script>


{include file='admin/footer.tpl'}
{include file='admin/main.tpl'}

<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
		
			<h1>
				用户编辑 #{$user->id}
			</h1>
		
		
		<pre class="12u 12u$(xsmall)" id="msg-success" style="display: none;">

				<div style="float:right;"><button type="button" id="ok-close" aria-hidden="true" >&times;</button></div>
					<h4>成功!</h4>
					<p id="msg-success-p"></p>

		</pre>
		
		<pre class="12u 12u$(xsmall)" id="msg-error" style="display: none;">
			
				<div style="float:right;"><button type="button" id="error-close" aria-hidden="true">&times;</button></div>
					<h4>出错了!</h4>
					<p id="msg-error-p"></p>
			
		</pre>
		
		<section>
		
			<legend>帐号信息</legend>
		
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">邮箱</label>
			<input type="text" id="email" class="form-control" value="{$user->email}"/>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<input type="text" id="pass" class="form-control" placeholder="密码，不修改就不要动"/>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label>是否管理员</label>
			<div class="select-wrapper">
				<select id="is_admin">
					<option value="0" {if $user->is_admin==0}selected="selected"{/if}>
						否
					</option>
					<option value="1" {if $user->is_admin==1}selected="selected"{/if}>
						是
					</option>
				</select>
			</div>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label>用户状态</label>
			<div class="select-wrapper">
				<select id="enable">
					<option value="1" {if $user->enable==1}selected="selected"{/if}>
						正常
					</option>
					<option value="0" {if $user->enable==0}selected="selected"{/if}>
						禁用
					</option>
				</select>
			</div>
		</div>
		</section>
		
		<section>
		
			<legend>ShadowSocks连接信息</legend>
		
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">连接端口</label>
			<input class="form-control" id="port" type="text" value="{$user->port}">
		</div>
		
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">连接密码</label>
			<input class="form-control" id="passwd" type="text" value="{$user->passwd}">
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">加密方式</label>
			<input class="form-control" id="method" type="text" value="{$user->method}">
		</div>
		
		<div class="12u 12u$(xsmall)">
			<legend>流量</legend>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">总流量</label>
			<input class="form-control" id="transfer_enable" type="text"
				   value="{$user->transfer_enable}">

			<div class="input-group-addon">字节</div>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">已用流量</label>
			<input class="form-control" id="usedTraffic" type="text"
				   value="{$user->u+$user->d}" readonly>

			<div class="input-group-addon">字节</div>
		</div>
		</section>
		<section>
			<legend>邀请</legend>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">可用邀请数量</label>
			<input class="form-control" id="invite_num" type="text"
				   value="{$user->invite_num}" >
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">邀请人ID</label>
			<input class="form-control" id="ref_by" type="text"
				   value="{$user->ref_by}" readonly>
		</div>
		</section>
		<section>

			<legend>节点分类</legend>

		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">用户级别（用户只能访问到小于等于这个数字的节点）</label>
			<input class="form-control" id="class" type="text"
				   value="{$user->class}" >
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">用户级别过期时间(不过期就请不要动)</label>
			<input class="form-control" id="class_expire" type="text"
				   value="{$user->class_expire}">
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">用户账户过期时间(不过期就请不要动)</label>
			<input class="form-control" id="expire_in" type="text"
				   value="{$user->expire_in}">
		</div>	

		<div class="12u 12u$(xsmall)">
			<label class="control-label">用户限速，用户在每个节点所享受到的速度</label>
			<input class="form-control" id="node_speedlimit" type="text"
				   value="{$user->node_speedlimit}">
		</div>	
		
		
		</section>
		<div class="12u 12u$(xsmall)">
			<button type="submit" id="add" class="special fit">修改</button>
		</div>
		
	</div>
</div>




<script>
	//document.getElementById("class_expire").value="{$user->class_expire}";
    $(document).ready(function () {
        function submit() {
            $.ajax({
                type: "PUT",
                url: "/admin/user/{$user->id}",
                dataType: "json",
                data: {
                    email: $("#email").val(),
                    pass: $("#pass").val(),
                    port: $("#port").val(),
                    passwd: $("#passwd").val(),
                    transfer_enable: $("#transfer_enable").val(),
                    invite_num: $("#invite_num").val(),
                    method: $("#method").val(),
                    enable: $("#enable").val(),
                    is_admin: $("#is_admin").val(),
					node_speedlimit: $("#node_speedlimit").val(),
                    ref_by: $("#ref_by").val(),
					class: $("#class").val(),
					class_expire: $("#class_expire").val(),
					expire_in: $("#expire_in").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide(100);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/admin/user'", 2000);
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
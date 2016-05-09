{include file='user/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
			<h1>
				删除我的帐号
			</h1>
		
	<pre class="12u 12u$(xsmall)" id="msg-success" style="display: none;">

				<h4>成功!</h4>
				<p id="msg-success-p"></p>
	</pre>

	<pre class="12u 12u$(xsmall)" id="msg-error" style="display: none;" >
		
			<div style="float:right;"><button type="button" id="error-close" aria-hidden="true">&times;</button></div>
				<h4>出错了!</h4>
				<p id="msg-error-p"></p>
		
	</pre>
	
	<div class="12u 12u$(xsmall)" >
		<h4>输入当前密码以验证身份</h4>
		<input type="password" class="form-control" placeholder="当前密码(必填)" id="passwd">
		<button type="submit" id="kill" class="btn btn-danger">删除我的帐号</button>
		</div>
	</div>
	
	<pre class="12u 12u$(xsmall)" >
		
				<h4>注意！</h4>

				<p>帐号删除后，您的所有数据都会被<b>真实地</b>删除。</p>

				<p>如果想重新使用本网站提供的服务，您需要重新注册。</p>
		
	</pre>
</div>



<script>
    $("#msg-success").hide();
    $("#msg-error").hide();
    $("#ss-msg-success").hide();
</script>

<script>
    $(document).ready(function () {
        $("#kill").click(function () {
            $.ajax({
                type: "POST",
                url: "kill",
                dataType: "json",
                data: {
                    passwd: $("#passwd").val(),
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide();
                        $("#msg-success").show();
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/'", 2000);
                    } else {
                        $("#msg-error").show();
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>

{include file='user/footer.tpl'}
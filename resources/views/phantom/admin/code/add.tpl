{include file='admin/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
			<h1>
				添加兑换码
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
	
	
	<pre class="12u 12u$(xsmall)" >
		
				<h4>注意!</h4>
                <p>类型 10001=流量充值，数量则为要充值的流量大小(单位 GB)，10002=用户有效期充值，数量为要续的天数，1～10000=用户级别充值，类型就是你要充值的级别啦，数量就是要续的天数.</p>
		
	</pre>
	
	<section>
		<legend>兑换码信息</legend>
		<div class="12u 12u$(xsmall)">
			<label class="control-label">兑换码数目</label>
			<input type="text" id="amount" class="form-control"/>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">兑换码类型</label>
			<input type="text" id="type" class="form-control"/>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<label class="control-label">数量</label>
			<input type="text" id="number" class="form-control"/>
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
                url: "/admin/code",
                dataType: "json",
                data: {
                    amount: $("#amount").val(),
                    type: $("#type").val(),
                    number: $("#number").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide(100);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/admin/code'", 2000);
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
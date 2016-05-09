{include file='admin/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
			<h1>
				添加公告
			</h1>
	
	
	<pre class="12u 12u$(xsmall)" id="msg-success" style="display: none;">

			<div style="float:right;"><button type="button"  id="ok-close" aria-hidden="true">&times;</button></div>
				<h4>成功!</h4>
				<p id="msg-success-p"></p>

	</pre>

	<pre class="12u 12u$(xsmall)" id="msg-error" style="display: none;">
		
			<div style="float:right;"><button type="button" id="error-close" aria-hidden="true">&times;</button></div>
				<h4>出错了!</h4>
				<p id="msg-error-p"></p>
		
	</pre>
	
	<section>
		<legend>添加公告</legend>
		<div class="12u 12u$(xsmall)">
			<label class="control-label">公告内容</label>
			<input type="text" class="form-control" id="content" placeholder="Here"/>
		</div>
		
	</section>
	<section>
		<div class="12u 12u$(xsmall)">
			<div class="12u 12u$(xsmall)">
				<button type="submit" id="submit" class="special fit">添加</button>
			</div>
		</div>
	</section>
	</div>
</div>



<script>
    $(document).ready(function () {
        function submit() {
            $.ajax({
                type: "POST",
                url: "/admin/announcement",
                dataType: "json",
                data: {
                    content: $("#content").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide(100);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/admin/announcement'", 2000);
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
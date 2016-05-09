{include file='admin/main.tpl'}







<div id="main">
	<div class="inner">
    <!-- Content Header (Page header) -->
    <section>
        <h1>
            邀请
        </h1>
    </section>
	
	<section>
		<pre class="12u 12u$(xsmall)" id="msg-success" style="display: none;">
					
							<h4> 成功!</h4>
							<p id="msg-success-p"></p>
					
		</pre>
		
		<div class="12u 12u$(xsmall)">
					<h3>添加邀请码</h3>
		</div>
		
		<div class="12u 12u$(xsmall)">
					<input type="text" id="prefix" class="form-control" placeholder="邀请码前缀,小于8个字符"/>
		</div>
		
		<div class="12u 12u$(xsmall)">
					<input type="text" id="uid" class="form-control" placeholder="邀请码类别,0为公开，其他数字为对应用户的UID"/>
		</div>
		
		<div class="12u 12u$(xsmall)">
					<input type="text" id="num" class="form-control" placeholder="要生成的邀请码数量"/>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<button type="submit" id="invite" class="special fit">生成</button>
		</div>
		
		<div class="12u 12u$(xsmall)">
			<p>公共邀请码（类别为0的邀请码）请<a href="/code">在这里查看</a>。</p>
		</div>
		
		
	</section>
	
	
	</div>
</div>


<script>
    $(document).ready(function () {
        $("#invite").click(function () {
            $.ajax({
                type: "POST",
                url: "/admin/invite",
                dataType: "json",
                data: {
                    prefix: $("#prefix").val(),
                    uid: $("#uid").val(),
                    num: $("#num").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        //window.setTimeout("location.href='/admin/invite'", 2000);
                    }
                    // window.location.reload();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>

{include file='admin/footer.tpl'}
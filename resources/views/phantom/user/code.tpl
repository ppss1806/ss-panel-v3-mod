{include file='user/main.tpl'}



<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
			<h1>
				兑换码
			</h1>
	
	
	<pre class="12u 12u$(xsmall)" id="msg-success" style="display: none;">

				<h4>成功!</h4>
				<p id="msg-success-p"></p>
	</pre>

	<pre class="12u 12u$(xsmall)" id="msg-error" style="display: none;" >
		
				<h4>出错了!</h4>
				<p id="msg-error-p"></p>
		
	</pre>
	
	
	<div class="12u 12u$(xsmall)" >
		
				<h4>兑换码键入</h4>
               <input type="text" class="form-control" placeholder="请键入兑换码" id="code">
			   <button type="submit" id="code-update" class="special fit">添加</button>
		
	</div>
	
	<div class="12u 12u$(xsmall)" >
		
			<h4>已使用兑换码</h4>
            {$codes->render()}
			<table class="table-wrapper">
				<tr>
					<th>ID</th>
					<th>代码</th>
					<th>类型</th>
					<th>操作</th>
					<th>使用时间</th>
					
				</tr>
				{foreach $codes as $code}
					<tr>
						<td>#{$code->id}</td>
						<td>{$code->code}</td>
						{if $code->type==10001}
						<td>流量充值</td>
						{/if}
						{if $code->type==10002}
						<td>用户续期</td>
						{/if}
						{if $code->type>=1&&$code->type<=10000}
						<td>等级续期 - 等级{$code->type}</td>
						{/if}
						{if $code->type==10001}
						<td>充值了 {$code->number} GB 流量</td>
						{/if}
						{if $code->type==10002}
						<td>延长账户有效期 {$code->number} 天</td>
						{/if}
						{if $code->type>=1&&$code->type<=10000}
						<td>延长等级有效期 {$code->number} 天</td>
						{/if}
						<td>{$code->usedatetime}</td>
					</tr>
				{/foreach}
			</table>
			{$codes->render()}
		
	</div>
	
	
	</div>
</div>



<script>
    $("#msg-success").hide();
    $("#msg-error").hide();
    $("#ss-msg-success").hide();
</script>

<script>
    $(document).ready(function () {
        $("#code-update").click(function () {
            $.ajax({
                type: "POST",
                url: "code",
                dataType: "json",
                data: {
                    code: $("#code").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide();
                        $("#msg-success").show();
                        $("#msg-success-p").html(data.msg);
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
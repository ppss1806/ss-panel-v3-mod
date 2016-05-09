{include file='user/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
			<h1>
				邀请
			</h1>
	

	<pre class="12u 12u$(xsmall)" id="msg-error" style="display: none;" >
		
			<div style="float:right;"><button type="button" id="error-close" aria-hidden="true">&times;</button></div>
				<h4>出错了!</h4>
				<p id="msg-error-p"></p>
		
	</pre>
	
	
	<div class="12u 12u$(xsmall)" >
		
				<h4>邀请</h4>
                <p>当前您可以生成{$user->invite_num}个邀请码。 </p>
				{if $user->invite_num }
					<button id="invite" class="special fit">生成我的邀请码</button>
				{/if}
		
	</div>
	
	<div class="12u 12u$(xsmall)" >
		
			<h4>我的邀请码</h4>
            <table class="table-wrapper">
                            <thead>
                            <tr>
                                <th>###</th>
                                <th>邀请码(点右键复制链接)</th>
                                <th>状态</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach $codes as $code}
                                <tr>
                                    <td><b>{$code->id}</b></td>
                                    <td><a href="/auth/register?code={$code->code}" target="_blank">{$code->code}</a>
                                    </td>
                                    <td>可用</td>
                                </tr>
                            {/foreach}
                            </tbody>
            </table>
		
	</div>
	
	<pre class="12u 12u$(xsmall)" >
		
				<h4>注意！</h4>
                <p>邀请码请给认识的需要的人。</p>

                <p>邀请有记录，若被邀请的人违反用户协议，您将会有连带责任。</p>
		
	</pre>
	
	<pre class="12u 12u$(xsmall)" >
		
				<h4>说明</h4>

				<p>用户注册48小时后，才可以生成邀请码。</p>

				<p>邀请码暂时无法购买，请珍惜。</p>

				<p>公共页面不定期发放邀请码，如果用完邀请码可以关注公共邀请。</p>
	
	</pre>
	
	</div>
</div>


<script>
    $(document).ready(function () {
        $("#invite").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/invite",
                dataType: "json",
                success: function (data) {
                    window.location.reload();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>

{include file='user/footer.tpl'}
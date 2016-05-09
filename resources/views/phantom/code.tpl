{include file='header.tpl'}

					<div id="main">
						<div class="inner">
							<div class="row center">
								<h5>邀请码实时刷新</h5>
								<h5>如遇到无邀请码请找已经注册的用户获取。</h5>
							</div>
							<table class="table-wrapper">
							<thead>
								<tr>
									<th>###</th>
									<th>邀请码 (点击邀请码进入注册页面)</th>
									<th>状态</th>
								</tr>
							</thead>
							<tbody>
							{foreach $codes as $code}
							<tr>
								<td>{$code->id}</td>
								<td><a href="/auth/register?code={$code->code}">{$code->code}</a></td>
								<td>可用</td>
							</tr>
							{/foreach}
							</tbody>
						</table>
						</div>
					</div>
{include file='footer.tpl'}
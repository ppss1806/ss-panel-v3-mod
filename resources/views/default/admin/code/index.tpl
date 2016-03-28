{include file='admin/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            兑换码管理
            <small>Code</small>
        </h1>
    </section>


    <!-- Main content -->
    <section class="content">
	
        <div class="row">
            <div class="col-xs-12">
				<p> <a class="btn btn-success btn-sm" href="/admin/code/create">添加</a> </p>
                <div class="box">
                    <div class="box-body table-responsive no-padding">
                        {$codes->render()}
                        <table class="table table-hover">
                            <tr>
                                <th>ID</th>
                                <th>代码</th>
                                <th>类型</th>
								<th>操作</th>
								<th>是否已被使用</th>
								<th>用户id</th>
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
									<td>{$code->isused}</td>
									<td>{$code->userid}</td>
									{if $code->usedatetime=="1989-06-04 02:30:00"}
									<td>未使用</td>
									{else}
									<td>{$code->usedatetime}</td>
									{/if}
                                </tr>
                            {/foreach}
                        </table>
                        {$codes->render()}
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->

{include file='user/footer.tpl'}
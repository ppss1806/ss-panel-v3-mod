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
            <div class="col-md-12">
                <div class="callout callout-warning">
                    <h4>注意!</h4>
                    <p>类型 10001=流量充值，数量则为要充值的流量大小(单位 GB)，10002=用户有效期充值，数量为要续的天数，1～10000=用户级别充值，类型就是你要充值的级别啦，数量就是要续的天数.</p>
                </div>
            </div>
        </div>
	
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
								<th>数目</th>
								<th>是否已被使用</th>
								<th>用户id</th>
								<th>使用时间</th>
								
                            </tr>
                            {foreach $codes as $code}
                                <tr>
                                    <td>#{$code->id}</td>
                                    <td>{$code->code}</td>
                                    <td>{$code->type}</td>
									<td>{$code->number}</td>
									<td>{$code->isused}</td>
									<td>{$code->userid}</td>
									<td>{$code->usedatetime}</td>
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
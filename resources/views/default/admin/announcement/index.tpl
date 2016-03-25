{include file='admin/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            公告管理
            <small>Announcement</small>
        </h1>
    </section>


    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
	<p> <a class="btn btn-success btn-sm" href="/admin/announcement/create">添加</a> </p>
                <div class="box">
                    <div class="box-body table-responsive no-padding">
                        {$logs->render()}
                        <table class="table table-hover">
                            <tr>
                                <th>ID</th>
                                <th>日期</th>
                                <th>内容</th>
								<th>操作</th>
                            </tr>
                            {foreach $logs as $log}
                                <tr>
                                    <td>#{$log->id}</td>
                                    <td>{$log->date}</td>
                                    <td>{$log->content}</td>
									<td>
										<a class="btn btn-info btn-sm" href="/admin/announcement/{$log->id}/edit">编辑</a>
										<a class="btn btn-danger btn-sm" id="delete" value="{$log->id}" href="/admin/announcement/{$log->id}/delete">删除</a>
									</td>
                                </tr>
                            {/foreach}
                        </table>
                        {$logs->render()}
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->

{include file='user/footer.tpl'}
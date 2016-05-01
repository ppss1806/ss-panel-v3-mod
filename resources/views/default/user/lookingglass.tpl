{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            观察窗
            <small>looking glass</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="callout callout-warning">
                    <h4>注意!</h4>  
					<p>此处只展示最近一次的记录.</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-body table-responsive no-padding">
                        
                        <table class="table table-hover">
							<tr>
							<th>节点</th>
							<th>电信延迟</th>
							<th>电信下载速度</th>
							<th>电信上传速度</th>
							<th>联通延迟</th>
							<th>联通下载速度</th>
							<th>联通上传速度</th>
							<th>移动延迟</th>
							<th>移动下载速度</th>
							<th>移动上传速度</th>
							</tr>
                            {foreach $speedtest as $single}
							<tr>
							<td>{$single->node()->name}</td>
							<td>{$single->telecomping}</td>
							<td>{$single->telecomeupload}</td>
							<td>{$single->telecomedownload}</td>
							<td>{$single->unicomping}</td>
							<td>{$single->unicomupload}</td>
							<td>{$single->unicomdownload}</td>
							<td>{$single->cmccping}</td>
							<td>{$single->cmccupload}</td>
							<td>{$single->cmccdownload}</td>
							</tr>
                            {/foreach}
                        </table>
                        
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->

{include file='user/footer.tpl'}
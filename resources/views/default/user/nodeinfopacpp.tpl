{include file='user/main.tpl'}

<div class="content-wrapper">
    <section class="content-header">
        <h1>
            节点列表
            <small>Node List</small>
        </h1>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- START PROGRESS BARS -->
        <div class="row">
            <div class="col-md-12">
                <div class="callout callout-warning">
                    <h4>注意!</h4>

                    <p>下面为您的 Pac Plus Plus 文件地址 和 配置</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="box box-solid">
                    <div class="box-header">
                        <i class="fa fa-code"></i>

                        <h3 class="box-title">配置信息</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        {$json_show}
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
                <div class="box box-solid">
                    <div class="box-header">
                        <i class="fa fa-code"></i>

                        <h3 class="box-title">配置方法</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        未完待续
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
        <!-- /.row -->
        <!-- END PROGRESS BARS -->
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->
{include file='user/footer.tpl'}

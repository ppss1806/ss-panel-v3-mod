{include file='user/main.tpl'}

<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            兑换码
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
            <!-- left column -->
            <div class="col-md-12">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-key"></i>

                        <h3 class="box-title">兑换码键入</h3>
                    </div>
                    <!-- /.box-header --><!-- form start -->

                    <div class="box-body">
                        <div class="form-horizontal">

                            <div id="msg-success" class="alert alert-info alert-dismissable" style="display:none">
                                <button type="button" class="close" data-dismiss="alert"
                                        aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-info"></i> Ok!</h4>

                                <p id="msg-success-p"></p>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">兑换码</label>

                                <div class="col-sm-9">
                                    <input type="text" class="form-control" placeholder="请键入兑换码" id="code">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button type="submit" id="code-update" class="btn btn-primary">兑换</button>
                    </div>

                </div>
                <!-- /.box -->
            </div>
			
			
			
			
			
			<div class="col-xs-12">
				<div class="box">
                    <div class="box-body table-responsive no-padding">
                        {$codes->render()}
                        <table class="table table-hover">
                            <tr>
                                <th>ID</th>
                                <th>代码</th>
                                <th>类型</th>
								<th>数目</th>
								<th>使用时间</th>
								
                            </tr>
                            {foreach $codes as $code}
                                <tr>
                                    <td>#{$code->id}</td>
                                    <td>{$code->code}</td>
                                    <td>{$code->type}</td>
									<td>{$code->number}</td>
									<td>{$code->isused}</td>
									<td>{$code->usedatetime}</td>
                                </tr>
                            {/foreach}
                        </table>
                        {$codes->render()}
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
			
			
			
			
			
			
			
			
			
            </div>
            <!-- /.col (right) -->

        </div>
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

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
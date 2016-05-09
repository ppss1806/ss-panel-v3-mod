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
            <div class="col-xs-12">
                <div id="msg-error" class="alert alert-warning alert-dismissable" style="display:none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-warning"></i> 出错了!</h4>

                    <p id="msg-error-p"></p>
                </div>
                <div id="ss-msg-success" class="alert alert-success alert-dismissable" style="display:none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-info"></i> 成功!</h4>

                    <p id="ss-msg-success-p"></p>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-code"></i>

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
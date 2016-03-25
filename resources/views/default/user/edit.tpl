{include file='user/main.tpl'}

<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            修改资料
            <small>Profile Edit</small>
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
                    <h4><i class="icon fa fa-info"></i> 修改成功!</h4>

                    <p id="ss-msg-success-p"></p>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- left column -->
            <div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-key"></i>

                        <h3 class="box-title">网站登录密码修改</h3>
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
                                <label class="col-sm-3 control-label">当前密码</label>

                                <div class="col-sm-9">
                                    <input type="password" class="form-control" placeholder="当前密码(必填)" id="oldpwd">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">新密码</label>

                                <div class="col-sm-9">
                                    <input type="password" class="form-control" placeholder="新密码" id="pwd">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">确认密码</label>

                                <div class="col-sm-9">
                                    <input type="password" placeholder="确认密码" class="form-control" id="repwd">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button type="submit" id="pwd-update" class="btn btn-primary">修改</button>
                    </div>

                </div>
                <!-- /.box -->
            </div>
			
			
			<div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-weixin"></i>

                        <h3 class="box-title">微信号修改</h3>
                    </div>
                    <!-- /.box-header --><!-- form start -->

                    <div class="box-body">
                        <div class="form-horizontal">

                            <div id="msg-successw" class="alert alert-info alert-dismissable" style="display:none">
                                <button type="button" class="close" data-dismiss="alert"
                                        aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-info"></i> Ok!</h4>

                                <p id="msg-successw-w"></p>
                            </div>
							
							<p>当前微信号：{$user->wechat}</p>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">微信号</label>

                                <div class="col-sm-9">
                                    <input type="text" class="form-control" placeholder="新的微信号，请填写真实的微信号，填写虚假信息可能会导致账号被删除。" id="wechat">
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button type="submit" id="wechat-update" class="btn btn-primary">修改</button>
                    </div>

                </div>
                <!-- /.box -->
            </div>
			
			
			
			<div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-key"></i>

                        <h3 class="box-title">连接密码修改</h3>
                    </div>
                    <!-- /.box-header --><!-- form start -->

                    <div class="box-body">
                        <div class="form-horizontal">

                            <div id="msg-successp" class="alert alert-info alert-dismissable" style="display:none">
                                <button type="button" class="close" data-dismiss="alert"
                                        aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-info"></i> Ok!</h4>

                                <p id="msg-successp-w"></p>
                            </div>
							
							<p>当前连接密码：{$user->passwd}</p>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">连接密码</label>

                                <div class="col-sm-9">
                                    <input type="text" id="sspwd" placeholder="输入新连接密码" class="form-control">
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button type="submit" id="ss-pwd-update" class="btn btn-primary">修改</button>
                    </div>

                </div>
                <!-- /.box -->
            </div>
			
			
			
			<div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-thumb-tack"></i>

                        <h3 class="box-title">加密方式修改</h3>
                    </div>
                    <!-- /.box-header --><!-- form start -->

                    <div class="box-body">
                        <div class="form-horizontal">

                            <div id="msg-successp" class="alert alert-info alert-dismissable" style="display:none">
                                <button type="button" class="close" data-dismiss="alert"
                                        aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-info"></i> Ok!</h4>

                                <p id="msg-successp-w"></p>
                            </div>
							
							<p>当前加密方式：{$user->method}</p>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">加密方式</label>

                                <div class="col-sm-9">
                                    <select id="method" class="form-control">
										<option value="rc4-md5">RC4-MD5</option>
										<option value="aes-128-cfb">AES-128-CFB</option>
										<option value="aes-192-cfb">AES-192-CFB</option>
										<option value="aes-256-cfb">AES-256-CFB</option>
										<option value="camellia-128-cfb">CAMELLIA-128-CFB</option>
										<option value="camellia-192-cfb">CAMELLIA-192-CFB</option>
										<option value="camellia-256-cfb">CAMELLIA-256-CFB</option>
										<option value="cast5-cfb">CAST5-CFB</option>
										<option value="des-cdb">DES-CDB</option>
										<option value="idea-cfb">IDEA-CFB</option>
										<option value="rc2-cfb">RC2-CFB</option>
										<option value="seed-cfb">SEED-CFB</option>
										<option value="salsa20">SALSA20</option>
										<option value="chacha20">CHACHA20</option>
										<option value="chacha20-ietf">CHACHA20-IETF</option>
									</select>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button type="submit" id="method-update" class="btn btn-primary">修改</button>
                    </div>

                </div>
                <!-- /.box -->
            </div>
			
			
			
			
			<div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-envelope-o"></i>

                        <h3 class="box-title">每日邮件接收设置</h3>
                    </div>
                    <!-- /.box-header --><!-- form start -->

                    <div class="box-body">
                        <div class="form-horizontal">

                            <div id="msg-successm" class="alert alert-info alert-dismissable" style="display:none">
                                <button type="button" class="close" data-dismiss="alert"
                                        aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-info"></i> Ok!</h4>

                                <p id="msg-successm-w"></p>
                            </div>
							
							<p>当前设置：{$user->sendDailyMail} (1=发送，0=不发送)</p>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">发送设置</label>

                                <div class="col-sm-9">
                                    <select id="mail" class="form-control">
										<option value="1">发送</option>
										<option value="0">不发送</option>
									</select>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button type="submit" id="mail-update" class="btn btn-primary">修改</button>
                    </div>

                </div>
                <!-- /.box -->
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
        $("#pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "password",
                dataType: "json",
                data: {
                    oldpwd: $("#oldpwd").val(),
                    pwd: $("#pwd").val(),
                    repwd: $("#repwd").val()
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


<script>
    $(document).ready(function () {
        $("#wechat-update").click(function () {
            $.ajax({
                type: "POST",
                url: "wechat",
                dataType: "json",
                data: {
                    wechat: $("#wechat").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-errorw").hide();
                        $("#msg-successw").show();
                        $("#msg-successw-w").html(data.msg);
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

<script>
    $(document).ready(function () {
        $("#ss-pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "sspwd",
                dataType: "json",
                data: {
                    sspwd: $("#sspwd").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#ss-msg-success").show();
                        $("#ss-msg-success-p").html(data.msg);
                    } else {
                        $("#ss-msg-error").show();
                        $("#ss-msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#mail-update").click(function () {
            $.ajax({
                type: "POST",
                url: "mail",
                dataType: "json",
                data: {
                    mail: $("#mail").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#ss-msg-success").show();
                        $("#ss-msg-success-p").html(data.msg);
                    } else {
                        $("#ss-msg-error").show();
                        $("#ss-msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>



<script>
    $(document).ready(function () {
        $("#method-update").click(function () {
            $.ajax({
                type: "POST",
                url: "method",
                dataType: "json",
                data: {
                    method: $("#method").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#ss-msg-success").show();
                        $("#ss-msg-success-p").html(data.msg);
                    } else {
                        $("#ss-msg-error").show();
                        $("#ss-msg-error-p").html(data.msg);
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
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

                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-plus-square"></i>

                        <h3 class="box-title">联络方式修改</h3>
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
							<p>当前联络方式：
                            {if $user->im_type==1}
										微信
										{/if}
										
										{if $user->im_type==2}
										QQ
										{/if}
										
										{if $user->im_type==3}
										Google+
										{/if}
										
										{$user->im_value}</p>
                                        <div class="form-group">
                                        <label class="col-sm-3 control-label">选择您的联络方式</label>
                                        <div class="col-sm-9">
											<select class="form-control" id="imtype">
												<option>选择您的联络方式</option>
												<option value="1">微信</option>
												<option value="2">QQ</option>
												<option value="3">Google+</option>
											</select>
										</div>
                                        </div>
                            <div class="form-group">
                            <label class="col-sm-3 control-label">联络方式账号</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" placeholder="在这输入联络方式账号" id="wechat">
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

                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-paint-brush "></i>

                        <h3 class="box-title">主题修改</h3>
                    </div>
                    <!-- /.box-header --><!-- form start -->

                    <div class="box-body">
                        <div class="form-horizontal">

                            <div id="msg-successt" class="alert alert-info alert-dismissable" style="display:none">
                                <button type="button" class="close" data-dismiss="alert"
                                        aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-info"></i> Ok!</h4>

                                <p id="msg-successt-w"></p>
                            </div>
							
							<p>当前主题：{$user->theme}</p>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">主题</label>

                                <div class="col-sm-9">
                                    <select id="theme" class="form-control">
										{foreach $themes as $theme}
											<option value="{$theme}">{$theme}</option>
										{/foreach}
									</select>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button type="submit" id="theme-update" class="btn btn-primary">修改</button>
                    </div>

                </div>
                <!-- /.box -->
                                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-fire"></i>

                        <h3 class="box-title">IP解封</h3>
                    </div>
                    <!-- /.box-header --><!-- form start -->

                    <div class="box-body">
                        <div class="form-horizontal">
							<div class="col-sm-12">
                               当前状态：{$Block}
                            </div>
                            
							
							<div id="msg-successblo" class="alert alert-info alert-dismissable" style="display:none">
                                <button type="button" class="close" data-dismiss="alert"
                                        aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-info"></i> Ok!</h4>

                                <p id="msg-successblo-w"></p>
                            </div>
                           

                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                         <button type="submit" id="unblock" class="btn btn-primary">解封</button>
                    </div>

                </div>
            </div>
			
			
				<div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-google"></i>

                        <h3 class="box-title">两步验证</h3>
                    </div>
                    <!-- /.box-header --><!-- form start -->

                    <div class="box-body">
                        <div class="form-horizontal">

                            <div class="alert alert-info " >
                                <h4><i class="icon fa fa-info"></i>请下载 Google 的两步验证器，扫描下面的二维码。
								<p><i class="fa fa-android" aria-hidden="true"></i><a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2">Android</a></p>
								<p><i class="fa fa-apple" aria-hidden="true"></i><a href="https://itunes.apple.com/cn/app/google-authenticator/id388497605?mt=8">iOS</a></p>
								<p>在没有测试完成绑定成功之前请不要启用。</p></h4>
								
                            </div>
							
							<p>当前设置：{if $user->ga_enable==1} 登陆时要求验证 {else} 不要求 {/if}</p>
							<p>当前服务器时间：{date("Y-m-d H:i:s")}</p>
							
							<div id="msg-successc" class="alert alert-info alert-dismissable" style="display:none">
                                <button type="button" class="close" data-dismiss="alert"
                                        aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-info"></i> Ok!</h4>

                                <p id="msg-successc-w"></p>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">验证设置</label>

                                <div class="col-sm-9">
                                    <select id="ga-enable" class="form-control">
										<option value="1">要求验证</option>
										<option value="0">不要求</option>
									</select>
                                </div>
								
								
								<div class="col-sm-12">
									<div class="text-center">
										<div id="ga-qr"></div>
										密钥：{$user->ga_token}
									</div>
                                </div>
								
								<label class="col-sm-3 control-label">测试一下</label>

                                <div class="col-sm-9">
                                    <input type="text" id="code" placeholder="输入验证器生成的数字来测试" class="form-control">
                                </div>
								
								
                            </div>

                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <a class="btn btn-primary" href="/user/gareset">重置</a> <button type="submit" id="ga-test" class="btn btn-primary">测试</button> <button type="submit" id="ga-set" class="btn btn-primary">设置</button>
                    </div>

                </div>
                <!-- /.box -->
				

                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-fire"></i>

                        <h3 class="box-title">重置端口</h3>
                    </div>
                    <!-- /.box-header --><!-- form start -->

                    <div class="box-body">
                        <div class="form-horizontal">
							<div class="col-sm-12">
                                当前端口：{$user->port}
                            </div>
                            
							
							<div id="msg-successpo" class="alert alert-info alert-dismissable" style="display:none">
                                <button type="button" class="close" data-dismiss="alert"
                                        aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-info"></i> Ok!</h4>

                                <p id="msg-successpo-w"></p>
                            </div>
                           

                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                         <button type="submit" id="portreset" class="btn btn-primary">重置端口</button>
                    </div>

                </div>
                <!-- /.box -->
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-key"></i>
                        <h3 class="box-title">自定义PAC/Surge</h3>
                    </div>
                    <!-- /.box-header --><!-- form start -->

                    <div class="box-body">
                        <div class="form-horizontal">
                            <div id="msg-successpac" class="alert alert-info alert-dismissable" style="display:none">
                                <button type="button" class="close" data-dismiss="alert"
                                        aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-info"></i> Ok!</h4>

                                <p id="msg-successpac-w"></p>
                            </div>
                            <p>参看<a href="https://adblockplus.org/zh_CN/filters">https://adblockplus.org/zh_CN/filters</a></p>
                            <div class="form-group form-group-label">
                                <div class="col-sm-9">
                                    <textarea class="form-control" id="pac" placeholder="自定义PAC/Surge规则" rows="8">{$user->pac}</textarea>
                                </div>
							</div>

                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button type="submit" id="setpac" class="btn btn-primary">设置</button>
                    </div>

                </div>
                <!-- /.box -->

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
							
							<p>当前设置：{if $user->sendDailyMail==1} 发送 {else} 不发送 {/if}</p>

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
        $("#portreset").click(function () {
            $.ajax({
                type: "POST",
                url: "resetport",
                dataType: "json",
                data: {
                   
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide();
                        $("#msg-successpo").show();
                        $("#msg-successpo-w").html(data.msg);
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
        $("#setpac").click(function () {
            $.ajax({
                type: "POST",
                url: "pacset",
                dataType: "json",
                data: {
                   pac: $("#pac").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide();
                        $("#msg-successpac").show();
                        $("#msg-successpac-w").html(data.msg);
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
        $("#unblock").click(function () {
            $.ajax({
                type: "POST",
                url: "unblock",
                dataType: "json",
                data: {
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide();
                        $("#msg-successblo").show();
                        $("#msg-successblo-w").html(data.msg);
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

<script src=" /assets/public/js/jquery.qrcode.min.js "></script>
<script>
	var ga_qrcode = '{$user->getGAurl()}';
	jQuery('#ga-qr').qrcode({
		"text": ga_qrcode
	});
</script>


<script>
    $(document).ready(function () {
        $("#wechat-update").click(function () {
            $.ajax({
                type: "POST",
                url: "wechat",
                dataType: "json",
                data: {
                    wechat: $("#wechat").val(),
					imtype: $("#imtype").val()
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
        $("#ga-test").click(function () {
            $.ajax({
                type: "POST",
                url: "gacheck",
                dataType: "json",
                data: {
                    code: $("#code").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-errorc").hide();
                        $("#msg-successc").show();
                        $("#msg-successc-w").html(data.msg);
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
        $("#ga-set").click(function () {
            $.ajax({
                type: "POST",
                url: "gaset",
                dataType: "json",
                data: {
                    enable: $("#ga-enable").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-errorc").hide();
                        $("#msg-successc").show();
                        $("#msg-successc-w").html(data.msg);
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
        $("#theme-update").click(function () {
            $.ajax({
                type: "POST",
                url: "theme",
                dataType: "json",
                data: {
                    theme: $("#theme").val()
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
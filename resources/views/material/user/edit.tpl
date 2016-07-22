
			
			
{include file='user/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">修改资料</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				
				
					<div class="col-lg-6 col-md-6">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">修改密码</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="oldpwd">当前密码</label>
											<input class="form-control" id="oldpwd" type="password">
										</div>
										
										<div class="form-group form-group-label">
											<label class="floating-label" for="pwd">新密码</label>
											<input class="form-control" id="pwd" type="password">
										</div>
										
										<div class="form-group form-group-label">
											<label class="floating-label" for="repwd">确认新密码</label>
											<input class="form-control" id="repwd" type="password">
										</div>
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="pwd-update" ><span class="icon">check</span>&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">连接密码修改</p>
										<p>当前连接密码：{$user->passwd}</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="sspwd">连接密码</label>
											<input class="form-control" id="sspwd" type="text">
										</div>
										
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="ss-pwd-update" ><span class="icon">check</span>&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">加密方式修改</p>
										<p>当前加密方式：{$user->method}</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="method">加密方式</label>
											<select id="method" class="form-control">
												<option value="rc4-md5">RC4-MD5</option>
												<option value="rc4-md5-6">RC4-MD5-6</option>
												<option value="aes-128-cfb">AES-128-CFB</option>
												<option value="aes-192-cfb">AES-192-CFB</option>
												<option value="aes-256-cfb">AES-256-CFB</option>
												<option value="aes-128-ctr">AES-128-CTR</option>
												<option value="aes-192-ctr">AES-192-CTR</option>
												<option value="aes-256-ctr">AES-256-CTR</option>
												<option value="camellia-128-cfb">CAMELLIA-128-CFB</option>
												<option value="camellia-192-cfb">CAMELLIA-192-CFB</option>
												<option value="camellia-256-cfb">CAMELLIA-256-CFB</option>
												<option value="bf-cfb">BF-CFB</option>
												<option value="cast5-cfb">CAST5-CFB</option>
												<option value="des-cfb">DES-CFB</option>
												<option value="des-cfb">DES-EDE3-CFB</option>
												<option value="idea-cfb">IDEA-CFB</option>
												<option value="rc2-cfb">RC2-CFB</option>
												<option value="seed-cfb">SEED-CFB</option>
												<option value="salsa20">SALSA20</option>
												<option value="chacha20">CHACHA20</option>
												<option value="chacha20-ietf">CHACHA20-IETF</option>
											</select>
										</div>
										
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="method-update" ><span class="icon">check</span>&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">联络方式修改</p>
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
										<div class="form-group form-group-label">
											<label class="floating-label" for="imtype">选择您的联络方式</label>
											<select class="form-control" id="imtype">
												<option></option>
												<option value="1">微信</option>
												<option value="2">QQ</option>
												<option value="3">Google+</option>
											</select>
										</div>
											
										<div class="form-group form-group-label">
											<label class="floating-label" for="wechat">在这输入联络方式账号</label>
											<input class="form-control" id="wechat" type="text">
										</div>
										
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="wechat-update" ><span class="icon">check</span>&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					
						
						
						{if $config['enable_rss']=='true'}
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">RSS 协议&混淆设置</p>
										<p>当前协议：{$user->protocol}</p>
										<p>注意：如果需要在手机使用SS请选择带_compatible的兼容选项！</p>
										<p>当前协议参数：{$user->protocol_param}</p>
										<p>注意：参数请放空，除非你看得懂<a href="https://github.com/breakwa11/shadowsocks-rss/blob/master/ssr.md">这里</a>！</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="protocol">协议</label>
											<select id="protocol" class="form-control">
												<option value="origin">origin</option>
												<option value="verify_simple">verify_simple</option>
												<option value="verify_deflate">verify_deflate</option>
												<option value="verify_sha1">verify_sha1</option>
												<option value="verify_sha1_compatible">verify_sha1_compatible</option>
												<option value="auth_simple">auth_simple</option>
												<option value="auth_sha1">auth_sha1</option>
												<option value="auth_sha1_compatible"> auth_sha1_compatible</option>
												<option value="auth_sha1_v2">auth_sha1_v2</option>
												<option value="auth_sha1_v2_compatible">auth_sha1_v2_compatible</option>
											</select>
										</div>
										
										<div class="form-group form-group-label">
											<label class="floating-label" for="protocol_param">协议参数</label>
											<input class="form-control" id="protocol_param" type="text">
										</div>
									</div>
									
									<div class="card-inner">
										<p>当前混淆方式：{$user->obfs}</p>
										<p>注意：如果需要在手机使用SS请选择带_compatible的兼容选项！</p>
										<p>当前混淆参数：{$user->obfs_param}</p>
										<p>注意：参数请放空，除非你看得懂<a href="https://github.com/breakwa11/shadowsocks-rss/blob/master/ssr.md">这里</a>！</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="obfs">混淆方式</label>
											<select id="obfs" class="form-control">
												<option value="plain">plain</option>
												<option value="http_simple">http_simple</option>
												<option value="http_simple_compatible"> http_simple_compatible</option>
												<option value="tls_simple">tls_simple</option>
												<option value="tls_simple_compatible">tls_simple_compatible</option>
												<option value="random_head">random_head</option>
												<option value="random_head_compatible">random_head_compatible</option>
												<option value="tls1.0_session_auth">tls1.0_session_auth</option>
												<option value="tls1.0_session_auth_compatible">tls1.0_session_auth_compatible</option>
												<option value="tls1.2_ticket_auth">tls1.2_ticket_auth</option>
												<option value="tls1.2_ticket_auth_compatible">tls1.2_ticket_auth_compatible</option>
											</select>
										</div>
										
										<div class="form-group form-group-label">
											<label class="floating-label" for="obfs_param">混淆参数</label>
											<input class="form-control" id="obfs_param" type="text">
										</div>
									</div>
									
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="rss-update" ><span class="icon">check</span>&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						{/if}
						
						
						
						
						
					
					
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">主题修改</p>
										<p>当前主题：{$user->theme}</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="theme">主题</label>
											<select id="theme" class="form-control">
												{foreach $themes as $theme}
													<option value="{$theme}">{$theme}</option>
												{/foreach}
											</select>
										</div>
										
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="theme-update" ><span class="icon">check</span>&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					
					<div class="col-lg-6 col-md-6">
						
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">IP解封</p>
										<p>当前状态：{$Block}</p>
										
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="unblock" ><span class="icon">check</span>&nbsp;解封</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					
					
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">每日邮件接收设置</p>
										<p>当前设置：{if $user->sendDailyMail==1} 发送 {else} 不发送 {/if}</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="mail">发送设置</label>
											<select id="mail" class="form-control">
												<option value="1">发送</option>
												<option value="0">不发送</option>
											</select>
										</div>
										
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="mail-update" ><span class="icon">check</span>&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					
					
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">两步验证</p>
										<p>请下载 Google 的两步验证器，扫描下面的二维码。</p>
										<p><i class="icon icon-lg" aria-hidden="true">android</i><a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2">&nbsp;Android</a></p>
										<p><i class="icon icon-lg" aria-hidden="true">tablet_mac</i><a href="https://itunes.apple.com/cn/app/google-authenticator/id388497605?mt=8">&nbsp;iOS</a></p>
										<p>在没有测试完成绑定成功之前请不要启用。</p>
										<p>当前设置：{if $user->ga_enable==1} 登录时要求验证 {else} 不要求 {/if}</p>
										<p>当前服务器时间：{date("Y-m-d H:i:s")}</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="ga-enable">验证设置</label>
											<select id="ga-enable" class="form-control">
												<option value="0">不要求</option>
												<option value="1">要求验证</option>
											</select>
										</div>
										
										
										<div class="form-group form-group-label">
											<div class="text-center">
												<div id="ga-qr"></div>
												密钥：{$user->ga_token}
											</div>
										</div>
										
										
										<div class="form-group form-group-label">
											<label class="floating-label" for="code">测试一下</label>
											<input type="text" id="code" placeholder="输入验证器生成的数字来测试" class="form-control">
										</div>
										
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<a class="btn btn-brand-accent btn-flat waves-attach" href="/user/gareset" ><span class="icon">format_color_reset</span>&nbsp;重置</a>
											<button class="btn btn-flat waves-attach" id="ga-test" ><span class="icon">extension</span>&nbsp;测试</button>
											<button class="btn btn-brand btn-flat waves-attach" id="ga-set" ><span class="icon">perm_data_setting</span>&nbsp;设置</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">重置端口</p>
										<p>当前端口：{$user->port}</p>
										
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="portreset" ><span class="icon">check</span>&nbsp;重置端口</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">自定义PAC/Surge</p>
										<p>参看<a href="https://adblockplus.org/zh_CN/filters">https://adblockplus.org/zh_CN/filters</a></p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="pac">自定义PAC/Surge规则</label>
											<textarea class="form-control" id="pac" rows="8">{$user->pac}</textarea>
										</div>
										
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="setpac" ><span class="icon">check</span>&nbsp;设置</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					
					
					{include file='dialog.tpl'}
				
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}


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
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
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
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
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
                         $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
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
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>

{if $config['enable_rss']=='true'}
<script>
    $(document).ready(function () {
        $("#rss-update").click(function () {
            $.ajax({
                type: "POST",
                url: "rss",
                dataType: "json",
                data: {
                    protocol: $("#protocol").val(),
					protocol_param: $("#protocol_param").val(),
					obfs: $("#obfs").val(),
					obfs_param: $("#obfs_param").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>
{/if}


<script>
    $(document).ready(function () {
        $("#relay-update").click(function () {
            $.ajax({
                type: "POST",
                url: "relay",
                dataType: "json",
                data: {
                    relay_enable: $("#relay_enable").val(),
					relay_info: $("#relay_info").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
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
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
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
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
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
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
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
                        $("#result").modal();
						$("#msg").html("成功了");
                    } else {
                        $("#result").modal();
						$("#msg").html("失败了");
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
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
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
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
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
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
                        $("#result").modal();
						$("#msg").html("成功了");
                    } else {
                        $("#result").modal();
						$("#msg").html("失败了");
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>


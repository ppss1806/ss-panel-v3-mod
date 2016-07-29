<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta content="IE=edge" http-equiv="X-UA-Compatible">
	<meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
	<meta name="theme-color" content="#f44336">
	<title>{$config["appName"]}</title>

	
	
	<!-- css -->
	<link href="/theme/material/css/base.min.css" rel="stylesheet">
	<link href="/theme/material/css/project.min.css" rel="stylesheet">
	<link href="https://fonts.lug.ustc.edu.cn/icon?family=Material+Icons" rel="stylesheet">
	

	
	<!-- favicon -->
	<!-- ... -->
	<style>
		.pagination {
			display:inline-block;
			padding-left:0;
			margin:20px 0;
			border-radius:4px
		}
		.pagination>li {
			display:inline
		}
		.pagination>li>a,.pagination>li>span {
			position:relative;
			float:left;
			padding:6px 12px;
			margin-left:-1px;
			line-height:1.42857143;
			color:#337ab7;
			text-decoration:none;
			background-color:#fff;
			border:1px solid #ddd
		}
		.pagination>li:first-child>a,.pagination>li:first-child>span {
			margin-left:0;
			border-top-left-radius:4px;
			border-bottom-left-radius:4px
		}
		.pagination>li:last-child>a,.pagination>li:last-child>span {
			border-top-right-radius:4px;
			border-bottom-right-radius:4px
		}
		.pagination>li>a:focus,.pagination>li>a:hover,.pagination>li>span:focus,.pagination>li>span:hover {
			color:#23527c;
			background-color:#eee;
			border-color:#ddd
		}
		.pagination>.active>a,.pagination>.active>a:focus,.pagination>.active>a:hover,.pagination>.active>span,.pagination>.active>span:focus,.pagination>.active>span:hover {
			z-index:2;
			color:#fff;
			cursor:default;
			background-color:#337ab7;
			border-color:#337ab7
		}
		.pagination>.disabled>a,.pagination>.disabled>a:focus,.pagination>.disabled>a:hover,.pagination>.disabled>span,.pagination>.disabled>span:focus,.pagination>.disabled>span:hover {
			color:#777;
			cursor:not-allowed;
			background-color:#fff;
			border-color:#ddd
		}
		.pagination-lg>li>a,.pagination-lg>li>span {
			padding:10px 16px;
			font-size:18px
		}
		.pagination-lg>li:first-child>a,.pagination-lg>li:first-child>span {
			border-top-left-radius:6px;
			border-bottom-left-radius:6px
		}
		.pagination-lg>li:last-child>a,.pagination-lg>li:last-child>span {
			border-top-right-radius:6px;
			border-bottom-right-radius:6px
		}
		.pagination-sm>li>a,.pagination-sm>li>span {
			padding:5px 10px;
			font-size:12px
		}
		.pagination-sm>li:first-child>a,.pagination-sm>li:first-child>span {
			border-top-left-radius:3px;
			border-bottom-left-radius:3px
		}
		.pagination-sm>li:last-child>a,.pagination-sm>li:last-child>span {
			border-top-right-radius:3px;
			border-bottom-right-radius:3px
		}
		.pager {
			padding-left:0;
			margin:20px 0;
			text-align:center;
			list-style:none
		}
		.pager li {
			display:inline
		}
		.pager li>a,.pager li>span {
			display:inline-block;
			padding:5px 14px;
			background-color:#fff;
			border:1px solid #ddd;
			border-radius:15px
		}
		.pager li>a:focus,.pager li>a:hover {
			text-decoration:none;
			background-color:#eee
		}
		.pager .next>a,.pager .next>span {
			float:right
		}
		.pager .previous>a,.pager .previous>span {
			float:left
		}
		.pager .disabled>a,.pager .disabled>a:focus,.pager .disabled>a:hover,.pager .disabled>span {
			color:#777;
			cursor:not-allowed;
			background-color:#fff
		}

		
		
		
		
		.pagination>li>a,
		.pagination>li>span {
		  border: 1px solid white;
		}
		.pagination>li.active>a {
		  background: #f50057;
		  color: #fff;
		}
		
		.pagination>li>a {
		  background: white;
		  color: #000;
		}
		
		
		.pagination > .active > a, .pagination > .active > a:focus, .pagination > .active > a:hover, .pagination > .active > span, .pagination > .active > span:focus, .pagination > .active > span:hover {
			color: #fff;
			background-color: #000;
			border-color: #000;
		}

		.pagination>.active>span {
		  background-color: #f50057;
		  color: #fff;
		  border-color: #fff;
		}
		
		
		
		.pagination > .disabled > span {
		  border-color: #fff;
		}
		
		
		pre {
			white-space: pre-wrap;
			word-wrap: break-word;
		}
		
		.page-red .ui-content-header {
			background-image: url(/theme/material/css/images/bg/red.jpg);
		}
		
		.content-heading {
			font-weight: 300;
			color: #fff;
		}
	</style>
</head>
<body class="page-red">
	<header class="header header-red header-transparent header-waterfall ui-header">
		<ul class="nav nav-list pull-left">
			<div>
				<a data-toggle="menu" href="#ui_menu">
					<span class="icon icon-lg">menu</span>
				</a>
			</div>
		</ul>
		
		<ul class="nav nav-list pull-right">
			<div class="dropdown margin-right">
				<a class="dropdown-toggle padding-left-no padding-right-no" data-toggle="dropdown">
				{if $user->isLogin}
					<span class="access-hide">{$user->user_name}</span>
					<span class="avatar avatar-sm"><img alt="alt text for John Smith avatar" src="{$user->gravatar}"></span>
					</a>
					<ul class="dropdown-menu dropdown-menu-right">
						<li>
							<a class="padding-right-lg waves-attach" href="/user/"><span class="icon icon-lg margin-right">account_box</span>用户中心</a>
						</li>
						<li>
							<a class="padding-right-lg waves-attach" href="/user/logout"><span class="icon icon-lg margin-right">exit_to_app</span>登出</a>
						</li>
					</ul>
				{else}
					<span class="access-hide">未登录</span>
					<span class="avatar avatar-sm"><img alt="alt text for John Smith avatar" src="/theme/material/images/users/avatar-001.jpg"></span>
					</a>
					<ul class="dropdown-menu dropdown-menu-right">
						<li>
							<a class="padding-right-lg waves-attach" href="/auth/login"><span class="icon icon-lg margin-right">account_box</span>登录</a>
						</li>
						<li>
							<a class="padding-right-lg waves-attach" href="/auth/register"><span class="icon icon-lg margin-right">pregnant_woman</span>注册</a>
						</li>
					</ul>
				{/if}
					
			</div>
		</ul>
	</header>
	<nav aria-hidden="true" class="menu menu-left nav-drawer nav-drawer-md" id="ui_menu" tabindex="-1">
		<div class="menu-scroll">
			<div class="menu-content">
				<a class="menu-logo" href="/"><i class="icon icon-lg">person_pin</i>&nbsp;管理面板</a>
				<ul class="nav">
					<li>
						<a class="waves-attach" data-toggle="collapse" href="#ui_menu_me">我的</a>
						<ul class="menu-collapse collapse in" id="ui_menu_me">
							<li><a href="/admin"><i class="icon icon-lg">business_center</i>&nbsp;系统概览</a></li>
							<li><a href="/admin/announcement"><i class="icon icon-lg">announcement</i>&nbsp;公告管理</a></li>
							<li><a href="/admin/ticket"><i class="icon icon-lg">question_answer</i>&nbsp;工单管理</a></li>
							<li><a href="/admin/auto"><i class="icon icon-lg">flash_auto</i>&nbsp;下发命令</a></li>
						</ul>
						
						<a class="waves-attach" data-toggle="collapse" href="#ui_menu_node">节点</a>
						<ul class="menu-collapse collapse in" id="ui_menu_node">
							<li><a href="/admin/node"><i class="icon icon-lg">router</i>&nbsp;节点列表</a></li>
							<li><a href="/admin/trafficlog"><i class="icon icon-lg">traffic</i>&nbsp;流量记录</a></li>
							<li><a href="/admin/alive"><i class="icon icon-lg">dialer_sip</i>&nbsp;在线IP</a></li>
							<li><a href="/admin/block"><i class="icon icon-lg">dialer_sip</i>&nbsp;已封禁IP</a></li>
							<li><a href="/admin/unblock"><i class="icon icon-lg">dialer_sip</i>&nbsp;已解封IP</a></li>
						</ul>
						
						<a class="waves-attach" data-toggle="collapse" href="#ui_menu_user">用户</a>
						<ul class="menu-collapse collapse in" id="ui_menu_user">
							<li><a href="/admin/user"><i class="icon icon-lg">supervisor_account</i>&nbsp;用户列表</a></li>
							<li><a href="/admin/invite"><i class="icon icon-lg">loyalty</i>&nbsp;邀请与返利</a></li>
							<li><a href="/admin/login"><i class="icon icon-lg">text_fields</i>&nbsp;登录记录</a></li>
						</ul>
						
						
						<a class="waves-attach" data-toggle="collapse" href="#ui_menu_trade">交易</a>
						<ul class="menu-collapse collapse in" id="ui_menu_trade">
							<li><a href="/admin/code"><i class="icon icon-lg">code</i>&nbsp;充值码{if $config['enable_donate']=='true'}与捐赠{/if}</a></li>
							<li><a href="/admin/shop"><i class="icon icon-lg">shop</i>&nbsp;商品</a></li>
							<li><a href="/admin/coupon"><i class="icon icon-lg">card_giftcard</i>&nbsp;优惠码</a></li>
							<li><a href="/admin/bought"><i class="icon icon-lg">shopping_cart</i>&nbsp;购买记录</a></li>
						</ul>
						
						<li><a href="/user"><i class="icon icon-lg">person</i>&nbsp;用户中心</a></li>
					</li>
				
					
					
				</ul>
			</div>
		</div>
	</nav>
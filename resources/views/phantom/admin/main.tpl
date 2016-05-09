<!DOCTYPE HTML>
<!--
	Phantom by HTML5 UP
	html5up.net | @n33co
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>{$config["appName"]}</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="/theme/phantom/assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="/theme/phantom/assets/css/main.css" />
		<!-- Bootstrap 3.3.2 -->
		
		<!-- jQuery 2.1.3 -->
		<script src="/assets/public/js/jquery.min.js"></script>
		<link href="/assets/public/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
		<script src="/assets/public/js/bootstrap.min.js"></script>
		<!--[if lte IE 9]><link rel="stylesheet" href="/theme/phantom/assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="/theme/phantom/assets/css/ie8.css" /><![endif]-->
	</head>
	<style>
		
		
		.pagination>li>a,
		.pagination>li>span {
		  border: 1px solid white;
		}
		.pagination>li.active>a {
		  background: black;
		  color: #fff;
		}
		
		.pagination>li>a {
		  background: white;
		  color: #000;
		}
		
		.pagination>.active>span {
		  background: black;
		  color: #fff;
		}
		
		.pagination>.sdisable>span {
		  border-color: #fff;
		}
		
		pre {
			white-space: pre-wrap;
			word-wrap: break-word;
		}
	</style>
	<body>
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<div class="inner">
								<!-- Logo -->
								<a href="/admin" class="logo">
									<span class="title">{$config["appName"]}</span>
								</a>



							<!-- Nav -->
								<nav>
									<ul>
										<li><a href="#menu">Admin Menu</a></li>
									</ul>
								</nav>

						</div>
					</header>

				<!-- Menu -->
					<nav id="menu">
						<h2>Admin Menu</h2>
						<h3>{$user->user_name}</h3>
						<ul>
							<li><a href="/admin">管理中心</a></li>
							<li><a href="/admin/node">节点管理</a></li>
							<li><a href="/admin/announcement">公告管理</a></li>
							<li><a href="/admin/code">兑换码管理</a></li>
							<li><a href="/admin/user">用户管理</a></li>
							<li><a href="/admin/invite">邀请管理</a></li>
							<li><a href="/admin/trafficlog">流量记录</a></li>
							<li><a href="/admin/alive">在线IP</a></li>
							<li><a href="/admin/login">登陆记录</a></li>
							<li><a href="/user">用户中心</a></li>
							<li><a href="/user/logout">退出</a></li>

						</ul>
					</nav>



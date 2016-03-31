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
		<!--[if lte IE 8]><script src="/assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="/assets/css/main.css" />
		<!-- Bootstrap 3.3.2 -->
		
		<!-- jQuery 2.1.3 -->
		<script src="/assets/public/js/jquery.min.js"></script>
		<link href="/assets/public/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
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
								<a href="/user" class="logo">
									<span class="title">{$config["appName"]}</span>
								</a>



							<!-- Nav -->
								<nav>
									<ul>
										<li><a href="#menu">User Menu</a></li>
									</ul>
								</nav>

						</div>
					</header>

				<!-- Menu -->
					<nav id="menu">
						<h2>User Menu</h2>
						<h3>{$user->user_name}</h3>
						<ul>
							<li><a href="/user">用户中心</a></li>
							<li><a href="/user/node">节点列表</a></li>
							<li><a href="/user/profile">我的信息</a></li>
							<li><a href="/user/trafficlog">流量记录</a></li>
							<li><a href="/user/code">兑换码</a></li>
							<li><a href="/user/edit">修改资料</a></li>
							<li><a href="/user/invite">邀请好友</a></li>
							{if $user->isAdmin()}
							<li><a href="/admin">管理面板</a></li>
							{/if}
							<li><a href="/user/logout">退出</a></li>

						</ul>
					</nav>




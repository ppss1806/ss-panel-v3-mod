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
		<!--[if lte IE 9]><link rel="stylesheet" href="/assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="/assets/css/ie8.css" /><![endif]-->
	</head>
	<style>
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
								<a href="/" class="logo">
									<span class="title">{$config["appName"]}</span>
								</a>



							<!-- Nav -->
								<nav>
									<ul>
										<li><a href="#menu">Menu</a></li>
									</ul>
								</nav>

						</div>
					</header>

				<!-- Menu -->
					<nav id="menu">
						<h2>Menu</h2>
						<ul>
							<li><a href="/">首页</a></li>
							<li><a href="/code">邀请码</a></li>
							{if $user->isLogin}
								<li><a href="/user">用户中心</a></li>
								<li><a href="/user/logout">退出</a></li>
							{else}
								<li><a href="/auth/login">登录</a></li>
								<li><a href="/auth/register">注册</a></li>
							{/if}
						</ul>
					</nav>
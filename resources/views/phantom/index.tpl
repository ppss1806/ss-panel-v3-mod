{include file='header.tpl'}


					<div id="main">
						<div class="inner">
							<header>
								<h1>{$config["appName"]}</h1>
							<p>通向远方</p>
							</header>
							<section class="tiles">
							{if $user->isLogin}
								<article class="style1">
									<span class="image">
										<img src="/theme/phantom/images/pic01.jpg" alt="" />
									</span>
									<a href="/user">
										<h2>用户中心</h2>
									</a>
								</article>
							{else}
								<article class="style1">
									<span class="image">
										<img src="/theme/phantom/images/pic01.jpg" alt="" />
									</span>
									<a href="/auth/register">
										<h2>注册</h2>
									</a>
								</article>
							{/if}
							<article class="style2">
									<span class="image">
										<img src="/theme/phantom/images/pic02.jpg" alt="" />
									</span>
									<a href="/tos">
										<h2>TOS</h2>
										
									</a>
								</article>
								<article class="style3">
									<span class="image">
										<img src="/theme/phantom/images/pic03.png" alt="" />
									</span>
									<a href="/auth/login">
										<h2>登录</h2>
										
									</a>
								</article>
							</section>
						</div>
					</div>


{include file='footer.tpl'}
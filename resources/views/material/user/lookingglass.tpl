





{include file='user/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">观察窗</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="ui-card-wrap">
					<div class="row">
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">注意!</p>
										<p>此处只展示最近{$hour}小时的记录.</p>
									</div>
									
								</div>
							</div>
						</div>
						
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										
										<div id="traffic_chart" style="height: 300px; width: 100%;"></div>
										
										<script src="//cdn.bootcss.com/canvasjs/1.7.0/canvasjs.js"></script>
										<script type="text/javascript">
											var chart = new CanvasJS.Chart("traffic_chart",
											{
											  title:{
												text: "延时测试"    
											  },
											  animationEnabled: true,
											  axisY: {				
												suffix: " ms",
												maximum: 1000
												},
											  legend: {
												verticalAlign: "bottom",
												horizontalAlign: "center"
											  },
											  toolTip: {
												shared: true
											},	
											theme: "theme2",
											  data: [

											{
												type: "column",	
												name: "电信",
												legendText: "电信",
												showInLegend: true, 
												dataPoints:[
													{$i=0}
													{foreach $speedtests as $single_speedtest}
														{if $i==0}
															{literal}
															{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getTelecomPing()}
															{literal}
															}
															{/literal}
															{$i=1}
														{else}
															{literal}
															,{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getTelecomPing()}
															{literal}
															}
															{/literal}
														{/if}
													{/foreach}
												
												


												]
											},
											{
												type: "column",	
												name: "联通",
												legendText: "联通",
												
												showInLegend: true,
												dataPoints:[
													{$i=0}
													{foreach $speedtests as $single_speedtest}
														{if $i==0}
															{literal}
															{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getUnicomPing()}
															{literal}
															}
															{/literal}
															{$i=1}
														{else}
															{literal}
															,{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getUnicomPing()}
															{literal}
															}
															{/literal}
														{/if}
													{/foreach}


												]
											},
											{
												type: "column",	
												name: "移动",
												legendText: "移动",
												
												showInLegend: true,
												dataPoints:[
													{$i=0}
													{foreach $speedtests as $single_speedtest}
														{if $i==0}
															{literal}
															{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getCmccPing()}
															{literal}
															}
															{/literal}
															{$i=1}
														{else}
															{literal}
															,{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getCmccPing()}
															{literal}
															}
															{/literal}
														{/if}
													{/foreach}


												]
											}   
											  ]
											});

											chart.render();
										</script>
										
										
									</div>
									
								</div>
							</div>
							
							
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										
										<div id="speed_chart" style="height: 300px; width: 100%;"></div>
										
										<script src="//cdn.bootcss.com/canvasjs/1.7.0/canvasjs.js"></script>
										<script type="text/javascript">
											var speed_chart = new CanvasJS.Chart("speed_chart",
											{
											  title:{
												text: "速度测试"    
											  },
											  animationEnabled: true,
											  axisY: {				
												suffix: " Mbps"
												},
											  legend: {
												verticalAlign: "bottom",
												horizontalAlign: "center"
											  },
											  toolTip: {
												shared: true
											},	
											theme: "theme2",
											  data: [

											{
												type: "column",	
												name: "电信下载",
												legendText: "电信下载",
												showInLegend: true, 
												dataPoints:[
													{$i=0}
													{foreach $speedtests as $single_speedtest}
														{if $i==0}
															{literal}
															{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getTelecomUpload()}
															{literal}
															}
															{/literal}
															{$i=1}
														{else}
															{literal}
															,{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getTelecomUpload()}
															{literal}
															}
															{/literal}
														{/if}
													{/foreach}
												
												


												]
											},
											{
												type: "column",	
												name: "电信上传",
												legendText: "电信上传",
												showInLegend: true, 
												dataPoints:[
													{$i=0}
													{foreach $speedtests as $single_speedtest}
														{if $i==0}
															{literal}
															{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getTelecomDownload()}
															{literal}
															}
															{/literal}
															{$i=1}
														{else}
															{literal}
															,{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getTelecomDownload()}
															{literal}
															}
															{/literal}
														{/if}
													{/foreach}
												
												


												]
											},
											{
												type: "column",	
												name: "联通下载",
												legendText: "联通下载",
												
												showInLegend: true,
												dataPoints:[
													{$i=0}
													{foreach $speedtests as $single_speedtest}
														{if $i==0}
															{literal}
															{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getUnicomUpload()}
															{literal}
															}
															{/literal}
															{$i=1}
														{else}
															{literal}
															,{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getUnicomUpload()}
															{literal}
															}
															{/literal}
														{/if}
													{/foreach}


												]
											},
											{
												type: "column",	
												name: "联通上传",
												legendText: "联通上传",
												
												showInLegend: true,
												dataPoints:[
													{$i=0}
													{foreach $speedtests as $single_speedtest}
														{if $i==0}
															{literal}
															{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getUnicomDownload()}
															{literal}
															}
															{/literal}
															{$i=1}
														{else}
															{literal}
															,{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getUnicomDownload()}
															{literal}
															}
															{/literal}
														{/if}
													{/foreach}


												]
											},
											{
												type: "column",	
												name: "移动下载",
												legendText: "移动下载",
												
												showInLegend: true,
												dataPoints:[
													{$i=0}
													{foreach $speedtests as $single_speedtest}
														{if $i==0}
															{literal}
															{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getCmccUpload()}
															{literal}
															}
															{/literal}
															{$i=1}
														{else}
															{literal}
															,{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getCmccUpload()}
															{literal}
															}
															{/literal}
														{/if}
													{/foreach}


												]
											},
											{
												type: "column",	
												name: "移动上传",
												legendText: "移动上传",
												
												showInLegend: true,
												dataPoints:[
													{$i=0}
													{foreach $speedtests as $single_speedtest}
														{if $i==0}
															{literal}
															{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getCmccDownload()}
															{literal}
															}
															{/literal}
															{$i=1}
														{else}
															{literal}
															,{
															{/literal}
																label: "{$single_speedtest->node()->name}", y: {$single_speedtest->getCmccDownload()}
															{literal}
															}
															{/literal}
														{/if}
													{/foreach}


												]
											}   
											  ]
											});

											speed_chart.render();
										</script>
										
										
									</div>
									
								</div>
							</div>
						</div>
						
						
					</div>
				</div>
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}
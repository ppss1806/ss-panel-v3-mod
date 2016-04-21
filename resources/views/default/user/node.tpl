{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            节点列表
            <small>Node List</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- START PROGRESS BARS -->
        <div class="row">
            <div class="col-md-12">
                <div class="callout callout-warning">
                    <h4>注意!</h4>
                    <p>请勿在任何地方公开节点地址！</p>
                    <p>流量比例为0.5即使用1000MB按照500MB流量记录记录结算.</p>
					<p>菜单分两级，点击某个节点名称展开这个节点的方式后，可以点击这个方式查看具体的配置信息。</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-info">
                    <div class="box-header">
                        <i class="fa fa-th-list"></i>

                        <h3 class="box-title">节点</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
						<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
						{foreach $node_prefix as $prefix => $nodes}
						  <div class="panel panel-default">
							<div class="panel-heading" role="tab" id="heading{$node_order->$prefix}">
							  <h4 class="panel-title">
								
								{if $node_heartbeat[$prefix]=="在线"}
								<i class="fa fa-cloud-upload text-success"></i><a role="button" data-toggle="collapse" href="#collapse{$node_order->$prefix}" aria-expanded="false" aria-controls="collapse{$node_order->$prefix}">
									{$prefix} | <i class="fa fa-user"></i> {$node_alive[$prefix]} | <i class="fa fa-wrench"></i> {$node_method[$prefix]} | <i class="fa fa-arrows"></i> {$node_bandwidth[$prefix]}
								</a>
								
								{else}
								<i class="fa fa-exclamation-triangle text-danger"></i><a role="button" data-toggle="collapse" href="#collapse{$node_order->$prefix}" aria-expanded="false" aria-controls="collapse{$node_order->$prefix}">
									{$prefix} | <i class="fa fa-user"></i> {$node_alive[$prefix]} | <i class="fa fa-wrench"></i> {$node_method[$prefix]} | <i class="fa fa-arrows"></i> {$node_bandwidth[$prefix]}
								</a>
								
								{/if}
							  </h4>
							</div>
							<div id="collapse{$node_order->$prefix}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading{$node_order->$prefix}">
							  <div class="panel-body">
							{foreach $nodes as $node}
								<div class="row">
									<div class="col-sm-12">
										<div class="info-box">
											
											<span class="info-box-icon bg-aqua"><i class="fa fa-server"></i></span>
											<div class="info-box-content">
												<div class=row>
													<div class="col-sm-6">
														<div class="info-box-number" >
															<a href="./node/{$node->id}">{$node->name}</a> <sub><span
																		class="label label-success">{$node->status}</span></sub>
														</div>

														<div class="info-box-text row">
															<div class="col-xs-4 col-sm-2">地址：</div>
															{if $node->sort > 2 && $node->sort != 5}
																<div class="col-xs-8 col-sm-4"><a href="./node/{$node->id}"><span
																			class="label text-lowercase label-primary" >请点这里进入查看详细信息</span></a>
																</div>
															{else}
																<div class="col-xs-8 col-sm-4"><span
																			class="label text-lowercase label-primary">{$node->server}</span>
																</div>

															{/if}
															
															{if $node->sort == 0||$node->sort==7||$node->sort==8}
															<div class="col-xs-4 col-sm-2">加密：</div>
															<div class="col-xs-8 col-sm-4">
															<span class="label label-danger">
																{if $node->custom_method == 1}
																	{$user->method}
																{else}
																	{$node->method}
																{/if}
															</span>

															</div>
															<div class="col-xs-4 col-sm-2">流量比例：</div>
															<div class="col-xs-8 col-sm-4"><span
																		class="label label-warning">{$node->traffic_rate}</span>
															</div>
															
                                                        <div class="col-xs-4 col-sm-2">在线人数：</div>
                                                        <div class="col-xs-8 col-sm-4"><span
                                                                    class="label label-danger">{$node->getOnlineUserCount()}</span>
                                                        </div>
														{/if}
														


														{if ($node->sort==0||$node->sort==7||$node->sort==8)&&$node->node_speedlimit!=0}
														<div class="col-xs-4 col-sm-2">节点限速：</div>
														<div class="col-xs-8 col-sm-4">
															{if $node->node_speedlimit>$user->node_speedlimit}
																<span class="label label-primary">{$node->node_speedlimit}Mbps</span>
															{else}
																<span class="label label-primary">{$user->node_speedlimit}Mbps</span>
															{/if}
														
														</div>
														{/if}


														</div>









													</div>
													<div class="col-sm-6">
														{$node->info}
													</div>
												</div>


											</div>
											<!-- /.info-box-content -->
										</div>
										<!-- /.info-box -->
									</div>
								</div>
								{if ($node->sort==0||$node->sort==7||$node->sort==8)&&$node->getNodeLoad()!="暂无数据"}
								{$load=$node->getNodeLoad()}
								{$uptime=$node->getNodeUptime()}
								{/if}
								{if $node->sort==0}
								{$speedtest=$node->getSpeedtest()}
								{/if}
							{/foreach}
						<p>{$speedtest}</p>
						<i class="fa fa-server"></i>负载：{$load} <i class="fa fa-upload" aria-hidden="true"></i>Uptime：{$uptime}
						</div>
						</div>
					  </div>
					{/foreach}
					  
					  
					  
					</div>
					
					
					
					
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (left) -->
        </div>
        <!-- /.row --><!-- END PROGRESS BARS -->
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->


{include file='user/footer.tpl'}

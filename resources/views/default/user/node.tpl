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
								<a role="button" data-toggle="collapse" href="#collapse{$node_order->$prefix}" aria-expanded="false" aria-controls="collapse{$node_order->$prefix}">
									{$prefix} | 在线人数： {$node_alive[$prefix]} | 提供方式： {$node_method[$prefix]} | {$node_heartbeat[$prefix]} | {$node_bandwidth[$prefix]}
								</a>
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
															<div class="col-xs-8 col-sm-4"><span
																		class="label text-lowercase  label-primary" >{$node->server}</span>
															</div>
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
                                                                    class="label label-danger">{$node_prealive[$node->id]}</span>
                                                        </div>







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
                        {/foreach}
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

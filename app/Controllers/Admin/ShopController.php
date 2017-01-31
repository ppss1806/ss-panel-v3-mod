<?php

namespace App\Controllers\Admin;

use App\Models\Shop;
use App\Models\Bought;
use App\Controllers\AdminController;

class ShopController extends AdminController
{
    public function index($request, $response, $args){
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
		$shops = Shop::paginate(15, ['*'], 'page', $pageNum);
		$shops->setPath('/admin/shop');
		
        return $this->view()->assign('shops',$shops)->display('admin/shop/index.tpl');
    }

    public function create($request, $response, $args){
        return $this->view()->display('admin/shop/create.tpl');
    }

    public function add($request, $response, $args){
        $shop = new Shop();
        $shop->name =  $request->getParam('name');
        $shop->price =  $request->getParam('price');
        $shop->auto_renew =  $request->getParam('auto_renew');
        $shop->auto_reset_bandwidth =  $request->getParam('auto_reset_bandwidth');
		
		$content=array();
		if($request->getParam('bandwidth')!=0)
		{
			$content["bandwidth"]=$request->getParam('bandwidth');
		}
		
		if($request->getParam('expire')!=0)
		{
			$content["expire"]=$request->getParam('expire');
		}
        
		if($request->getParam('class')!=0)
		{
			$content["class"]=$request->getParam('class');
		}
		
		if($request->getParam('class_expire')!=0)
		{
			$content["class_expire"]=$request->getParam('class_expire');
		}
		
		$shop->content=json_encode($content);
		
		
        if(!$shop->save()){
            $rs['ret'] = 0;
            $rs['msg'] = "添加失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "添加成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function edit($request, $response, $args){
        $id = $args['id'];
        $shop = Shop::find($id);
        if ($shop == null){

        }
        return $this->view()->assign('shop',$shop)->display('admin/shop/edit.tpl');
    }

    public function update($request, $response, $args){
        $id = $args['id'];
        $shop = Shop::find($id);
		
		$shop->name =  $request->getParam('name');
        $shop->price =  $request->getParam('price');
        $shop->auto_renew =  $request->getParam('auto_renew');
		
		if($shop->auto_reset_bandwidth == 1 && $request->getParam('auto_reset_bandwidth') == 0 )
		{
			$boughts = Bought::where("shopid",$id)->get();
		
			foreach($boughts as $bought)
			{
				$bought->renew=0;
				$bought->save();
			}
		}
		
		$shop->auto_reset_bandwidth =  $request->getParam('auto_reset_bandwidth');
		$shop->status=1;
        
		$content=array();
		if($request->getParam('bandwidth')!=0)
		{
			$content["bandwidth"]=$request->getParam('bandwidth');
		}
		
		if($request->getParam('expire')!=0)
		{
			$content["expire"]=$request->getParam('expire');
		}
        
		if($request->getParam('class')!=0)
		{
			$content["class"]=$request->getParam('class');
		}
		
		if($request->getParam('class_expire')!=0)
		{
			$content["class_expire"]=$request->getParam('class_expire');
		}
		
		$shop->content=json_encode($content);
		
		if(!$shop->save()){
            $rs['ret'] = 0;
            $rs['msg'] = "保存失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "保存成功";
        return $response->getBody()->write(json_encode($rs));
    }



    public function deleteGet($request, $response, $args){
        $id = $request->getParam('id');
        $shop = Shop::find($id);
		$shop->status=0;
        if(!$shop->save()){
            $rs['ret'] = 0;
            $rs['msg'] = "下架失败";
            return $response->getBody()->write(json_encode($rs));
        }
		
		$boughts = Bought::where("shopid",$id)->get();
		
		foreach($boughts as $bought)
		{
			$bought->renew=0;
			$bought->save();
		}
		
        $rs['ret'] = 1;
        $rs['msg'] = "下架成功";
        return $response->getBody()->write(json_encode($rs));
    }
	
	public function bought($request, $response, $args){
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
		$shops = Bought::orderBy("id","desc")->paginate(15, ['*'], 'page', $pageNum);
		$shops->setPath('/admin/bought');
		
        return $this->view()->assign('shops',$shops)->display('admin/shop/bought.tpl');
    }
	
	public function deleteBoughtGet($request, $response, $args){
        $id = $request->getParam('id');
        $shop = Bought::find($id);
        $shop->renew=0;
		if(!$shop->save()){
            $rs['ret'] = 0;
            $rs['msg'] = "退订失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "退订成功";
		return $response->getBody()->write(json_encode($rs));
    }
}
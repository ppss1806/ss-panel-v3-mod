<?php

namespace App\Controllers\Admin;

use App\Models\Relay;
use App\Models\Node;
use App\Models\User;
use App\Utils\Tools;
use App\Services\Auth;
use App\Controllers\AdminController;

class RelayController extends AdminController
{
    public function index($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $logs = Relay::paginate(15, ['*'], 'page', $pageNum);
        $logs->setPath('/admin/relay');
        return $this->view()->assign('rules', $logs)->display('admin/relay/index.tpl');
    }

    public function create($request, $response, $args)
    {
        $user = Auth::getUser();
        $source_nodes = Node::where('type', 1)->where('sort', 10)->orderBy('name')->get();

        $dist_nodes = Node::where('type', 1)->where(
            function ($query) {
                $query->Where('sort', 0)
                    ->orWhere('sort', 10);
            }
        )->orderBy('name')->get();


        return $this->view()->assign('source_nodes', $source_nodes)->assign('dist_nodes', $dist_nodes)->display('admin/relay/add.tpl');
    }

    public function add($request, $response, $args)
    {
        $dist_node_id = $request->getParam('dist_node');
        $source_node_id = $request->getParam('source_node');
        $port = $request->getParam('port');
        $priority = $request->getParam('priority');
        $user_id = $request->getParam('user_id');

        $source_node = Node::where('id', $source_node_id)->first();
        if ($source_node == null) {
            $rs['ret'] = 0;
            $rs['msg'] = "起源节点错误。";
            return $response->getBody()->write(json_encode($rs));
        }

        $dist_node = Node::where('id', $dist_node_id)->first();
        if ($dist_node == null) {
            $rs['ret'] = 0;
            $rs['msg'] = "目标节点错误。";
            return $response->getBody()->write(json_encode($rs));
        }

        $rule = new Relay();
        $rule->user_id = $user_id;
        $rule->dist_node_id = $dist_node_id;
        $rule->dist_ip = $dist_node->node_ip;
        $rule->source_node_id = $source_node_id;
        $rule->port = $port;
        $rule->priority = $priority;

        if ($user_id == 0) {
            $ruleset = Relay::all();
        } else {
            $ruleset = Relay::where('user_id', $user_id)->orwhere('user_id', 0)->get();
        }
        $maybe_rule_id = Tools::has_conflict_rule($rule, $ruleset, 0, $rule->source_node_id);
        if ($maybe_rule_id != 0) {
            $rs['ret'] = 0;
            $rs['msg'] = "您即将添加的规则与规则 ID:".$maybe_rule_id." 冲突！";
            if ($maybe_rule_id == -1) {
                $rs['msg'] = "您即将添加的规则可能会造成冲突！";
            }
            return $response->getBody()->write(json_encode($rs));
        }

        if (!$rule->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "添加失败";
            return $response->getBody()->write(json_encode($rs));
        }

        $rs['ret'] = 1;
        $rs['msg'] = "添加成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function edit($request, $response, $args)
    {
        $id = $args['id'];

        $user = Auth::getUser();
        $rule = Relay::where('id', $id)->first();

        if ($rule == null) {
            exit(0);
        }

        $source_nodes = Node::where('type', 1)->where('sort', 10)->orderBy('name')->get();

        $dist_nodes = Node::where('type', 1)->where(
            function ($query) {
                $query->Where('sort', 0)
                    ->orWhere('sort', 10);
            }
        )->orderBy('name')->get();

        return $this->view()->assign('rule', $rule)->assign('source_nodes', $source_nodes)->assign('dist_nodes', $dist_nodes)->display('admin/relay/edit.tpl');
    }

    public function update($request, $response, $args)
    {
        $id = $args['id'];
        $rule = Relay::where('id', $id)->first();

        if ($rule == null) {
            exit(0);
        }

        $dist_node_id = $request->getParam('dist_node');
        $source_node_id = $request->getParam('source_node');
        $port = $request->getParam('port');
        $user_id = $request->getParam('user_id');
        $priority = $request->getParam('priority');

        $source_node = Node::where('id', $source_node_id)->first();
        if ($source_node == null && $source_node_id != 0) {
            $rs['ret'] = 0;
            $rs['msg'] = "起源节点 ID 错误。";
            return $response->getBody()->write(json_encode($rs));
        }

        $dist_node = Node::where('id', $dist_node_id)->first();
        if ($dist_node == null) {
            $rs['ret'] = 0;
            $rs['msg'] = "目标节点 ID 错误。";
            return $response->getBody()->write(json_encode($rs));
        }

        $rule->user_id = $user_id;
        $rule->dist_node_id = $dist_node_id;
        $rule->dist_ip = $dist_node->node_ip;
        $rule->source_node_id = $source_node_id;
        $rule->port = $port;
        $rule->priority = $priority;

        if ($user_id == 0) {
            $ruleset = Relay::all();
        } else {
            $ruleset = Relay::where('user_id', $user_id)->orwhere('user_id', 0)->get();
        }
        $maybe_rule_id = Tools::has_conflict_rule($rule, $ruleset, $rule->id, $rule->source_node_id);
        if ($maybe_rule_id != 0) {
            $rs['ret'] = 0;
            $rs['msg'] = "您即将添加的规则与规则 ID:".$maybe_rule_id." 冲突！";
            if ($maybe_rule_id == -1) {
                $rs['msg'] = "您即将添加的规则可能会造成冲突！";
            }
            return $response->getBody()->write(json_encode($rs));
        }


        if (!$rule->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "修改失败";
            return $response->getBody()->write(json_encode($rs));
        }

        $rs['ret'] = 1;
        $rs['msg'] = "修改成功";
        return $response->getBody()->write(json_encode($rs));
    }


    public function delete($request, $response, $args)
    {
        $id = $request->getParam('id');
        $user = Auth::getUser();
        $rule = Relay::where('id', $id)->first();

        if ($rule == null) {
            exit(0);
        }

        if (!$rule->delete()) {
            $rs['ret'] = 0;
            $rs['msg'] = "删除失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "删除成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function path_search($request, $response, $args)
    {
        $uid=$args["id"];

        $user = User::find($uid);

        if ($user == null) {
            $pathset = new \ArrayObject();
            return $this->view()->assign('pathset', $pathset)->display('admin/relay/search.tpl');
        }

        $nodes = Node::where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                      ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where("sort", "=", 10)->where("node_class", "<=", $user->class)->orderBy('name')->get();

        $pathset = new \ArrayObject();

        $relay_rules = Relay::where('user_id', $user->id)->orwhere('user_id', 0)->get();
        $mu_nodes = Node::where('sort', 9)->where('node_class', '<=', $user->class)->where("type", "1")->where(
            function ($query) use ($user) {
                $query->where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->get();

        foreach ($nodes as $node) {
            if ($node->mu_only == 0) {
                $relay_rule = Tools::pick_out_relay_rule($node->id, $user->port, $relay_rules);

                if ($relay_rule != null) {
                    $pathset = Tools::insertPathRule($relay_rule, $pathset, $user->port);
                }
            }

            if ($node->custom_rss == 1) {
                foreach ($mu_nodes as $mu_node) {
                    $mu_user = User::where('port', '=', $mu_node->server)->first();

                    if ($mu_user == null) {
                        continue;
                    }

                    if (!($mu_user->class >= $node->node_class && ($node->node_group == 0 || $node->node_group == $mu_user->node_group))) {
                        continue;
                    }

                    if ($mu_user->is_multi_user != 2) {
                        $relay_rule = Tools::pick_out_relay_rule($node->id, $mu_user->port, $relay_rules);

                        if ($relay_rule != null) {
                            $pathset = Tools::insertPathRule($relay_rule, $pathset, $mu_user->port);
                        }
                    }
                }
            }
        }

        return $this->view()->assign('pathset', $pathset)->display('admin/relay/search.tpl');
    }
}

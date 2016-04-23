<?php
/**
 * 解析记录的接口逻辑处理的Demo
 *
 * @author CloudXNS <support@cloudxns.net>
 * @link https://www.cloudxns.net/
 * @copyright Copyright (c) 2015 Cloudxns.
 */
require_once '../vendor/autoload.php';
$api = new \CloudXNS\Api();
$api->setApiKey('xxxxxxxxxx');
$api->setSecretKey('xxxxxxxxxx');
$api->setProtocol(true);
/**
 * DDNS快速修改解析记录
 * @param integer $recordId 解析记录ID
 * @param integer $domainId 域名id
 * @param integer $status 操作状态： 0 暂停，1 启用
 */
echo $api->ddns->ddns('aaa.test.net.cn.','',1);
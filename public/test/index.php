<?php


function startsWith($str, $sub)
{
    return !strncmp($str, $sub, strlen($sub));
}

function endsWith($str, $sub)
{
    $length = strlen($sub);
    if ($length == 0) {
        return true;
    }

    return (substr($str, -$length) === $sub);
}

function replaceToNomal($str)
{
    $str = preg_replace('/([\\\+\|\{\}\[\]\(\)\^\$\.\#])/', '\\\${1}', $str);
    $str = str_replace('*', '.*', $str);
    $str = str_replace('?', '.', $str);
    return $str;
}

function encode($d)
{
    return strrev(base64_encode(strrev($d)));
}

function toPac($list, $proxy, $debug)
{

    $rules = array();

    for ($i = 0; $i < count($list); $i++) {
        $rule = trim($list[$i]);
        $isRegex = false;
        $isProxy = true;
        $scope = "url";

        if (strlen($rule) == 0 || startsWith($rule, "!") || startsWith($rule, "[")) {

            continue;
        }


        if (startsWith($rule, "@@")) {
            $isProxy = false;
            $rule = substr($rule, 2);
        }

        if (startsWith($rule, "/") and endsWith($rule, "/")) {
            $isRegex = true;
            $rule = substr(substr($rule, 1), 0, count($rule) - 2);
        } else if (startsWith($rule, "||")) {
            $rule = substr($rule, 2);
            $isRegex = true;
            //if(endsWith($rule,"*") == false) $rule = $rule."*";
            //if(startsWith($rule,"*") == false) $rule = "*".$rule;
            $rule = '^([\\w\\-\\_\\.]+\\.)?' . $rule . '$';
            $scope = "host";

        } else if (startsWith($rule, "|") or endsWith($rule, "|")) {
            $start = false;
            if (startsWith($rule, "|")) {
                $start = true;
                $rule = substr($rule, 1);
                if (endsWith($rule, "*") == false && endsWith($rule, "|") == false) $rule = $rule . "*";
            }
            if (endsWith($rule, "|")) {
                $rule = substr($rule, 0, -1);
                if (startsWith($rule, "*") == false && $start == false) $rule = "*" . $rule;
            }
        } else {
            if (startsWith($rule, "*") == false) $rule = "*$rule";
            if (endsWith($rule, "*") == false) $rule = "$rule*";
        }

        $obj = array();
        $obj['pattern'] = $rule;
        $obj['isProxy'] = $isProxy;
        $obj['isRegex'] = $isRegex;
        $obj['scope'] = $scope;
        array_push($rules, $obj);
    }


    $rulesJSON = encode(json_encode($rules));
    $ced = array(
        "a" => ",",
        "A" => ".",
        "b" => "/",
        "B" => "?",
        "c" => ";",
        "C" => ':',
        "d" => "[",
        "D" => "]",
        "e" => "{",
        "E" => "}",
        "f" => "<",
        "F" => "|",
        "g" => "=",
        "G" => "-",
        "1" => ")",
        "2" => "(",
        "3" => "*",
        "4" => "&",
        "5" => "^",
        "6" => "%",
        "7" => "$",
        "8" => "#",
        "9" => "@",
        "0" => "!"
    );
    foreach ($ced as $k => $i) {
        $rulesJSON = str_replace($k, $i, $rulesJSON);
    }
    $ced = encode(json_encode($ced));
    if ($debug) {
        echo "alert('PACProxy pac file load start...');\n";
    }
    echo file_get_contents("Base64.js");
    echo <<<JS

function strrev(str){
    var tmp = [];
    for(var i=0;i<str.length;i++)
        tmp[i] = str.charAt(str.length-1-i);
    return tmp.join("").toString();
}

function replace(str,s,t){
    while(true){
       var new_str = str.replace(s,t);
       if(new_str == str)
            return str;
       str = new_str;
    }
}

function decode(d){
      return strrev(Base64.decode(strrev(d)));
}
var rulesJSON = '$rulesJSON';
var ced = JSON.parse(decode('$ced'));
for(var k in ced){
    rulesJSON = replace(rulesJSON,ced[k],k);
}
var data = decode(rulesJSON);
var rules = eval(data);


      
var regExpMatch = function(url, pattern) {
  try {
    return new RegExp(pattern).test(url);
  } catch(ex) {
    return false;
  }
};
var matchRule = function(url){
   var rule;
   var match=false;
   var c;
   var pi = url.indexOf('://');
   var pathi = url.indexOf('/',pi+3);
   var protoctl = url.substring(0,pi);
   var host = url.substring(pi+3,pathi);
   var path = url.substring(pathi);
      
   for(var i=0;i<rules.length;i++){
      rule = rules[i];
      c = url;
      if(rule.scope == "url")
        c = url;
      else if(rule.scope == "path")
        c = path;
      else if(rule.scope == "host")
        c = host;
      
      if(rule.isRegex)
        match = regExpMatch(c,rule.pattern);
      else
        match = shExpMatch(c,rule.pattern);
      
      if(match){
        return rule;
      }
   }
   return null;
}
var getProxy = function(url){
   var rule = matchRule(url);
   return (rule == null || rule.isProxy == false ? "DIRECT" : "$proxy" );
}

var FindProxyForURL = getProxy;     

JS;

    if ($debug) {
        echo <<<DEBUGJS
FindProxyForURL = function(url){
      var startTime = new Date().getTime();
      var rule = matchRule(url);
      var proxy = (rule == null || rule.isProxy == false ? "DIRECT" : "$proxy" );
      var debugMsg = [];
      debugMsg.push("URL:"+url);
      debugMsg.push("Proxy:"+proxy);
      debugMsg.push("Match:"+(rule == null?"not match":rule.pattern));
      debugMsg.push("Use:"+(new Date().getTime()-startTime)+"ms");      
      alert(debugMsg.join("\\n"));
      return proxy;
}
alert('PACProxy pac file load finish.');
      
DEBUGJS;
    }


}

$gfw_list = file_get_contents("gfw.user.rule");
if (@$_REQUEST['gfw'] != "0") {
    $gfw_url = "http://autoproxy-gfwlist.googlecode.com/svn/trunk/gfwlist.txt";
    $gfw_list_b64 = file_get_contents($gfw_url) or die("get $gfw_url error!");
    $gfw_list = $gfw_list . "\n" . base64_decode($gfw_list_b64);
}

$o = @$_REQUEST["o"];
$p = @$_REQUEST["p"];
$pt = @$_REQUEST["pt"];

if ($p == null) $p = "127.0.0.1:7777";
if ($pt == null) $pt = "SOCKS5";

if ($o == "html") echo "<pre>";

$f = @$_REQUEST["f"];

if ($f == null)
    $f = "test";
if ($f == "write_user_rule") {
    if (@$_REQUEST['gfw_user_rule'] != null)
        file_put_contents("gfw.user.rule", @$_REQUEST['gfw_user_rule']);
    header("location: /");
    exit(0);
}
if ($f == "decode")
    echo $gfw_list;
else if ($f == "pac") {
    if ($o != "html")
        header('Content-type: application/x-ns-proxy-autoconfig');
    echo toPac(explode("\n", $gfw_list), "$pt $p", @$_REQUEST['debug'] == 1);
} else if ($f == "test") {

    ?>

    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>YuKunYi Proxy Pac Manager</title>
        <script src="?f=pac&p=test.proxy.com&pt=socks&gfw=<?php echo @$_REQUEST['gfw'] ?>"
                type="text/javascript"></script>

        <script type="text/javascript">
            var matchPattern = null;
            function shExpMatch(url, pattern) {
                var pCharCode;
                var isAggressive = false;
                var pIndex;
                var urlIndex = 0;
                var lastIndex;
                var patternLength = pattern.length;
                var urlLength = url.length;
                for (pIndex = 0; pIndex < patternLength; pIndex += 1) {
                    pCharCode = pattern.charCodeAt(pIndex); // use charCodeAt for performance, see http://jsperf.com/charat-charcodeat-brackets
                    if (pCharCode === 63) { // use if instead of switch for performance, see http://jsperf.com/switch-if
                        if (isAggressive) {
                            urlIndex += 1;
                        }
                        isAggressive = false;
                        urlIndex += 1;
                    }
                    else if (pCharCode === 42) {
                        if (pIndex === patternLength - 1) {
                            if (urlIndex <= urlLength) {
                                matchPattern = pattern;
                                return true;
                            }
                            return false;
                        }
                        else {
                            isAggressive = true;
                        }
                    }
                    else {
                        if (isAggressive) {
                            lastIndex = urlIndex;
                            urlIndex = url.indexOf(String.fromCharCode(pCharCode), lastIndex + 1);
                            if (urlIndex < 0) {
                                if (url.charCodeAt(lastIndex) !== pCharCode) {
                                    return false;
                                }
                                urlIndex = lastIndex;
                            }
                            isAggressive = false;
                        }
                        else {
                            if (urlIndex >= urlLength || url.charCodeAt(urlIndex) !== pCharCode) {
                                return false;
                            }
                        }
                        urlIndex += 1;
                    }
                }
                if (urlIndex === urlLength) {
                    matchPattern = pattern;
                    return true;
                }
                return false;
            }
            function test() {
                var url = document.getElementById("url").value;

                if (url.indexOf("://") == -1) url = "http://" + url;
                if (url.lastIndexOf('/') == url.indexOf('://') + 2) url = url + "/";
                var resultDiv = document.getElementById("result");
                matchPattern = null;
                var startTime = new Date().getTime();
                var ret = FindProxyForURL(url);
                var htmls = [];
                htmls.push("URL:" + url);
                htmls.push("FindProxyForURL return is : " + ret);
                htmls.push((matchPattern != null ? " match " + matchPattern : " not match any pattern."));
                htmls.push("use " + (new Date().getTime() - startTime) + "ms");
                resultDiv.innerHTML = htmls.join("<br/>");
            }


            regExpMatch = function (url, pattern) {
                try {
                    if (new RegExp(pattern).test(url)) {
                        matchPattern = pattern;
                        return true;
                    }
                    return false;
                } catch (ex) {
                    return false;
                }
            };
        </script>

    </head>
    <body>
    <script type="text/javascript">
        document.write("rules has " + rules.length + " items.<br/>");
    </script>
    URL:<textarea type="text" id="url" style="width:800px;"></textarea><a href="javascript:test()">Test</a>

    <div id="result"></div>
    <br/>
    <br/>
    <br/>

    <div>
        <form action="/?f=write_user_rule" method="post">
            UserRule:<textarea name="gfw_user_rule"
                               style="width:800px;height:500px;"><?php echo file_get_contents("gfw.user.rule") ?></textarea>
            <br/>
            <input type="submit"/>
        </form>
    </div>
    </body>
    </html>


<?php

}


if ($o == "html") echo "</pre>";
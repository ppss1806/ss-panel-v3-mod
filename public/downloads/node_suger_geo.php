<?php
$server =  $_GET["server"];
$method = $_GET["method"];
$pass = $_GET["pass"];
$port = $_GET["port"];
$baseurl = $_GET["baseurl"];

Header("Content-type: application/octet-stream");
Header("Content-Disposition: attachment; filename=".$server."_geo.conf"); 
?>

[General]

skip-proxy = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, localhost, *.local

bypass-tun = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12

dns-server = 119.29.29.29, 223.5.5.5, 114.114.114.114
loglevel = notify



[Proxy]

Proxy = custom,<?php echo $server; ?>,<?php echo $port; ?>,<?php echo $method; ?>,<?php echo $pass; ?>,<?php echo $baseurl; ?>/ss.module



[Rule]

DOMAIN-KEYWORD,adsmogo,REJECT

DOMAIN-SUFFIX,acs86.com,REJECT

DOMAIN-SUFFIX,adcome.cn,REJECT

DOMAIN-SUFFIX,adinfuse.com,REJECT

DOMAIN-SUFFIX,admaster.com.cn,REJECT

DOMAIN-SUFFIX,admob.com,REJECT

DOMAIN-SUFFIX,adsage.cn,REJECT

DOMAIN-SUFFIX,adsage.com,REJECT

DOMAIN-SUFFIX,adsmogo.org,REJECT

DOMAIN-SUFFIX,ads.mobclix.com,REJECT

DOMAIN-SUFFIX,adview.cn,REJECT

DOMAIN-SUFFIX,adwhirl.com,REJECT

DOMAIN-SUFFIX,adwo.com,REJECT

DOMAIN-SUFFIX,appads.com,REJECT

DOMAIN-SUFFIX,domob.cn,REJECT

DOMAIN-SUFFIX,domob.com.cn,REJECT

DOMAIN-SUFFIX,domob.org,REJECT

DOMAIN-SUFFIX,doubleclick.net,REJECT

DOMAIN-SUFFIX,duomeng.cn,REJECT

DOMAIN-SUFFIX,duomeng.net,REJECT

DOMAIN-SUFFIX,duomeng.org,REJECT

DOMAIN-SUFFIX,googeadsserving.cn,REJECT

DOMAIN-SUFFIX,guomob.com,REJECT

DOMAIN-SUFFIX,immob.cn,REJECT

DOMAIN-SUFFIX,inmobi.com,REJECT

DOMAIN-SUFFIX,mobads.baidu.com,REJECT

DOMAIN-SUFFIX,mobads-logs.baidu.com,REJECT

DOMAIN-SUFFIX,smartadserver.com,REJECT

DOMAIN-SUFFIX,tapjoyads.com,REJECT

DOMAIN-SUFFIX,umeng.co,REJECT

DOMAIN-SUFFIX,umeng.com,REJECT

DOMAIN-SUFFIX,umtrack.com,REJECT

DOMAIN-SUFFIX,uyunad.com,REJECT

DOMAIN-SUFFIX,youmi.net,REJECT

GEOIP,AD,Proxy
GEOIP,AE,Proxy
GEOIP,AF,Proxy
GEOIP,AG,Proxy
GEOIP,AI,Proxy
GEOIP,AL,Proxy
GEOIP,AM,Proxy
GEOIP,AO,Proxy
GEOIP,AQ,Proxy
GEOIP,AR,Proxy
GEOIP,AS,Proxy
GEOIP,AS,Proxy
GEOIP,AS,Proxy
GEOIP,AS,Proxy
GEOIP,AT,Proxy
GEOIP,AU,Proxy
GEOIP,AW,Proxy
GEOIP,AX,Proxy
GEOIP,AZ,Proxy
GEOIP,BA,Proxy
GEOIP,BD,Proxy
GEOIP,BE,Proxy
GEOIP,BF,Proxy
GEOIP,BG,Proxy
GEOIP,BH,Proxy
GEOIP,BI,Proxy
GEOIP,BJ,Proxy
GEOIP,BL,Proxy
GEOIP,BM,Proxy
GEOIP,BN,Proxy
GEOIP,BO,Proxy
GEOIP,BQ,Proxy
GEOIP,BR,Proxy
GEOIP,BS,Proxy
GEOIP,BT,Proxy
GEOIP,BW,Proxy
GEOIP,BY,Proxy
GEOIP,BZ,Proxy
GEOIP,CA,Proxy
GEOIP,CC,Proxy
GEOIP,CD,Proxy
GEOIP,CF,Proxy
GEOIP,CG,Proxy
GEOIP,CH,Proxy
GEOIP,CI,Proxy
GEOIP,CK,Proxy
GEOIP,CL,Proxy
GEOIP,CM,Proxy
GEOIP,CO,Proxy
GEOIP,CR,Proxy
GEOIP,CU,Proxy
GEOIP,CV,Proxy
GEOIP,CW,Proxy
GEOIP,CX,Proxy
GEOIP,CY,Proxy
GEOIP,CZ,Proxy
GEOIP,DE,Proxy
GEOIP,DJ,Proxy
GEOIP,DK,Proxy
GEOIP,DM,Proxy
GEOIP,DO,Proxy
GEOIP,DZ,Proxy
GEOIP,EC,Proxy
GEOIP,EE,Proxy
GEOIP,EG,Proxy
GEOIP,EG,Proxy
GEOIP,EH,Proxy
GEOIP,ER,Proxy
GEOIP,ES,Proxy
GEOIP,ET,Proxy
GEOIP,FI,Proxy
GEOIP,FJ,Proxy
GEOIP,FK,Proxy
GEOIP,FM,Proxy
GEOIP,FO,Proxy
GEOIP,FR,Proxy
GEOIP,GA,Proxy
GEOIP,GB,Proxy
GEOIP,GD,Proxy
GEOIP,GE,Proxy
GEOIP,GF,Proxy
GEOIP,GG,Proxy
GEOIP,GH,Proxy
GEOIP,GI,Proxy
GEOIP,GL,Proxy
GEOIP,GM,Proxy
GEOIP,GN,Proxy
GEOIP,GP,Proxy
GEOIP,GQ,Proxy
GEOIP,GR,Proxy
GEOIP,GS,Proxy
GEOIP,GT,Proxy
GEOIP,GU,Proxy
GEOIP,GW,Proxy
GEOIP,GY,Proxy
GEOIP,HK,Proxy
GEOIP,HM,Proxy
GEOIP,HN,Proxy
GEOIP,HR,Proxy
GEOIP,HT,Proxy
GEOIP,HU,Proxy
GEOIP,ID,Proxy
GEOIP,IE,Proxy
GEOIP,IL,Proxy
GEOIP,IM,Proxy
GEOIP,IN,Proxy
GEOIP,IO,Proxy
GEOIP,IQ,Proxy
GEOIP,IR,Proxy
GEOIP,IS,Proxy
GEOIP,IT,Proxy
GEOIP,JE,Proxy
GEOIP,JM,Proxy
GEOIP,JO,Proxy
GEOIP,JP,Proxy
GEOIP,KE,Proxy
GEOIP,KG,Proxy
GEOIP,KH,Proxy
GEOIP,KI,Proxy
GEOIP,KM,Proxy
GEOIP,KN,Proxy
GEOIP,KP,Proxy
GEOIP,KR,Proxy
GEOIP,KW,Proxy
GEOIP,KY,Proxy
GEOIP,KZ,Proxy
GEOIP,LA,Proxy
GEOIP,LB,Proxy
GEOIP,LC,Proxy
GEOIP,LI,Proxy
GEOIP,LK,Proxy
GEOIP,LR,Proxy
GEOIP,LS,Proxy
GEOIP,LT,Proxy
GEOIP,LU,Proxy
GEOIP,LV,Proxy
GEOIP,LY,Proxy
GEOIP,MA,Proxy
GEOIP,MC,Proxy
GEOIP,MD,Proxy
GEOIP,ME,Proxy
GEOIP,MF,Proxy
GEOIP,MG,Proxy
GEOIP,MH,Proxy
GEOIP,MK,Proxy
GEOIP,ML,Proxy
GEOIP,MM,Proxy
GEOIP,MN,Proxy
GEOIP,MO,Proxy
GEOIP,MP,Proxy
GEOIP,MQ,Proxy
GEOIP,MR,Proxy
GEOIP,MS,Proxy
GEOIP,MT,Proxy
GEOIP,MU,Proxy
GEOIP,MV,Proxy
GEOIP,MW,Proxy
GEOIP,MX,Proxy
GEOIP,MY,Proxy
GEOIP,MZ,Proxy
GEOIP,NA,Proxy
GEOIP,NC,Proxy
GEOIP,NE,Proxy
GEOIP,NF,Proxy
GEOIP,NG,Proxy
GEOIP,NI,Proxy
GEOIP,NL,Proxy
GEOIP,NO,Proxy
GEOIP,NP,Proxy
GEOIP,NR,Proxy
GEOIP,NU,Proxy
GEOIP,NZ,Proxy
GEOIP,OM,Proxy
GEOIP,PA,Proxy
GEOIP,PE,Proxy
GEOIP,PF,Proxy
GEOIP,PG,Proxy
GEOIP,PH,Proxy
GEOIP,PK,Proxy
GEOIP,PL,Proxy
GEOIP,PM,Proxy
GEOIP,PN,Proxy
GEOIP,PR,Proxy
GEOIP,PS,Proxy
GEOIP,PT,Proxy
GEOIP,PW,Proxy
GEOIP,PY,Proxy
GEOIP,QA,Proxy
GEOIP,RE,Proxy
GEOIP,RO,Proxy
GEOIP,RS,Proxy
GEOIP,RU,Proxy
GEOIP,RW,Proxy
GEOIP,SA,Proxy
GEOIP,SB,Proxy
GEOIP,SC,Proxy
GEOIP,SD,Proxy
GEOIP,SE,Proxy
GEOIP,SG,Proxy
GEOIP,SH,Proxy
GEOIP,SI,Proxy
GEOIP,SJ,Proxy
GEOIP,SK,Proxy
GEOIP,SL,Proxy
GEOIP,SM,Proxy
GEOIP,SN,Proxy
GEOIP,SO,Proxy
GEOIP,SR,Proxy
GEOIP,SS,Proxy
GEOIP,ST,Proxy
GEOIP,SV,Proxy
GEOIP,SX,Proxy
GEOIP,SY,Proxy
GEOIP,SZ,Proxy
GEOIP,TC,Proxy
GEOIP,TD,Proxy
GEOIP,TF,Proxy
GEOIP,TG,Proxy
GEOIP,TH,Proxy
GEOIP,TJ,Proxy
GEOIP,TK,Proxy
GEOIP,TL,Proxy
GEOIP,TM,Proxy
GEOIP,TN,Proxy
GEOIP,TO,Proxy
GEOIP,TR,Proxy
GEOIP,TT,Proxy
GEOIP,TV,Proxy
GEOIP,TW,Proxy
GEOIP,TZ,Proxy
GEOIP,UA,Proxy
GEOIP,UG,Proxy
GEOIP,UM,Proxy
GEOIP,US,Proxy
GEOIP,UY,Proxy
GEOIP,UZ,Proxy
GEOIP,VA,Proxy
GEOIP,VC,Proxy
GEOIP,VE,Proxy
GEOIP,VG,Proxy
GEOIP,VI,Proxy
GEOIP,VN,Proxy
GEOIP,VU,Proxy
GEOIP,WF,Proxy
GEOIP,WS,Proxy
GEOIP,YE,Proxy
GEOIP,YT,Proxy
GEOIP,ZA,Proxy
GEOIP,ZM,Proxy
GEOIP,ZW,Proxy
IP-CIDR,91.108.4.0/22,Proxy,no-resolve

IP-CIDR,91.108.56.0/22,Proxy,no-resolve

IP-CIDR,109.239.140.0/24,Proxy,no-resolve

IP-CIDR,149.154.160.0/20,Proxy,no-resolve

IP-CIDR,10.0.0.0/8,DIRECT

IP-CIDR,127.0.0.0/8,DIRECT

IP-CIDR,172.16.0.0/12,DIRECT

IP-CIDR,192.168.0.0/16,DIRECT

GEOIP,CN,DIRECT

FINAL,DIRECT
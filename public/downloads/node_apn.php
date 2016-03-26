<?php
$server =  $_GET["server"];
$arr=explode(":",$server,2);
$server=$arr[0];
$port = $arr[1];
$arr=explode(".",$server,3);
$name = strtoupper($arr[0]);

if($_GET['isp']=="cmcc")
{
	$apn="cmnet";
}

if($_GET['isp']=="cnunc")
{
	$apn="3gnet";
}

if($_GET['isp']=="ctnet")
{
	$apn="ctnet";
}
Header("Content-type: application/octet-stream");
Header("Content-Disposition: attachment; filename=".$server.".mobileconfig");
echo('
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>PayloadContent</key>
	<array>
		<dict>
			<key>PayloadContent</key>
			<array>
				<dict>
					<key>DefaultsData</key>
					<dict>
						<key>apns</key>
						<array>
							<dict>
								<key>apn</key>
								<string>'.$apn.'</string>
								<key>proxy</key>
								<string>'.$server.'</string>
								<key>proxyPort</key>
								<integer>'.$port.'</integer>
							</dict>
						</array>
					</dict>
					<key>DefaultsDomainName</key>
					<string>com.apple.managedCarrier</string>
				</dict>
			</array>
			<key>PayloadDescription</key>
			<string>提供对营运商“接入点名称”的自定义。</string>
			<key>PayloadDisplayName</key>
			<string>APN</string>
			<key>PayloadIdentifier</key>
			<string>com.tony.APNUNI'.$name.'.</string>
			<key>PayloadOrganization</key>
			<string>Tony</string>
			<key>PayloadType</key>
			<string>com.apple.apn.managed</string>
			<key>PayloadUUID</key>
			<string>7AC1FC00-7670-41CA-9EE1-4A5882DBD'.rand(100,999).'D</string>
			<key>PayloadVersion</key>
			<integer>1</integer>
		</dict>
	</array>
	<key>PayloadDescription</key>
	<string>APN配置文件</string>
	<key>PayloadDisplayName</key>
	<string>APN快速配置 - '.$name.' ('.$_GET["isp"].')</string>
	<key>PayloadIdentifier</key>
	<string>com.tony.APNUNI'.$name.'</string>
	<key>PayloadOrganization</key>
	<string>Tony</string>
	<key>PayloadRemovalDisallowed</key>
	<false/>
	<key>PayloadType</key>
	<string>Configuration</string>
	<key>PayloadUUID</key>
	<string>4C355D66-E72E-4DC8-864F-62C416015'.rand(100,999).'D</string>
	<key>PayloadVersion</key>
	<integer>1</integer>
</dict>
</plist>
'); 
?>


								
			






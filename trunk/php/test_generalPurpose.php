<?PHP
setlocale(LC_ALL, 'English_United States.65001');

function getField($pParams) { /* fieldName, pattern, method */
	$fieldName="";
	$pattern="safe";
	$method="post";
	$value="";
	$fParams = preg_split("/[,]/", $pParams);
	
	if (trim($fParams[0])!='') {
		$fieldName = trim($fParams[0]);
	}	

	if ((count($fParams)>1) AND (trim($fParams[1])!='')) {
		$pattern = trim($fParams[1]);
	}
	if ((count($fParams)>2) AND (trim($fParams[2])!='')) {
		$method = strtolower(trim($fParams[2]));
	}
	if ($method=="get") {
		if (isset($_GET[$fieldName])) {
			$value = $_GET[$fieldName];
		}
	}else{ // method=post
		if (isset($_POST[$fieldName])) {
			$value = $_POST[$fieldName];
		}	
	}
	
	switch ($pattern) {
		case "address":
			$regExPattern = "/^[a-zA-Z0-9\#\s\.\-;:,]{1,}$/";
			break;
		case "alpha":
			$regExPattern = "/^[a-zA-Z]+$/";
			break;
		case "alphanumeric":
			$regExPattern = "/^[a-zA-Z0-9]+$/";
			break;
		case "token":
			$regExPattern = "/^[a-zA-Z0-9\=]+$/";
			break;	
		case "userid":
			$regExPattern = "/^[a-zA-Z0-9\_\-\@\#\!\$\^\&\*\~]+$/";
			break;	
		case "safe":
			$regExPattern = "/^[a-zA-Z0-9\-\'\ \,\.]+$/";
			break;
		case "safetextarea":
			$regExPattern = "/^[a-zA-Z0-9 -\.\,\n\r\;\:\/\?\&\=]+$/";
			break;			
		case "binary":
			$regExPattern = "/^[0-1]+$/";
			break;
		case "creditcard":
			$regExPattern = "/^((4\d{3}|5[1-5]\d{2}|6011)[ -]*(\d{4}[ -]*\d{4}[ -]*\d{4}))|((34\d{2}|37\d{2})[ -]*(\d{6}[ -]*\d{5}))$/";
			break;			
		case "email":
			$regExPattern = "/^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/";
			break;			
		case "int":
			$regExPattern = "/^([-]*[1-9]+[0-9]*)|([0])$/";
			break;
		case "hex":
			$regExPattern = "/^[0-9A-F]+[0-9AF]*$/";
			break;
		case "mm/yyyyy":
			$regExPattern = "/(([0]*[1-9]{1})|([1]{1}[0-2]{1}))(\/{1})((19[0-9]{2})|([2-9]{1}[0-9]{3}))$/";
			break;
		case "mmddyyyy":
			$regExPattern = "/^((((0[13578])|([13578])|(1[02]))[\/](([1-9])|([0-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\/](([1-9])|([0-2][0-9])|(30)))|((2|02)[\/](([1-9])|([0-2][0-9]))))[\/]\d{4}$|^\d{4}$/";
			break;		
		case "number":
			$regExPattern = "/^([-+]*[1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]*[1-9]+)?)|([-+]*[1-9]+[0-9]*(\.[0-9]*[1-9]+)?)$/";
			break;
		case "numberpositive":
			$regExPattern = "/^([+]*[1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]*[1-9]+)?)$/";
			break;
		case "currency":
			$regExPattern = "/^(\$*[1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]{2})?)|(\({1}\$*[1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]{2})?\))$/";
			break;
		case "money":
			$regExPattern = "/^(\${1}[1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]{2})?)$/";
			break;
		case "name":
			$regExPattern = "/^[a-zA-Z\-\'\ ]+$/";
			break;	
		case "ssn":
			$regExPattern = "/^(?!000)(?!666)([0-6]\d{2}|7(?:[0-6]\d|7[012]))[ -]?(?!00)(\d\d){1}[ -]?(?!0000)(\d{4})$/";
			break;
		case "state":
			$regExPattern = "/^((?:A[LKSZRAP]|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEHINOPST]|N[CDEHJMVY]|O[HKR]|P[ARW]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])|(?:A[lkszrap]|C[aot]|D[ec]|F[lm]|G[au]|Hi|I[adln]|K[sy]|La|M[adehinopst]|N[cdehjmvy]|O[hkr]|P[arw]|Ri|S[cd]|T[nx]|Ut|V[ait]|W[aivy])|(?:a[lkszrap]|c[aot]|d[ec]|f[lm]|g[au]|hi|i[adln]|k[sy]|la|m[adehinopst]|n[cdehjmvy]|o[hkr]|p[arw]|ri|s[cd]|t[nx]|ut|v[ait]|w[aivy]))\.?$/";
			break;
		case "password8to32an":
			$regExPattern = "/^(?=[a-zA-Z]*\d)(?=[0-9A-Z]*[a-z])(?=[0-9a-z]*[A-Z])(?!.*\s).{8,32}$/";
			break;
		case "password8to32ans":
			$regExPattern = "/^(?=.*\d|\S)(?=.*[a-z])(?=.*[A-Z]).{8,32}$/";
			break;
		case "password8to16an":
			$regExPattern = "/^(?=[a-zA-Z]*\d)(?=[0-9A-Z]*[a-z])(?=[0-9a-z]*[A-Z])(?!.*\s).{8,16}$/";
			break;
		case "password8to16ans":
			$regExPattern = "/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*[\s'<>]).{8,16}$/";
			break;
		case "phoneany7":
			$regExPattern = "/^\d{3}.*\d{4}$/";
			break;
		case "phoneeu7":
			$regExPattern = "/^\d{3}\.*\d{4}$/";
			break;
		case "phoneus10":
			$regExPattern = "/^(\(*\d{3}\)*\s*\-*\d{3}\s*\-*\d{4}\s*)|(\d{3}\.*\d{3}\.*\d{4}\s*)$/";
			break;
		case "phoneeu10":
			$regExPattern = "/^\d{3}\.*\d{3}\.*\d{4}$/";
			break;
		case "urlpath":
			$regExPattern = "/^[a-zA-Z0-9\/\%\_]+\.(php|asp|htm|html)$/";
			break;
		case "ipaddress":
			$regExPattern = "/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/";
			break;
		case "useragent":
			$regExPattern = "/^[a-zA-Z0-9 \;\:\.\-\)\(\/\@\]\[\+\~\_\,\?\=\{\}\*\|\&\#\!]+$/";
			break;
		case "zipcode":
			$regExPattern = "(^(?!0{5})(\d{5})(?!-?0{4})(-?\d{4})?$)";
			break;	
	}

	//echo $regExPattern ." XXX ". $value;
	preg_match($regExPattern, $value, $arr);
	//echo "filter matched array count:: " . count($arr) . "<br>"; 
	//if you have caught something as alpha or num, return it
	if (!empty($arr)) return $arr[0];
	//return $value;
}



function getGUID(){
    if (function_exists('com_create_guid')){
        return com_create_guid();
    }else{
        mt_srand((double)microtime()*10000);//optional for php 4.2.0 and up.
        $charid = strtoupper(md5(uniqid(rand(), true)));
        $hyphen = chr(45);// "-"
        $uuid = chr(123)// "{"
                .substr($charid, 0, 8).$hyphen
                .substr($charid, 8, 4).$hyphen
                .substr($charid,12, 4).$hyphen
                .substr($charid,16, 4).$hyphen
                .substr($charid,20,12)
                .chr(125);// "}"
        return $uuid;
    }
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">

<head>
<title>Test General Purpose</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="expires" content="now-1">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="content-language" content="en">
<meta name="language" content="en-US">
<meta name="author" content="Roderick Divilbiss">
<meta name="copyright" content="© EE Collaborative Login System">
<meta name=robots content="index, follow">
</head>
<body>
<div id="results">
<?PHP
if (isset($_POST["pattern"])) {
	$pattern = $_POST["pattern"];
        $out = getField("tField,".$pattern);
        if ($out!="") {
            echo "GOOD: " . $out;
        }else{
            echo "BAD INPUT: Discarded";
        }
}
?>
</div>
<form name="frm" action="test_generalPurpose.php" method="post">
<p><input id="tField" name="tField" type="text" size="30" value="<?PHP echo htmlentities($out);?>">&nbsp;
<select id="pattern" name="pattern" size="1">
	<option <?PHP if ($pattern=="alpha") { echo "selected "; }?>value="alpha">alpha</option>
	<option <?PHP if ($pattern=="alphanumeric") { echo "selected "; }?>value="alphanumeric">alphanumeric</option>
	<option <?PHP if ($pattern=="token") { echo "selected "; }?>value="token">token</option>
	<option <?PHP if ($pattern=="userid") { echo "selected "; }?>value="userid">userid</option>
	<option <?PHP if ($pattern=="safe") { echo "selected "; }?>value="safe">safe</option>
	<option <?PHP if ($pattern=="email") { echo "selected "; }?>value="email">email</option>
	<option <?PHP if ($pattern=="name") { echo "selected "; }?>value="name">name</option>
	<option <?PHP if ($pattern=="urlpath") { echo "selected "; }?>value="urlpath">urlpath</option>
	<option <?PHP if ($pattern=="ipaddress") { echo "selected "; }?>value="ipaddress">ipaddress</option>
	<option <?PHP if ($pattern=="useragent") { echo "selected "; }?>value="useragent">userageant</option>
	<option <?PHP if ($pattern=="zipcode") { echo "selected "; }?>value="zipcode">zipcode</option>
</select><br>
<input type="submit" value="Submit"></p>
</form>

</body>
</html>
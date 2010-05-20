<?php
$entropy="";
$lowLetters="";
$upLetters="";
$symbols="";
$digits="";
$totalChars="";
$lowLettersChars="";
$upLettersChars="";
$symbolChars="";
$digitChars="";
$otherChars="";


$lowLetters = "abcdefghijklmnopqrstuvwxyz";
$upLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
$symbols = "~`!@#$%^&*()-_+=";
$digits = "1234567890";

$totalChars = 95;
$lowLettersChars = strlen($lowLetters);
$upLettersChars = strlen($upLetters);
$symbolChars = strlen($symbols);
$digitChars = strlen($digits);
$otherChars = $totalChars - ($lowLettersChars + $upLettersChars + $symbolChars + $digitChars);

function getEntropy($pPass) {
	global $lowLetters;
	global $upLetters;
	global $symbols;
	global $digits;
	global $totalChars;
	global $lowLettersChars;
	global $upLettersChars;
	global $symbolChars;
	global $digitChars;
	global $otherChars;
	$hasLower="";
	$hasUpper="";
	$hasSymbol="";
	$hasDigit="";
	$hasOther="";
	$idx="";
	$char="";
	$bits="";
	$match="";
	$domain="";

    if (strlen($pPass) < 0) {
        return 0;
    }else{
    	$hasLower = false;
    	$hasUpper = false;
    	$hasSymbol = false;
    	$hasDigit = false;
    	$hasOther = false;
    	$domain = 0;
		
    	for ($idx=0; $idx < strlen($pPass); $idx++) {
        	$char = substr($pPass,$idx,1);
			$match = "";

        	if (strpos($lowLetters,$char)!==false) {
            	$hasLower = true;
            	$match = true;
            }	
            if (strpos($upLetters,$char)!==false) {
            	$hasUpper = true;
            	$match = true;
            }
            if (strpos($digits,$char)!==false) {
            	$hasDigit = true;
            	$match = true;
            }
            if (strpos($symbols,$char)!==false) {
            	$hasSymbol = true;
            	$match = true;
            }
            if ($match=="") {
            	$hasOther = true;
            }            
		}
		   
	    if ($hasLower) {
        	$domain += $lowLettersChars;
        }
    	if ($hasUpper) {
        	$domain += $upLettersChars;
    	}
    	if ($hasDigit) {
        	$domain += $digitChars;
    	}
    	if ($hasSymbol) {
        	$domain += $symbolChars;
    	}
    	if ($hasOther) {
        	$domain += $otherChars;
        }
        
        $bits = floor(log($domain) * (strlen($pPass))/log(2));	
    	return $bits;
    }
}

// echo getEntropy("P@ssw0rd"); /* 50 */
?>
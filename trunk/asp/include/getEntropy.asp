<%
Dim entropy, lowLetters, upLetters, symbols, digits, totalChars, lowLettersChars, upLettersChars, symbolChars, digitChars, otherChars


lowLetters = "abcdefghijklmnopqrstuvwxyz"
upLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
symbols = "~`!@#$%^&*()-_+="
digits = "1234567890"

totalChars = 95
lowLettersChars = Len(lowLetters)
upLettersChars = Len(upLetters)
symbolChars = Len(symbols)
digitChars = Len(digits)
otherChars = totalChars - (lowLettersChars + upLettersChars + symbolChars + digitChars)

Function getEntropy(pPass)
	Dim hasLower, hasUpper, hasSymbol, hasDigit
	Dim hasOther, idx, char, bits, match, domain

    If (Len(pPass) < 0) Then
        getEntropy = 0
    Else
    	hasLower = False
    	hasUpper = False
    	hasSymbol = False
    	hasDigit = False
    	hasOther = False
    	domain = 0
		
    	For idx = 1 to Len(pPass)
        	char = Mid(pPass,idx,1)
			match = ""
			
        	If InStr(lowLetters,char) > 0 Then
            	hasLower = True
            	match = True
            End If	
            If InStr(upLetters,char) > 0 Then
            	hasUpper = True
            	match = True
            End If
            If InStr(digits,char) > 0 Then
            	hasDigit = True
            	match = True
            End If
            If InStr(symbols,char) > 0 Then
            	hasSymbol = True
            	match = True
            End If
            If match="" Then
            	hasOther = True
            End If            
		Next
		   
	    If (hasLower) Then
        	domain = domain + lowLettersChars
        End If
    	If (hasUpper) Then
        	domain = domain + upLettersChars
    	End If
    	If (hasDigit) Then
        	domain = domain + digitChars
    	End If
    	If (hasSymbol) Then
        	domain = domain + symbolChars
    	End If
    	If (hasOther) Then
        	domain = domain + otherChars
        End If
        
        bits = Log(domain) * (Len(pPass) / Log(2))	
    	getEntropy = Int(bits)
    End If
End Function
%>
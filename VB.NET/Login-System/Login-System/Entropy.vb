' $Id$

Public Class Entropy
    Public Shared Function getEntropy(ByVal pPass As String) As Double
        Dim lowLetters, upLetters, symbols, digits As String
        Dim totalChars, lowLettersChars, upLettersChars, symbolChars, digitChars, otherChars As Integer


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


        Dim hasLower, hasUpper, hasSymbol, hasDigit As Boolean
        Dim hasOther As Boolean, idx As Integer, c As Char, match As Boolean, domain As Integer

        If (Len(pPass) < 0) Then
            getEntropy = 0
        Else
            hasLower = False
            hasUpper = False
            hasSymbol = False
            hasDigit = False
            hasOther = False
            domain = 0

            For idx = 0 To pPass.Length - 1
                c = pPass.Chars(idx)
                match = False

                If InStr(lowLetters, c) > 0 Then
                    hasLower = True
                    match = True
                End If
                If InStr(upLetters, c) > 0 Then
                    hasUpper = True
                    match = True
                End If
                If InStr(digits, c) > 0 Then
                    hasDigit = True
                    match = True
                End If
                If InStr(symbols, c) > 0 Then
                    hasSymbol = True
                    match = True
                End If
                If match = False Then
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

            Return Int(Math.Log(domain) * (Len(pPass) / Math.Log(2)))

        End If
    End Function
End Class

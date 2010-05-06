Module hashSHA1
    Function HashEncode(ByVal ToHash As String) As String
        Dim Sha1Obj As New System.Security.Cryptography.SHA1CryptoServiceProvider
        Dim bytes() As Byte = System.Text.Encoding.UTF8.GetBytes(ToHash)

        bytes = Sha1Obj.ComputeHash(bytes)
        Dim Result As New System.Text.StringBuilder

        For Each b As Byte In bytes
            Result.Append(b.ToString("X2"))
        Next

        Return Result.ToString.Substring(0, 40)
    End Function

End Module

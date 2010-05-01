Public Module LoginResources
    ''' <summary>
    ''' Short wrapper function to get resource strings from the loginglobals class
    ''' </summary>
    ''' <param name="Key"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ResString(ByVal Key As String) As String
        Return CStr(HttpContext.GetGlobalResourceObject("LoginGlobals", Key))
    End Function
End Module

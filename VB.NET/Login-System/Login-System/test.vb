' $Id$
Imports System.Data

Module test
    Public Sub test()
        Using da As New DataAccess
            Dim ds As DataSet = da.GetDataset("Select * from securityquestions")
            For Each row As DataRow In ds.Tables(0).Rows
                Debug.WriteLine(row(1))
            Next
        End Using
    End Sub


End Module

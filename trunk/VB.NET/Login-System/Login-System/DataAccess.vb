' $Id$
Imports System.Data.Common
Imports System.Data
''' <summary>
''' All data access is done through this class.  Has methods to execute SQL commands and retrieve
''' data as generic dataset.
''' </summary>
''' <remarks></remarks>
Public Class DataAccess
    Implements IDisposable

    Private mConn As DbConnection
    Private mFactory As DbProviderFactory

#Region "Constructors"
    ''' <summary>
    ''' Creates new providerfactory and connection based on lg_database switch in .config
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub New()
        Dim Database As String = ConfigurationManager.AppSettings.Item("lg_database")
        Dim Provider As String = ConfigurationManager.ConnectionStrings(Database).ProviderName
        Dim ConnectionString As String = ConfigurationManager.ConnectionStrings(Database).ConnectionString
        mFactory = DbProviderFactories.GetFactory(Provider)
        mConn = mFactory.CreateConnection
        mConn.ConnectionString = ConnectionString
    End Sub
#End Region


#Region "Instance Methods"
    ''' <summary>
    ''' Execute a sql statement that does not return resultset
    ''' </summary>
    ''' <param name="Sql"></param>
    ''' <remarks></remarks>
    Public Function ExecuteNonQuery(ByVal Sql As String) As Integer
        mConn.Open()
        Dim NumAffected As Integer = 0
        Using cmd As DbCommand = mConn.CreateCommand()
            cmd.CommandText = Sql
            cmd.CommandType = CommandType.Text
            NumAffected = cmd.ExecuteNonQuery()
        End Using
        mConn.Close()
        Return NumAffected
    End Function
    ''' <summary>
    ''' Execute a sql statement with parameters that does not return a resultset
    ''' </summary>
    ''' <param name="Sql"></param>
    ''' <param name="Parms"></param>
    ''' <remarks></remarks>
    Public Function ExecuteNonQuery(ByVal Sql As String, ByVal Parms() As DbParameter) As Integer
        mConn.Open()
        Dim NumAffected As Integer = 0
        Using cmd As DbCommand = mConn.CreateCommand()
            cmd.CommandText = Sql
            cmd.CommandType = CommandType.Text
            For Each p As DbParameter In Parms
                cmd.Parameters.Add(p)
            Next
            NumAffected = cmd.ExecuteNonQuery()
        End Using
        mConn.Close()
        Return NumAffected
    End Function
    ''' <summary>
    ''' Execute a sql statement and return a single integer.  Eg. Identity
    ''' </summary>
    ''' <param name="Sql"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ExecuteScalar(ByVal Sql As String) As Integer
        Dim RetVal As Integer
        mConn.Open()
        Using cmd As DbCommand = mConn.CreateCommand()
            cmd.CommandText = Sql
            cmd.CommandType = CommandType.Text
            RetVal = CInt(cmd.ExecuteScalar())
        End Using
        mConn.Close()
        Return RetVal
    End Function
    ''' <summary>
    ''' Execute a sql statement with parameters and return a single integer.  Eg. Identity
    ''' </summary>
    ''' <param name="Sql"></param>
    ''' <param name="Parms"></param>
    ''' <remarks></remarks>
    Public Function ExecuteScalar(ByVal Sql As String, ByVal Parms() As DbParameter) As Integer
        Dim RetVal As Integer
        mConn.Open()
        Using cmd As DbCommand = mConn.CreateCommand()
            cmd.CommandText = Sql
            cmd.CommandType = CommandType.Text
            For Each p As DbParameter In Parms
                cmd.Parameters.Add(p)
            Next
            RetVal = CInt(cmd.ExecuteScalar())
        End Using
        mConn.Close()
        Return RetVal
    End Function

    ''' <summary>
    ''' Execute a sql statement and return a resultset
    ''' </summary>
    ''' <param name="Sql"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function GetDataset(ByVal Sql As String) As DataSet
        mConn.Open()
        Dim ds As New DataSet
        Using da As DbDataAdapter = mFactory.CreateDataAdapter
            Using cmd As DbCommand = mConn.CreateCommand()
                cmd.CommandText = Sql
                cmd.CommandType = CommandType.Text
                da.SelectCommand = cmd
                da.Fill(ds)
            End Using
        End Using
        mConn.Close()
        Return ds
    End Function
    ''' <summary>
    ''' Execute a sql statement with parameters and return a resultset
    ''' </summary>
    ''' <param name="Sql"></param>
    ''' <param name="Parms"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function GetDataset(ByVal Sql As String, ByVal Parms() As DbParameter) As DataSet
        mConn.Open()
        Dim ds As New DataSet
        Using da As DbDataAdapter = mFactory.CreateDataAdapter
            Using cmd As DbCommand = mConn.CreateCommand()
                cmd.CommandText = Sql
                cmd.CommandType = CommandType.Text
                For Each p As DbParameter In Parms
                    cmd.Parameters.Add(p)
                Next
                da.SelectCommand = cmd
                da.Fill(ds)
            End Using
        End Using
        mConn.Close()
        Return ds
    End Function

    Public Function Factory() As DbProviderFactory
        Return mFactory
    End Function

    Public Function ParmWithValue(ByVal Name As String, ByVal Value As Object, Optional ByVal Direction As Data.ParameterDirection = ParameterDirection.Input) As DbParameter
        Dim Parm As DbParameter = mFactory.CreateParameter
        Parm.ParameterName = Name
        Parm.Value = Value
        Parm.Direction = Direction
        Return Parm
    End Function


#End Region


#Region "IDisposable"
    Private disposedValue As Boolean = False        ' To detect redundant calls
    Protected Overridable Sub Dispose(ByVal disposing As Boolean)
        If Not Me.disposedValue Then
            If disposing Then
                mConn.Dispose()
            End If
        End If
        Me.disposedValue = True
    End Sub
    Public Sub Dispose() Implements IDisposable.Dispose
        ' Do not change this code.  Put cleanup code in Dispose(ByVal disposing As Boolean) above.
        Dispose(True)
        GC.SuppressFinalize(Me)
    End Sub
#End Region

End Class

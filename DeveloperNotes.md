Code Review Guidelines and General Considerations

# Introduction #

There are ancillary issues of concern in the project


# Details #

Code Review:



Check points:

  * Locale set - loginGlobals?
  * Character set UTF-8 both in server side code and headers
  * Input canoncalized
  * Input filtered
  * Input escaped if necessary for database (may not be needed given the following
  * Parameterized SQL used
  * Stored procedures used

  * userid and password never leaked in a page or in an email


Database notes:

MS Access has two oledb providers, Jet 4 for 2003 and earlier
> Client Access Services for 2007 and later.
For the test system:

MS Access has no comments and does not allow stacked queries.
CONNECTION\_STRING = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source='D:\Hosting\4707086\html\login-system\asp\database\login\_system.mdb'"



MySql does have comments but no stacked queries.
MySql\_real\_escape\_string will not stop all SQL Injection so parameterized SQL is required.

MS SQL has comments and accepts stacked queries. Care must be taken if stored procedures are used and we will still need to use parameterized SQL.

Even though other major frameworks may offer a secure authetication implementation they may not offer all functions outlined in this projects design requirements. Therefore codebase relases post 1.0 may be developed in .Net and Zend.  The initial release will be primarily procedural so as to be easily assimilated by general developers and not restricted to those developers who do not use code frameworks.
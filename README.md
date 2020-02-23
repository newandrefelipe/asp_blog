# ASP Blog

Small blog built using VBScript in Classic ASP and MySQL/SQLite.

## Installation

1. Install the ODBC SQLite Driver available on database/sqlite. I installed the 32 bit version (file sqliteodbc.exe).
2. Or install the ODBC MySQL Driver available on database/mysql.
3. You need to configure the ODBC Driver on Windows. On Start Menu, type "ODBC". Select "ODBC Data Sources (32 bit)". On "System DNS" tab, click in "Add", select "MySQL ODBC 8.0 ANSI Driver". Fill in the fields "TCP / IP Server", "User" and "Password". "Database" is not necessary.
4. Configure the site on IIS.

## Usage

1. Open http://localhost:[port]/default.asp
2. The default user and password is:

- Login: adm
- Password: adm

## License

[MIT](https://choosealicense.com/licenses/mit/)

# Azure SQL Server VM Deployment with Terraform

This Terraform project automates the deployment of a SQL Server 2022 virtual machine on Microsoft Azure, including all necessary networking components and security configurations.

## Features

- **SQL Server 2022** on Windows Server 2022
- **Marketplace Image** Pre-installed with SQL Server 2022 (Developer Edition)
- **Terraform Cloud account** (for remote state management)

## Usage

Use AdventureWorks database from Microsoft for Sample data.
[AdventureWorks2022.bak](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak)

Import using T-SQL via Azure Data Studio or SQL Server Management Studio.

```sql
USE [master];
GO
RESTORE DATABASE [AdventureWorks2022]
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\AdventureWorks2022.bak'
WITH
    FILE = 1,
    NOUNLOAD,
    STATS = 5;
GO
```
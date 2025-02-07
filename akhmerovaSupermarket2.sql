USE [master]
GO
/****** Object:  Database [Supermarket]    Script Date: 09.11.2024 17:07:52 ******/
CREATE DATABASE [Supermarket]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Supermarket', FILENAME = N'D:\Софт\MSSQL15.SQLEXPRESS\MSSQL\DATA\Supermarket.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Supermarket_log', FILENAME = N'D:\Софт\MSSQL15.SQLEXPRESS\MSSQL\DATA\Supermarket_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Supermarket].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Supermarket] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Supermarket] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Supermarket] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Supermarket] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Supermarket] SET ARITHABORT OFF 
GO
ALTER DATABASE [Supermarket] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Supermarket] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Supermarket] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Supermarket] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Supermarket] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Supermarket] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Supermarket] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Supermarket] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Supermarket] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Supermarket] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Supermarket] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Supermarket] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Supermarket] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Supermarket] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Supermarket] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Supermarket] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Supermarket] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Supermarket] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Supermarket] SET  MULTI_USER 
GO
ALTER DATABASE [Supermarket] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Supermarket] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Supermarket] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Supermarket] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Supermarket] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Supermarket]
GO
/****** Object:  User [SupermarketUser3]    Script Date: 09.11.2024 17:07:52 ******/
CREATE USER [SupermarketUser3] FOR LOGIN [SupermarketLogin3] WITH DEFAULT_SCHEMA=[SupermarketUser3]
GO
/****** Object:  User [SupermarketUser2]    Script Date: 09.11.2024 17:07:52 ******/
CREATE USER [SupermarketUser2] FOR LOGIN [SupermarketLogin2] WITH DEFAULT_SCHEMA=[SupermarketUser2]
GO
/****** Object:  User [SupermarketUser1]    Script Date: 09.11.2024 17:07:52 ******/
CREATE USER [SupermarketUser1] FOR LOGIN [SupermarketLogin1] WITH DEFAULT_SCHEMA=[SupermarketUser1]
GO
/****** Object:  DatabaseRole [db_security]    Script Date: 09.11.2024 17:07:52 ******/
CREATE ROLE [db_security]
GO
/****** Object:  DatabaseRole [db_manager]    Script Date: 09.11.2024 17:07:52 ******/
CREATE ROLE [db_manager]
GO
/****** Object:  DatabaseRole [db_admin]    Script Date: 09.11.2024 17:07:52 ******/
CREATE ROLE [db_admin]
GO
ALTER ROLE [db_manager] ADD MEMBER [SupermarketUser3]
GO
ALTER ROLE [db_datareader] ADD MEMBER [SupermarketUser3]
GO
ALTER ROLE [db_security] ADD MEMBER [SupermarketUser2]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [SupermarketUser2]
GO
ALTER ROLE [db_admin] ADD MEMBER [SupermarketUser1]
GO
ALTER ROLE [db_owner] ADD MEMBER [SupermarketUser1]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [db_security]
GO
ALTER ROLE [db_datareader] ADD MEMBER [db_manager]
GO
ALTER ROLE [db_owner] ADD MEMBER [db_admin]
GO
/****** Object:  Schema [db_admin]    Script Date: 09.11.2024 17:07:52 ******/
CREATE SCHEMA [db_admin]
GO
/****** Object:  Schema [db_manager]    Script Date: 09.11.2024 17:07:52 ******/
CREATE SCHEMA [db_manager]
GO
/****** Object:  Schema [db_security]    Script Date: 09.11.2024 17:07:52 ******/
CREATE SCHEMA [db_security]
GO
/****** Object:  Schema [SupermarketUser1]    Script Date: 09.11.2024 17:07:52 ******/
CREATE SCHEMA [SupermarketUser1]
GO
/****** Object:  Schema [SupermarketUser2]    Script Date: 09.11.2024 17:07:52 ******/
CREATE SCHEMA [SupermarketUser2]
GO
/****** Object:  Schema [SupermarketUser3]    Script Date: 09.11.2024 17:07:52 ******/
CREATE SCHEMA [SupermarketUser3]
GO
/****** Object:  UserDefinedFunction [dbo].[Calculator]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Calculator](@Opd1 bigint, @Opd2 bigint, @Oprt char (1) = '*')
RETURNS bigint
AS BEGIN
    DECLARE @Result bigint

    IF @Oprt = '/' AND @Opd2 = 0
    BEGIN
        SET @Result = NULL
    END
    ELSE
    BEGIN
        SET @Result = CASE @Oprt
            WHEN '+' THEN @Opd1 + @Opd2
            WHEN '-' THEN @Opd1 - @Opd2
            WHEN '*' THEN @Opd1 * @Opd2
            WHEN '/' THEN @Opd1 / @Opd2
            ELSE 0
        END
    END

    RETURN @Result
END


GO
/****** Object:  UserDefinedFunction [dbo].[TotalSalary]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[TotalSalary]()
returns int
as
begin
    declare @TotalSalary int
    select @TotalSalary = sum([Сумма ставки]) from Сотрудники s, Должности d where s.[Должность] = d.[Номер должности]
    return @TotalSalary
end
GO
/****** Object:  Table [dbo].[Должности]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Должности](
	[Номер должности] [int] IDENTITY(1,1) NOT NULL,
	[Название должности] [nvarchar](50) NOT NULL,
	[Сумма ставки] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Должности] PRIMARY KEY CLUSTERED 
(
	[Номер должности] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Отделы]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Отделы](
	[Номер отдела] [int] IDENTITY(1,1) NOT NULL,
	[Название отдела] [nvarchar](50) NOT NULL,
	[Кол-во прилавков] [int] NOT NULL,
	[Кол-во продавцов] [int] NOT NULL,
	[Номер зала] [int] NOT NULL,
 CONSTRAINT [PK_Отделы] PRIMARY KEY CLUSTERED 
(
	[Номер отдела] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Продажи товаров]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Продажи товаров](
	[Номер продажи] [int] IDENTITY(1,1) NOT NULL,
	[Сотрудник] [int] NOT NULL,
	[Дата] [date] NOT NULL,
	[Время] [time](7) NOT NULL,
	[Кол-во] [int] NOT NULL,
	[Товар] [int] NOT NULL,
 CONSTRAINT [PK_Продажа товаров] PRIMARY KEY CLUSTERED 
(
	[Номер продажи] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Сотрудники]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Сотрудники](
	[Номер сотрудника] [int] IDENTITY(1,1) NOT NULL,
	[Фамилия] [nvarchar](50) NOT NULL,
	[Имя] [nvarchar](50) NOT NULL,
	[Отчество] [nvarchar](50) NULL,
	[Отдел] [int] NOT NULL,
	[Год рождения] [date] NOT NULL,
	[Год поступления на работу] [date] NOT NULL,
	[Должность] [int] NOT NULL,
	[Пол] [nvarchar](1) NOT NULL,
	[Адрес] [nvarchar](100) NOT NULL,
	[Город] [nvarchar](50) NOT NULL,
	[Телефон] [nvarchar](50) NOT NULL,
	[Стаж]  AS (case when datepart(month,getdate())>datepart(month,[Год поступления на работу]) OR datepart(month,getdate())=datepart(month,[Год поступления на работу]) AND datepart(day,getdate())>=datepart(day,[Год поступления на работу]) then datepart(year,getdate())-datepart(year,[Год поступления на работу]) else (datepart(year,getdate())-datepart(year,[Год поступления на работу]))-(1) end),
	[Фото_Сотрудники] [nvarchar](50) NULL,
 CONSTRAINT [PK_Сотрудники] PRIMARY KEY CLUSTERED 
(
	[Номер сотрудника] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Товары]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Товары](
	[Номер товара] [int] IDENTITY(1,1) NOT NULL,
	[Название товара] [nvarchar](50) NOT NULL,
	[Отдел] [int] NOT NULL,
	[Страна-производитель] [nvarchar](50) NOT NULL,
	[Условия хранения] [nvarchar](50) NULL,
	[Сроки хранения] [varchar](30) NULL,
	[Цена] [decimal](18, 2) NOT NULL,
	[Фото_Товары] [nvarchar](50) NULL,
 CONSTRAINT [PK_Товары] PRIMARY KEY CLUSTERED 
(
	[Номер товара] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[SortedProducts]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[SortedProducts]()
returns table
as
return (
    select * from Товары order by [Название товара] OFFSET 0 ROWS
)
GO
/****** Object:  View [dbo].[View_1]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT dbo.Должности.[Название должности], dbo.Сотрудники.Фамилия, dbo.Сотрудники.Имя, dbo.Сотрудники.Отчество
FROM     dbo.Сотрудники INNER JOIN
                  dbo.Должности ON dbo.Сотрудники.Должность = dbo.Должности.[Номер должности]
GO
/****** Object:  View [dbo].[View_2]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_2]
AS
SELECT dbo.Должности.[Название должности], COUNT(*) AS [Количество сотрудников определенной должности]
FROM     dbo.Сотрудники INNER JOIN
                  dbo.Должности ON dbo.Сотрудники.Должность = dbo.Должности.[Номер должности]
GROUP BY dbo.Должности.[Название должности]
GO
/****** Object:  View [dbo].[View_3]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[View_3]
as
select Товары.[Название товара], Товары.[Условия хранения],
Отделы.[Название отдела], [Продажи товаров].[Сотрудник] 
from [Продажи товаров], Товары, Отделы
where Товары.[Номер товара]=[Продажи товаров].[Товар] and Отделы.[Номер отдела]=Товары.Отдел










GO
/****** Object:  View [dbo].[View_4]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[View_4]
as
select [Номер товара], [Название товара], [Условия хранения] from Товары
where ([Условия хранения]='хранить в морозильнике' or [Условия хранения]='хранить в холодильнике')
with check option
GO
SET IDENTITY_INSERT [dbo].[Должности] ON 

INSERT [dbo].[Должности] ([Номер должности], [Название должности], [Сумма ставки]) VALUES (1, N'Менеджер по закупкам', CAST(49387.72 AS Decimal(18, 2)))
INSERT [dbo].[Должности] ([Номер должности], [Название должности], [Сумма ставки]) VALUES (2, N'Продавец', CAST(30489.11 AS Decimal(18, 2)))
INSERT [dbo].[Должности] ([Номер должности], [Название должности], [Сумма ставки]) VALUES (3, N'Уборщик', CAST(27090.66 AS Decimal(18, 2)))
INSERT [dbo].[Должности] ([Номер должности], [Название должности], [Сумма ставки]) VALUES (4, N'Менеджер по маркетингу', CAST(44253.19 AS Decimal(18, 2)))
INSERT [dbo].[Должности] ([Номер должности], [Название должности], [Сумма ставки]) VALUES (5, N'Оператор склада', CAST(32098.33 AS Decimal(18, 2)))
INSERT [dbo].[Должности] ([Номер должности], [Название должности], [Сумма ставки]) VALUES (6, N'Бухгалтер', CAST(60983.12 AS Decimal(18, 2)))
INSERT [dbo].[Должности] ([Номер должности], [Название должности], [Сумма ставки]) VALUES (7, N'Менеджер по персоналу', CAST(47482.59 AS Decimal(18, 2)))
INSERT [dbo].[Должности] ([Номер должности], [Название должности], [Сумма ставки]) VALUES (8, N'Директор', CAST(69942.19 AS Decimal(18, 2)))
INSERT [dbo].[Должности] ([Номер должности], [Название должности], [Сумма ставки]) VALUES (9, N'Грузчик', CAST(35000.00 AS Decimal(18, 2)))
INSERT [dbo].[Должности] ([Номер должности], [Название должности], [Сумма ставки]) VALUES (10, N'Охранник', CAST(32186.21 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Должности] OFF
GO
SET IDENTITY_INSERT [dbo].[Отделы] ON 

INSERT [dbo].[Отделы] ([Номер отдела], [Название отдела], [Кол-во прилавков], [Кол-во продавцов], [Номер зала]) VALUES (1, N'Мясной отдел', 4, 5, 4)
INSERT [dbo].[Отделы] ([Номер отдела], [Название отдела], [Кол-во прилавков], [Кол-во продавцов], [Номер зала]) VALUES (2, N'Отдел овощей и фруктов', 11, 3, 10)
INSERT [dbo].[Отделы] ([Номер отдела], [Название отдела], [Кол-во прилавков], [Кол-во продавцов], [Номер зала]) VALUES (3, N'Молочный отдел', 11, 1, 10)
INSERT [dbo].[Отделы] ([Номер отдела], [Название отдела], [Кол-во прилавков], [Кол-во продавцов], [Номер зала]) VALUES (4, N'Отдел бытовой химии', 3, 2, 10)
INSERT [dbo].[Отделы] ([Номер отдела], [Название отдела], [Кол-во прилавков], [Кол-во продавцов], [Номер зала]) VALUES (5, N'Хлебный отдел', 6, 2, 9)
INSERT [dbo].[Отделы] ([Номер отдела], [Название отдела], [Кол-во прилавков], [Кол-во продавцов], [Номер зала]) VALUES (6, N'Рыбный отдел', 7, 4, 8)
INSERT [dbo].[Отделы] ([Номер отдела], [Название отдела], [Кол-во прилавков], [Кол-во продавцов], [Номер зала]) VALUES (7, N'Кондитерский отдел', 15, 2, 10)
INSERT [dbo].[Отделы] ([Номер отдела], [Название отдела], [Кол-во прилавков], [Кол-во продавцов], [Номер зала]) VALUES (8, N'Отдел детских товаров', 3, 3, 5)
INSERT [dbo].[Отделы] ([Номер отдела], [Название отдела], [Кол-во прилавков], [Кол-во продавцов], [Номер зала]) VALUES (9, N'Отдел специй и приправ', 6, 2, 8)
INSERT [dbo].[Отделы] ([Номер отдела], [Название отдела], [Кол-во прилавков], [Кол-во продавцов], [Номер зала]) VALUES (10, N'Отдел круп', 15, 1, 9)
SET IDENTITY_INSERT [dbo].[Отделы] OFF
GO
SET IDENTITY_INSERT [dbo].[Продажи товаров] ON 

INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (125, 47, CAST(N'2019-11-17' AS Date), CAST(N'20:14:00' AS Time), 6, 1)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (126, 48, CAST(N'2020-03-01' AS Date), CAST(N'13:29:00' AS Time), 7, 2)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (127, 49, CAST(N'2022-01-22' AS Date), CAST(N'11:32:00' AS Time), 2, 3)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (128, 50, CAST(N'2022-04-25' AS Date), CAST(N'20:06:00' AS Time), 5, 4)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (129, 51, CAST(N'2023-12-09' AS Date), CAST(N'10:25:00' AS Time), 2, 5)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (130, 52, CAST(N'2020-07-14' AS Date), CAST(N'13:10:00' AS Time), 5, 6)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (131, 53, CAST(N'2022-01-06' AS Date), CAST(N'16:59:00' AS Time), 1, 7)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (132, 54, CAST(N'2022-01-10' AS Date), CAST(N'13:39:00' AS Time), 1, 8)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (133, 55, CAST(N'2022-02-18' AS Date), CAST(N'09:53:00' AS Time), 4, 9)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (134, 56, CAST(N'2022-02-16' AS Date), CAST(N'12:58:00' AS Time), 6, 8)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (135, 57, CAST(N'2023-10-15' AS Date), CAST(N'09:32:00' AS Time), 6, 11)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (136, 58, CAST(N'2022-01-09' AS Date), CAST(N'18:00:00' AS Time), 4, 12)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (137, 59, CAST(N'2023-12-24' AS Date), CAST(N'10:02:00' AS Time), 4, 1)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (138, 60, CAST(N'2022-02-13' AS Date), CAST(N'10:52:00' AS Time), 1, 14)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (139, 61, CAST(N'2023-12-23' AS Date), CAST(N'19:40:00' AS Time), 1, 15)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (140, 62, CAST(N'2022-04-02' AS Date), CAST(N'17:24:00' AS Time), 7, 16)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (141, 63, CAST(N'2022-02-11' AS Date), CAST(N'16:02:00' AS Time), 3, 17)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (142, 64, CAST(N'2023-12-29' AS Date), CAST(N'16:47:00' AS Time), 6, 18)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (143, 47, CAST(N'2023-10-25' AS Date), CAST(N'14:58:00' AS Time), 3, 19)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (144, 66, CAST(N'2023-10-20' AS Date), CAST(N'16:28:00' AS Time), 4, 20)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (145, 67, CAST(N'2023-10-11' AS Date), CAST(N'18:26:00' AS Time), 5, 11)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (146, 68, CAST(N'2022-02-01' AS Date), CAST(N'09:47:00' AS Time), 1, 2)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (147, 69, CAST(N'2023-10-07' AS Date), CAST(N'12:07:00' AS Time), 7, 23)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (148, 70, CAST(N'2023-12-10' AS Date), CAST(N'10:45:00' AS Time), 5, 24)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (149, 71, CAST(N'2020-07-19' AS Date), CAST(N'18:54:00' AS Time), 2, 25)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (150, 47, CAST(N'2023-12-07' AS Date), CAST(N'12:20:00' AS Time), 1, 26)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (151, 48, CAST(N'2023-12-20' AS Date), CAST(N'11:35:00' AS Time), 1, 27)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (152, 47, CAST(N'2023-12-30' AS Date), CAST(N'11:22:00' AS Time), 5, 28)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (153, 50, CAST(N'2022-02-02' AS Date), CAST(N'18:39:00' AS Time), 4, 29)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (154, 51, CAST(N'2020-07-04' AS Date), CAST(N'18:40:00' AS Time), 5, 30)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (155, 53, CAST(N'2022-02-05' AS Date), CAST(N'18:41:00' AS Time), 1, 31)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (156, 53, CAST(N'2022-04-14' AS Date), CAST(N'18:42:00' AS Time), 7, 32)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (157, 54, CAST(N'2022-04-15' AS Date), CAST(N'18:43:00' AS Time), 4, 33)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (158, 67, CAST(N'2022-04-22' AS Date), CAST(N'18:44:00' AS Time), 5, 34)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (159, 56, CAST(N'2020-07-09' AS Date), CAST(N'17:44:00' AS Time), 6, 35)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (160, 57, CAST(N'2020-07-11' AS Date), CAST(N'18:44:00' AS Time), 3, 36)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (161, 58, CAST(N'2020-07-12' AS Date), CAST(N'19:44:00' AS Time), 1, 37)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (162, 59, CAST(N'2020-07-18' AS Date), CAST(N'20:44:00' AS Time), 4, 38)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (163, 60, CAST(N'2020-07-20' AS Date), CAST(N'11:45:00' AS Time), 3, 39)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (164, 61, CAST(N'2020-07-21' AS Date), CAST(N'12:45:00' AS Time), 1, 40)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (165, 56, CAST(N'2023-01-07' AS Date), CAST(N'12:12:00' AS Time), 2, 35)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (167, 56, CAST(N'2020-09-18' AS Date), CAST(N'13:09:00' AS Time), 1, 35)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (169, 57, CAST(N'2024-03-30' AS Date), CAST(N'20:45:00' AS Time), 4, 6)
INSERT [dbo].[Продажи товаров] ([Номер продажи], [Сотрудник], [Дата], [Время], [Кол-во], [Товар]) VALUES (170, 68, CAST(N'2022-02-01' AS Date), CAST(N'09:47:00' AS Time), 1, 2)
SET IDENTITY_INSERT [dbo].[Продажи товаров] OFF
GO
SET IDENTITY_INSERT [dbo].[Сотрудники] ON 

INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (26, N'Иванов', N'Иван', N'Иванович', 6, CAST(N'1971-08-03' AS Date), CAST(N'2011-09-13' AS Date), 8, N'М', N'ул. Ленина 10 кв. 5', N'Уфа', N'79964551019', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (33, N'Петров', N'Петр', N'Петрович', 6, CAST(N'1981-08-03' AS Date), CAST(N'2013-03-03' AS Date), 1, N'М', N'ул. Пушкина 25 кв. 12', N'Уфа', N'79964401520', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (34, N'Смирнова', N'Ольга', N'Алексеевна', 3, CAST(N'1999-07-12' AS Date), CAST(N'2004-04-18' AS Date), 4, N'Ж', N'ул. Гагарина 7 кв. 3', N'Уфа', N'79966139499', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (35, N'Соколов', N'Александр', N'Александрович', 10, CAST(N'1992-10-13' AS Date), CAST(N'2023-08-04' AS Date), 5, N'М', N'ул. Кирова 15 кв. 8', N'Уфа', N'79998293223', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (36, N'Кузнецова', N'Екатерина', N'Ивановна', 4, CAST(N'1970-02-13' AS Date), CAST(N'2016-07-04' AS Date), 5, N'Ж', N'ул. Мира 30 кв. 20', N'Уфа', N'79996955837', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (37, N'Васильев', N'Дмитрий', N'Сергеевич', 3, CAST(N'1973-11-20' AS Date), CAST(N'2008-10-29' AS Date), 5, N'М', N'ул. Советская 12 кв. 6', N'Уфа', N'79960969031', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (38, N'Морозова', N'Анна', N'Алексеевна', 5, CAST(N'1976-10-16' AS Date), CAST(N'2022-05-26' AS Date), 6, N'Ж', N'ул. Лермонтова 5 кв. 3', N'Уфа', N'79963466371', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (39, N'Новиков', N'Артем', N'Владимирович', 7, CAST(N'1990-06-09' AS Date), CAST(N'2023-07-14' AS Date), 7, N'М', N'ул. Фрунзе 20 кв. 10', N'Уфа', N'79960969443', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (40, N'Козлова', N'Мария', N'Андреевна', 1, CAST(N'1990-04-04' AS Date), CAST(N'2020-06-16' AS Date), 9, N'Ж', N'ул. Горького 18 кв. 9', N'Уфа', N'79289618054', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (41, N'Лебедев', N'Андрей', N'Викторович', 3, CAST(N'1970-02-14' AS Date), CAST(N'2017-06-19' AS Date), 9, N'М', N'ул. Чапаева 35 кв. 25', N'Уфа', N'79999951598', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (42, N'Семенова', N'Елена', N'Петровна', 1, CAST(N'1978-02-26' AS Date), CAST(N'2005-01-19' AS Date), 9, N'Ж', N'ул. Победы 8 кв. 4', N'Уфа', N'79966283552', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (43, N'Егоров', N'Илья', N'Алексеевич', 5, CAST(N'1969-09-15' AS Date), CAST(N'2019-01-03' AS Date), 10, N'М', N'ул. Калинина 22 кв. 11', N'Уфа', N'79966286403', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (44, N'Павлова', N'Татьяна', N'Дмитриевна', 9, CAST(N'2006-01-04' AS Date), CAST(N'2014-07-13' AS Date), 3, N'Ж', N'ул. Жукова 10 кв. 5', N'Уфа', N'79998743057', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (45, N'Козлов', N'Максим', N'Михайлович', 3, CAST(N'1993-01-27' AS Date), CAST(N'2013-02-09' AS Date), 10, N'М', N'ул. Свердлова 20 кв. 15', N'Уфа', N'79993974810', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (46, N'Волкова', N'Анастасия', N'Александровна', 10, CAST(N'1981-12-11' AS Date), CAST(N'2014-10-28' AS Date), 3, N'Ж', N'ул. Ленинградская 15 кв. 7', N'Уфа', N'79993974692', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (47, N'Андреев', N'Владислав', N'Алексеевич', 1, CAST(N'2003-06-29' AS Date), CAST(N'2020-08-14' AS Date), 2, N'М', N'ул. Мичурина 5 кв. 2', N'Уфа', N'79050254741', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (48, N'Зайцева', N'Алина', N'Сергеевна', 1, CAST(N'1977-04-14' AS Date), CAST(N'2008-10-14' AS Date), 2, N'Ж', N'ул. Гоголя 18 кв. 9', N'Уфа', N'79998119971', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (49, N'Захаров', N'Никита', N'Иванович', 1, CAST(N'1999-02-16' AS Date), CAST(N'2012-07-10' AS Date), 2, N'М', N'ул. Карла Маркса 25 кв. 13', N'Уфа', N'79090843231', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (50, N'Михайлова', N'Олеся', N'Артемовна', 1, CAST(N'2000-05-09' AS Date), CAST(N'2021-09-28' AS Date), 2, N'Ж', N'ул. Тургенева 30 кв. 20', N'Уфа', N'79998543899', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (51, N'Сорокин', N'Игорь', N'Викторович', 1, CAST(N'1976-02-25' AS Date), CAST(N'2012-03-22' AS Date), 2, N'М', N'ул. Достоевского 12 кв. 6', N'Уфа', N'79998545943', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (52, N'Воробьева', N'Анна', N'Сергеевна', 2, CAST(N'1979-08-04' AS Date), CAST(N'2005-01-13' AS Date), 2, N'Ж', N'ул. Маяковского 14 кв. 7', N'Уфа', N'79285306422', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (53, N'Федоров', N'Денис', N'Владимирович', 2, CAST(N'2004-06-07' AS Date), CAST(N'2014-10-19' AS Date), 2, N'М', N'ул. Пушкина 28 кв. 14', N'Уфа', N'79285821162', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (54, N'Морозов', N'Алексей', N'Николаевич', 2, CAST(N'1975-10-16' AS Date), CAST(N'2011-04-16' AS Date), 2, N'М', N'ул. Левитана кв. 20', N'Уфа', N'79288351009', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (55, N'Ковалева', N'Екатерина', N'Александровна', 3, CAST(N'1991-08-21' AS Date), CAST(N'2005-07-15' AS Date), 2, N'Ж', N'ул. Кирова 25 кв. 13', N'Уфа', N'79998235045', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (56, N'Николаев', N'Сергей', N'Иванович', 4, CAST(N'1971-01-09' AS Date), CAST(N'2008-09-28' AS Date), 2, N'М', N'ул. Мира 10 кв. 5', N'Уфа', N'79296434001', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (57, N'Полякова', N'Елена', NULL, 4, CAST(N'1974-10-10' AS Date), CAST(N'2014-02-11' AS Date), 2, N'Ж', N'ул. Советская 20 кв. 10', N'Уфа', N'79296417818', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (58, N'Дмитриев', N'Михаил', N'Викторович', 5, CAST(N'1989-08-08' AS Date), CAST(N'2000-10-10' AS Date), 2, N'М', N'ул. Лермонтова 8 кв. 4', N'Уфа', N'79365116159', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (59, N'Кузьмина', N'Анастасия', N'Игоревна', 5, CAST(N'2002-06-20' AS Date), CAST(N'2021-09-08' AS Date), 2, N'Ж', N'ул. Фрунзе 15 кв. 7', N'Уфа', N'79365273787', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (60, N'Савельев', N'Артем', N'Александрович', 6, CAST(N'1970-11-11' AS Date), CAST(N'2023-09-14' AS Date), 2, N'М', N'ул. Горького 12 кв. 6', N'Уфа', N'79994603302', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (61, N'Тимофеева', N'Мария', N'Дмитриевна', 6, CAST(N'1977-06-16' AS Date), CAST(N'2015-02-21' AS Date), 2, N'Ж', N'ул. Чапаева 30 кв. 20', N'Уфа', N'79295417653', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (62, N'Комаров', N'Антон', N'Петрович', 6, CAST(N'1982-10-12' AS Date), CAST(N'2012-03-16' AS Date), 2, N'М', N'ул. Ленина 18 кв. 9', N'Уфа', N'79295417243', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (63, N'Орлова', N'Виктория', NULL, 6, CAST(N'1980-05-18' AS Date), CAST(N'2009-03-25' AS Date), 2, N'Ж', N'ул. Пушкина 35 кв. 25', N'Уфа', N'79261353125', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (64, N'Федотов', N'Дмитрий', N'Васильевич', 7, CAST(N'1998-08-25' AS Date), CAST(N'2011-09-26' AS Date), 2, N'М', N'ул. Гагарина 20 кв. 10', N'Уфа', N'79250748961', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (65, N'Мартынова', N'Алина', N'Юрьевна', 7, CAST(N'2002-09-15' AS Date), CAST(N'2016-10-31' AS Date), 2, N'Ж', N'ул. Кирова 10 кв. 5', N'Уфа', N'79250636831', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (66, N'Лазарев', N'Игорь', N'Андреевич', 8, CAST(N'1975-10-30' AS Date), CAST(N'2007-12-20' AS Date), 2, N'М', N'ул. Мира 5 кв. 2', N'Уфа', N'79365298599', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (67, N'Куликова', N'Наталья', N'Владимировна', 8, CAST(N'1970-05-23' AS Date), CAST(N'2003-10-27' AS Date), 2, N'Ж', N'ул. Советская 18 кв. 9', N'Уфа', N'79295634003', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (68, N'Григорьев', N'Владислав', N'Максимович', 8, CAST(N'1998-11-21' AS Date), CAST(N'2018-02-24' AS Date), 2, N'М', N'ул. Лермонтова 25 кв. 13', N'Уфа', N'79365054127', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (69, N'Никитина', N'Ирина', N'Сергеевна', 9, CAST(N'1972-04-03' AS Date), CAST(N'2014-06-22' AS Date), 2, N'Ж', N'ул. Фрунзе 12 кв. 6', N'Уфа', N'79365155614', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (70, N'Крылов', N'Сергей', NULL, 9, CAST(N'2004-06-07' AS Date), CAST(N'2020-01-19' AS Date), 2, N'М', N'ул. Горького 35 кв. 25', N'Уфа', N'79365200642', NULL)
INSERT [dbo].[Сотрудники] ([Номер сотрудника], [Фамилия], [Имя], [Отчество], [Отдел], [Год рождения], [Год поступления на работу], [Должность], [Пол], [Адрес], [Город], [Телефон], [Фото_Сотрудники]) VALUES (71, N'Петрович', N'Анна', N'Андреевна', 10, CAST(N'1990-05-31' AS Date), CAST(N'2015-04-23' AS Date), 2, N'Ж', N'ул. Чапаева 15 кв. 8', N'Уфа', N'79365040620', NULL)
SET IDENTITY_INSERT [dbo].[Сотрудники] OFF
GO
SET IDENTITY_INSERT [dbo].[Товары] ON 

INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (1, N'Говядина вырезка', 1, N'Россия', N'хранить в холодильнике', N'6 месяцев', CAST(525.00 AS Decimal(18, 2)), N'Products\говядина вырезка.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (2, N'Свинина шейка', 1, N'Куба', N'хранить в морозильнике', N'6 месяцев', CAST(375.00 AS Decimal(18, 2)), N'Products\свинина шейка.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (3, N'Куриная грудка', 1, N'Россия', N'хранить в морозильнике', N'6 месяцев', CAST(325.00 AS Decimal(18, 2)), N'Products\куриная грудка.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (4, N'Колбаса вареная', 1, N'Россия', N'хранить в холодильнике', N'10 суток', CAST(275.00 AS Decimal(18, 2)), N'Products\колбаса вареная.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (5, N'Колбаса копченая', 1, N'Узбекистан', N'хранить в холодильнике', N'25 суток', CAST(375.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (6, N'Помидоры', 2, N'Россия', N'защищать от жары и солнечного света', N'2 недели', CAST(125.50 AS Decimal(18, 2)), N'C:\Users\Милана\Pictures\koko.png')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (7, N'Огурцы', 2, N'Беларусь', N'защищать от жары и солнечного света', N'1 неделя', CAST(85.25 AS Decimal(18, 2)), N'Products\огурцы.jpeg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (8, N'Яблоки', 2, N'Россия', N'защищать от жары и солнечного света', N'1 месяц', CAST(125.75 AS Decimal(18, 2)), N'Products\яблоки.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (9, N'Бананы', 2, N'Беларусь', N'защищать от жары и солнечного света', N'5 суток', CAST(115.80 AS Decimal(18, 2)), N'Products\бананы.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (10, N'Морковь', 2, N'Узбекистан', N'защищать от жары и солнечного света', N'1 месяц', CAST(28.17 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (11, N'Молоко', 3, N'Россия', N'хранить в холодильнике', N'3 суток', CAST(95.90 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (12, N'Сыр', 3, N'Россия', N'хранить в холодильнике', N'5 суток', CAST(225.25 AS Decimal(18, 2)), N'Products\сыр.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (13, N'Йогурт', 3, N'Россия', N'хранить в холодильнике', N'3 суток', CAST(59.99 AS Decimal(18, 2)), N'Products\йогурт.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (14, N'Творог', 3, N'Узбекистан', N'хранить в холодильнике', N'5 суток', CAST(105.75 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (15, N'Масло', 3, N'Россия', N'хранить в холодильнике', N'5 суток', CAST(175.00 AS Decimal(18, 2)), N'Products\масло.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (16, N'Моющее средство для посуды', 4, N'Россия', N'хранить в недоступном для детей месте', N'18 месяцев', CAST(125.50 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (17, N'Стиральный порошок', 4, N'Россия', N'хранить в недоступном для детей месте', N'5 лет', CAST(225.00 AS Decimal(18, 2)), N'Products\стиральный порошок.jpeg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (18, N'Средство для чистки ванны и душа', 4, N'Россия', N'хранить в недоступном для детей месте', N'18 месяцев', CAST(175.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (19, N'Мыло', 4, N'Беларусь', N'хранить в недоступном для детей месте', N'2 года', CAST(55.50 AS Decimal(18, 2)), N'Products\мыло.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (20, N'Белый хлеб', 5, N'Казахстан', N'не подвергать воздействию высокой влажности', N'3 суток', CAST(65.25 AS Decimal(18, 2)), N'Products\белый хлеб.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (21, N'Черный хлеб', 5, N'Россия', N'не подвергать воздействию высокой влажности', N'3 суток', CAST(50.99 AS Decimal(18, 2)), N'Products\черный хлеб.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (22, N'Багет', 5, N'Беларусь', N'не подвергать воздействию высокой влажности', N'3 суток', CAST(83.40 AS Decimal(18, 2)), N'Products\багет.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (23, N'Ржаной хлеб', 5, N'Россия', N'не подвергать воздействию высокой влажности', N'3 суток', CAST(95.75 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (24, N'Шоколадные конфеты', 7, N'Россия', N'хранить в холодильнике', N'9 месяцев', CAST(145.90 AS Decimal(18, 2)), N'Products\шоколадные конфеты.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (25, N'Печенье овсяное', 7, N'Казахстан', N'не подвергать воздействию высокой влажности', N'1 месяц', CAST(105.25 AS Decimal(18, 2)), N'Products\печенье овсяное.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (26, N'Торт "Прага"', 7, N'Россия', N'хранить в холодильнике', N'5 суток', CAST(525.00 AS Decimal(18, 2)), N'Products\торт прага.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (27, N'Детские подгузники', 8, N'Беларусь', NULL, N'3 года', CAST(325.00 AS Decimal(18, 2)), N'Products\подгузники.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (28, N'Детское питание', 8, N'Россия', N'хранить в холодильнике', N'6 месяцев', CAST(175.50 AS Decimal(18, 2)), N'Products\детское питание.jpeg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (29, N'Перец черный молотый', 9, N'Россия', NULL, N'3 года', CAST(75.75 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (30, N'Паприка', 9, N'Россия', NULL, N'3 года', CAST(95.60 AS Decimal(18, 2)), N'Products\паприка.jpeg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (31, N'Кориандр', 9, N'Казахстан', NULL, N'1 год', CAST(85.40 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (32, N'Карри', 9, N'Россия', NULL, N'1 год', CAST(105.00 AS Decimal(18, 2)), N'Products\карри.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (33, N'Рис', 10, N'Россия', N'хранить в сухом и прохладном месте', N'6 месяцев', CAST(115.80 AS Decimal(18, 2)), N'Products\рис.png')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (34, N'Гречка', 10, N'Албания', N'хранить в сухом и прохладном месте', N'2 года', CAST(105.75 AS Decimal(18, 2)), N'Products\гречка.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (35, N'Пшено', 10, N'Россия', N'хранить в сухом и прохладном месте', N'9 месяцев', CAST(95.50 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (36, N'Овсянка', 10, N'Россия', N'хранить в сухом и прохладном месте', N'4 месяца', CAST(85.25 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (37, N'Манная крупа', 10, N'Албания', N'хранить в сухом и прохладном месте', N'9 месяцев', CAST(75.40 AS Decimal(18, 2)), N'Products\манка.jpeg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (38, N'Красная рыба', 6, N'Беларусь', N'хранить в холодильнике', N'5 суток', CAST(425.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (39, N'Селедка', 6, N'Казахстан', N'хранить в холодильнике', N'10 суток', CAST(275.00 AS Decimal(18, 2)), N'Products\селедка.jpg')
INSERT [dbo].[Товары] ([Номер товара], [Название товара], [Отдел], [Страна-производитель], [Условия хранения], [Сроки хранения], [Цена], [Фото_Товары]) VALUES (40, N'Креветки', 6, N'Албания', N'хранить в холодильнике', N'3 суток', CAST(625.00 AS Decimal(18, 2)), N'Products\креветки.jpg')
SET IDENTITY_INSERT [dbo].[Товары] OFF
GO
ALTER TABLE [dbo].[Продажи товаров]  WITH CHECK ADD  CONSTRAINT [FK_Продажа товаров_Сотрудники] FOREIGN KEY([Сотрудник])
REFERENCES [dbo].[Сотрудники] ([Номер сотрудника])
GO
ALTER TABLE [dbo].[Продажи товаров] CHECK CONSTRAINT [FK_Продажа товаров_Сотрудники]
GO
ALTER TABLE [dbo].[Продажи товаров]  WITH CHECK ADD  CONSTRAINT [FK_Продажа товаров_Товары] FOREIGN KEY([Товар])
REFERENCES [dbo].[Товары] ([Номер товара])
GO
ALTER TABLE [dbo].[Продажи товаров] CHECK CONSTRAINT [FK_Продажа товаров_Товары]
GO
ALTER TABLE [dbo].[Сотрудники]  WITH CHECK ADD  CONSTRAINT [FK_Сотрудники_Должности] FOREIGN KEY([Должность])
REFERENCES [dbo].[Должности] ([Номер должности])
GO
ALTER TABLE [dbo].[Сотрудники] CHECK CONSTRAINT [FK_Сотрудники_Должности]
GO
ALTER TABLE [dbo].[Сотрудники]  WITH CHECK ADD  CONSTRAINT [FK_Сотрудники_Отделы] FOREIGN KEY([Отдел])
REFERENCES [dbo].[Отделы] ([Номер отдела])
GO
ALTER TABLE [dbo].[Сотрудники] CHECK CONSTRAINT [FK_Сотрудники_Отделы]
GO
ALTER TABLE [dbo].[Товары]  WITH CHECK ADD  CONSTRAINT [FK_Товары_Отделы] FOREIGN KEY([Отдел])
REFERENCES [dbo].[Отделы] ([Номер отдела])
GO
ALTER TABLE [dbo].[Товары] CHECK CONSTRAINT [FK_Товары_Отделы]
GO
ALTER TABLE [dbo].[Отделы]  WITH CHECK ADD  CONSTRAINT [Номер_зала] CHECK  (([Номер зала]>=(1) AND [Номер зала]<=(10)))
GO
ALTER TABLE [dbo].[Отделы] CHECK CONSTRAINT [Номер_зала]
GO
ALTER TABLE [dbo].[Отделы]  WITH CHECK ADD  CONSTRAINT [прилавки] CHECK  (([Кол-во прилавков]>=(1) AND [Кол-во прилавков]<=(15)))
GO
ALTER TABLE [dbo].[Отделы] CHECK CONSTRAINT [прилавки]
GO
ALTER TABLE [dbo].[Отделы]  WITH CHECK ADD  CONSTRAINT [продавцы] CHECK  (([Кол-во продавцов]>=(1) AND [Кол-во продавцов]<=(5)))
GO
ALTER TABLE [dbo].[Отделы] CHECK CONSTRAINT [продавцы]
GO
ALTER TABLE [dbo].[Продажи товаров]  WITH CHECK ADD  CONSTRAINT [date] CHECK  (([Дата]<=getdate()))
GO
ALTER TABLE [dbo].[Продажи товаров] CHECK CONSTRAINT [date]
GO
ALTER TABLE [dbo].[Сотрудники]  WITH CHECK ADD  CONSTRAINT [age_check] CHECK  ((((datepart(year,getdate())-datepart(year,[Год рождения]))-case when datepart(month,[Год рождения])>datepart(month,getdate()) then (1) when datepart(month,[Год рождения])=datepart(month,getdate()) AND datepart(day,[Год рождения])>datepart(day,getdate()) then (1) else (0) end)>=(18)))
GO
ALTER TABLE [dbo].[Сотрудники] CHECK CONSTRAINT [age_check]
GO
ALTER TABLE [dbo].[Сотрудники]  WITH CHECK ADD  CONSTRAINT [Const] CHECK  (([Пол] like 'М' OR [Пол] like 'Ж'))
GO
ALTER TABLE [dbo].[Сотрудники] CHECK CONSTRAINT [Const]
GO
ALTER TABLE [dbo].[Сотрудники]  WITH CHECK ADD  CONSTRAINT [YearOfJob] CHECK  (([Год поступления на работу]<=getdate()))
GO
ALTER TABLE [dbo].[Сотрудники] CHECK CONSTRAINT [YearOfJob]
GO
/****** Object:  StoredProcedure [dbo].[AllInfo]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AllInfo]
as begin
select * from Отделы
select * from Должности
select * from Сотрудники
select * from Товары
select * from [Продажи товаров]
end
GO
/****** Object:  StoredProcedure [dbo].[DYNTAB]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DYNTAB](@State int)
AS
BEGIN
    IF @State = 1
    BEGIN
        SELECT Фамилия, Имя, Отчество FROM Сотрудники ORDER BY Фамилия
    END
    IF @State = 2
    BEGIN
        SELECT [Номер сотрудника], Пол FROM Сотрудники WHERE Пол='Ж'
    END
END
GO
/****** Object:  StoredProcedure [dbo].[HallNumber]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[HallNumber]
as begin
select [Название отдела], [Кол-во прилавков], [Кол-во продавцов] from Отделы where [Номер зала]=10
end
GO
/****** Object:  StoredProcedure [dbo].[PostChecker]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[PostChecker](@employeeNumber int)
as begin
	if (select Должность FROM Сотрудники where [Номер сотрудника] = @employeeNumber)=2
print 'Данный сотрудник является продавцом'
else return 0
end
GO
/****** Object:  StoredProcedure [dbo].[PostChecker1]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[PostChecker1](@employeeNumber int)
as begin
declare @ret int = 0
	if (select Должность FROM Сотрудники where [Номер сотрудника] = @employeeNumber)=2
print 'Данный сотрудник является продавцом'
else return @ret
end


GO
/****** Object:  StoredProcedure [dbo].[ProductInfo]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ProductInfo]
@ProductName as nvarchar (50)
as begin
	select [Название отдела], [Страна-производитель], [Условия хранения], [Сроки хранения], Цена from [Продажи товаров], Товары, Отделы
	where Товары.[Номер товара]=[Продажи товаров].Товар and Товары.[Отдел]=Отделы.[Номер отдела] and [Название товара]=@ProductName
end

GO
/****** Object:  StoredProcedure [dbo].[UpdatePrices]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdatePrices]
as begin
update [Продажи товаров] set Цена +=25
end
GO
/****** Object:  StoredProcedure [dbo].[UpdatePrices1]    Script Date: 09.11.2024 17:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdatePrices1]
as begin
update [Продажи товаров] set Цена -=25
end

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[16] 2[3] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Сотрудники"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 333
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Должности"
            Begin Extent = 
               Top = 7
               Left = 381
               Bottom = 148
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2280
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[9] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Сотрудники"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 333
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Должности"
            Begin Extent = 
               Top = 7
               Left = 381
               Bottom = 148
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2100
         Alias = 4644
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1356
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
USE [master]
GO
ALTER DATABASE [Supermarket] SET  READ_WRITE 
GO

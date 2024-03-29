USE [master]
GO
/****** Object:  Database [kapidane_raw]    Script Date: 02/06/2023 16:08:48 ******/
CREATE DATABASE [kapidane_raw]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'kapidane_raw', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\kapidane_raw.mdf' , SIZE = 401408KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'kapidane_raw_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\kapidane_raw_log.ldf' , SIZE = 2039808KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [kapidane_raw] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [kapidane_raw].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [kapidane_raw] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [kapidane_raw] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [kapidane_raw] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [kapidane_raw] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [kapidane_raw] SET ARITHABORT OFF 
GO
ALTER DATABASE [kapidane_raw] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [kapidane_raw] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [kapidane_raw] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [kapidane_raw] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [kapidane_raw] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [kapidane_raw] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [kapidane_raw] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [kapidane_raw] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [kapidane_raw] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [kapidane_raw] SET  DISABLE_BROKER 
GO
ALTER DATABASE [kapidane_raw] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [kapidane_raw] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [kapidane_raw] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [kapidane_raw] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [kapidane_raw] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [kapidane_raw] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [kapidane_raw] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [kapidane_raw] SET RECOVERY FULL 
GO
ALTER DATABASE [kapidane_raw] SET  MULTI_USER 
GO
ALTER DATABASE [kapidane_raw] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [kapidane_raw] SET DB_CHAINING OFF 
GO
ALTER DATABASE [kapidane_raw] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [kapidane_raw] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [kapidane_raw] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [kapidane_raw] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'kapidane_raw', N'ON'
GO
ALTER DATABASE [kapidane_raw] SET QUERY_STORE = OFF
GO
USE [kapidane_raw]
GO
/****** Object:  Table [dbo].[countries]    Script Date: 02/06/2023 16:08:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[countries](
	[Country_Code] [char](2) NULL,
	[Country_Name] [varchar](100) NULL,
	[Income_Group] [varchar](50) NULL,
	[Region] [varchar](50) NULL,
	[Country_Long_Name] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[expenditures]    Script Date: 02/06/2023 16:08:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[expenditures](
	[DATAFLOW] [varchar](50) NULL,
	[LAST_UPDATE] [datetime2](7) NULL,
	[freq] [varchar](50) NULL,
	[purpose] [varchar](50) NOT NULL,
	[duration] [varchar](50) NOT NULL,
	[c_dest] [varchar](50) NOT NULL,
	[expend] [varchar](15) NOT NULL,
	[statinfo] [varchar](50) NOT NULL,
	[unit] [varchar](50) NULL,
	[geo] [varchar](50) NOT NULL,
	[TIME_PERIOD] [int] NOT NULL,
	[OBS_VALUE] [money] NULL,
	[OBS_FLAG] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nights]    Script Date: 02/06/2023 16:08:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nights](
	[DATAFLOW] [varchar](50) NULL,
	[LAST_UPDATE] [datetime2](7) NULL,
	[freq] [varchar](50) NULL,
	[c_dest] [varchar](50) NOT NULL,
	[purpose] [varchar](50) NOT NULL,
	[duration] [varchar](50) NOT NULL,
	[unit] [varchar](50) NULL,
	[geo] [varchar](50) NOT NULL,
	[TIME_PERIOD] [int] NOT NULL,
	[OBS_VALUE] [bigint] NULL,
	[OBS_FLAG] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[trips]    Script Date: 02/06/2023 16:08:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trips](
	[DATAFLOW] [varchar](50) NULL,
	[LAST_UPDATE] [datetime2](7) NULL,
	[freq] [varchar](50) NULL,
	[c_dest] [varchar](50) NOT NULL,
	[purpose] [varchar](50) NOT NULL,
	[duration] [varchar](50) NOT NULL,
	[unit] [varchar](50) NULL,
	[geo] [varchar](50) NOT NULL,
	[TIME_PERIOD] [int] NOT NULL,
	[OBS_VALUE] [int] NULL,
	[OBS_FLAG] [varchar](50) NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [kapidane_raw] SET  READ_WRITE 
GO

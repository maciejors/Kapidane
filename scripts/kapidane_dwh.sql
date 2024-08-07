USE [master]
GO
/****** Object:  Database [kapidane_dwh]    Script Date: 02/06/2023 15:56:21 ******/
DROP DATABASE IF EXISTS [kapidane_dwh]
GO
CREATE DATABASE [kapidane_dwh]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'kapidane_dwh_backup', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\kapidane_dwh_backup.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'kapidane_dwh_backup_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\kapidane_dwh_backup_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [kapidane_dwh] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [kapidane_dwh].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [kapidane_dwh] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [kapidane_dwh] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [kapidane_dwh] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [kapidane_dwh] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [kapidane_dwh] SET ARITHABORT OFF 
GO
ALTER DATABASE [kapidane_dwh] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [kapidane_dwh] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [kapidane_dwh] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [kapidane_dwh] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [kapidane_dwh] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [kapidane_dwh] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [kapidane_dwh] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [kapidane_dwh] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [kapidane_dwh] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [kapidane_dwh] SET  DISABLE_BROKER 
GO
ALTER DATABASE [kapidane_dwh] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [kapidane_dwh] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [kapidane_dwh] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [kapidane_dwh] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [kapidane_dwh] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [kapidane_dwh] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [kapidane_dwh] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [kapidane_dwh] SET RECOVERY FULL 
GO
ALTER DATABASE [kapidane_dwh] SET  MULTI_USER 
GO
ALTER DATABASE [kapidane_dwh] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [kapidane_dwh] SET DB_CHAINING OFF 
GO
ALTER DATABASE [kapidane_dwh] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [kapidane_dwh] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [kapidane_dwh] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [kapidane_dwh] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'kapidane_dwh', N'ON'
GO
ALTER DATABASE [kapidane_dwh] SET QUERY_STORE = OFF
GO
USE [kapidane_dwh]
GO
/****** Object:  Table [dbo].[Dim_ExpenditureDetails]    Script Date: 02/06/2023 15:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ExpenditureDetails](
	[ExpenditureDetailsKey] [varchar](15) NOT NULL,
	[ExpenditureType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Dim_ExpenditureDetails_1] PRIMARY KEY CLUSTERED 
(
	[ExpenditureDetailsKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Geography]    Script Date: 02/06/2023 15:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Geography](
	[CountryKey] [bigint] IDENTITY(1,1) NOT NULL,
	[CountryCode] [varchar](15) NOT NULL,
	[CountryName] [varchar](100) NOT NULL,
	[Region] [varchar](50) NOT NULL,
	[IncomeGroup] [varchar](50) NOT NULL,
	[IsMemberStateEU] [varchar](50) NOT NULL,
	[ValidFromDate] [date] NOT NULL,
	[ValidToDate] [date] NULL,
	[IsCurrent] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Dim_Geography] PRIMARY KEY CLUSTERED 
(
	[CountryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_TripDetails]    Script Date: 02/06/2023 15:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_TripDetails](
	[TripDetailsKey] [varchar](15) NOT NULL,
	[TripPurpose] [varchar](50) NOT NULL,
	[TripDuration] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Dim_TripDetails_1] PRIMARY KEY CLUSTERED 
(
	[TripDetailsKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Year]    Script Date: 02/06/2023 15:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Year](
	[Year] [int] NOT NULL,
	[IsLeapYear] [varchar](3) NOT NULL,
	[IsGlobalEvent] [varchar](50) NOT NULL,
	[GlobalEventText] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Dim_Date] PRIMARY KEY CLUSTERED 
(
	[Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Expenditures]    Script Date: 02/06/2023 15:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Expenditures](
	[FactKey] [varchar](50) NOT NULL,
	[YearKey] [int] NOT NULL,
	[TripDetailsKey] [varchar](15) NOT NULL,
	[OriginCountryKey] [bigint] NOT NULL,
	[DestinationCountryKey] [bigint] NOT NULL,
	[ExpenditureDetailsKey] [varchar](15) NOT NULL,
	[AvgExpenditureByNight] [money] NOT NULL,
	[AvgExpenditureByTrip] [money] NOT NULL,
 CONSTRAINT [PK_Fact_Expenditures] PRIMARY KEY CLUSTERED 
(
	[FactKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Expenditures_PreLoad]    Script Date: 02/06/2023 15:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Expenditures_PreLoad](
	[FactKey] [varchar](50) NOT NULL,
	[YearKey] [int] NOT NULL,
	[TripDetailsKey] [varchar](15) NOT NULL,
	[OriginCountryKey] [bigint] NOT NULL,
	[DestinationCountryKey] [bigint] NOT NULL,
	[ExpenditureDetailsKey] [varchar](15) NOT NULL,
	[AvgExpenditureByNight] [money] NOT NULL,
	[AvgExpenditureByTrip] [money] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_TripsNights]    Script Date: 02/06/2023 15:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_TripsNights](
	[FactKey] [varchar](50) NOT NULL,
	[YearKey] [int] NOT NULL,
	[TripDetailsKey] [varchar](15) NOT NULL,
	[OriginCountryKey] [bigint] NOT NULL,
	[DestinationCountryKey] [bigint] NOT NULL,
	[TripsCount] [int] NOT NULL,
	[NightsSpentCount] [bigint] NOT NULL,
 CONSTRAINT [PK_Fact_TripsNights] PRIMARY KEY CLUSTERED 
(
	[FactKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_TripsNights_PreLoad]    Script Date: 02/06/2023 15:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_TripsNights_PreLoad](
	[FactKey] [varchar](50) NOT NULL,
	[YearKey] [int] NOT NULL,
	[TripDetailsKey] [varchar](15) NOT NULL,
	[OriginCountryKey] [bigint] NOT NULL,
	[DestinationCountryKey] [bigint] NOT NULL,
	[TripsCount] [int] NOT NULL,
	[NightsSpentCount] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lookup_EU]    Script Date: 02/06/2023 15:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lookup_EU](
	[CountryCode] [varchar](15) NOT NULL,
	[CountryName] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lookup_EU]    Script Date: 02/06/2023 15:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeoSuppl](
	[CountryGroupCode] [varchar](15) NOT NULL,
	[CountryGroupName] [varchar](100) NOT NULL,
	[Region] [varchar](50) NOT NULL,
	[IncomeGroup] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryGroupCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Fact_Expenditures]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Expenditures_Dim_Date] FOREIGN KEY([YearKey])
REFERENCES [dbo].[Dim_Year] ([Year])
GO
ALTER TABLE [dbo].[Fact_Expenditures] CHECK CONSTRAINT [FK_Fact_Expenditures_Dim_Date]
GO
ALTER TABLE [dbo].[Fact_Expenditures]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Expenditures_Dim_ExpenditureDetails] FOREIGN KEY([ExpenditureDetailsKey])
REFERENCES [dbo].[Dim_ExpenditureDetails] ([ExpenditureDetailsKey])
GO
ALTER TABLE [dbo].[Fact_Expenditures] CHECK CONSTRAINT [FK_Fact_Expenditures_Dim_ExpenditureDetails]
GO
ALTER TABLE [dbo].[Fact_Expenditures]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Expenditures_Dim_Geography] FOREIGN KEY([OriginCountryKey])
REFERENCES [dbo].[Dim_Geography] ([CountryKey])
GO
ALTER TABLE [dbo].[Fact_Expenditures] CHECK CONSTRAINT [FK_Fact_Expenditures_Dim_Geography]
GO
ALTER TABLE [dbo].[Fact_Expenditures]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Expenditures_Dim_Geography1] FOREIGN KEY([DestinationCountryKey])
REFERENCES [dbo].[Dim_Geography] ([CountryKey])
GO
ALTER TABLE [dbo].[Fact_Expenditures] CHECK CONSTRAINT [FK_Fact_Expenditures_Dim_Geography1]
GO
ALTER TABLE [dbo].[Fact_Expenditures]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Expenditures_Dim_TripDetails1] FOREIGN KEY([TripDetailsKey])
REFERENCES [dbo].[Dim_TripDetails] ([TripDetailsKey])
GO
ALTER TABLE [dbo].[Fact_Expenditures] CHECK CONSTRAINT [FK_Fact_Expenditures_Dim_TripDetails1]
GO
ALTER TABLE [dbo].[Fact_TripsNights]  WITH CHECK ADD  CONSTRAINT [FK_Fact_TripsNights_Dim_Geography] FOREIGN KEY([OriginCountryKey])
REFERENCES [dbo].[Dim_Geography] ([CountryKey])
GO
ALTER TABLE [dbo].[Fact_TripsNights] CHECK CONSTRAINT [FK_Fact_TripsNights_Dim_Geography]
GO
ALTER TABLE [dbo].[Fact_TripsNights]  WITH CHECK ADD  CONSTRAINT [FK_Fact_TripsNights_Dim_Geography1] FOREIGN KEY([DestinationCountryKey])
REFERENCES [dbo].[Dim_Geography] ([CountryKey])
GO
ALTER TABLE [dbo].[Fact_TripsNights] CHECK CONSTRAINT [FK_Fact_TripsNights_Dim_Geography1]
GO
ALTER TABLE [dbo].[Fact_TripsNights]  WITH CHECK ADD  CONSTRAINT [FK_Fact_TripsNights_Dim_TripDetails1] FOREIGN KEY([TripDetailsKey])
REFERENCES [dbo].[Dim_TripDetails] ([TripDetailsKey])
GO
ALTER TABLE [dbo].[Fact_TripsNights] CHECK CONSTRAINT [FK_Fact_TripsNights_Dim_TripDetails1]
GO
ALTER TABLE [dbo].[Fact_TripsNights]  WITH CHECK ADD  CONSTRAINT [FK_Fact_TripsNights_Dim_Year] FOREIGN KEY([YearKey])
REFERENCES [dbo].[Dim_Year] ([Year])
GO
ALTER TABLE [dbo].[Fact_TripsNights] CHECK CONSTRAINT [FK_Fact_TripsNights_Dim_Year]
GO
USE [master]
GO
ALTER DATABASE [kapidane_dwh] SET  READ_WRITE 
GO

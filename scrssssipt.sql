USE [master]
GO
/****** Object:  Database [LKMT]    Script Date: 04/16/2024 12:48:53 ******/
CREATE DATABASE [LKMT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LKMT', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LKMT.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LKMT_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LKMT_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [LKMT] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LKMT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LKMT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LKMT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LKMT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LKMT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LKMT] SET ARITHABORT OFF 
GO
ALTER DATABASE [LKMT] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LKMT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LKMT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LKMT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LKMT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LKMT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LKMT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LKMT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LKMT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LKMT] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LKMT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LKMT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LKMT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LKMT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LKMT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LKMT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LKMT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LKMT] SET RECOVERY FULL 
GO
ALTER DATABASE [LKMT] SET  MULTI_USER 
GO
ALTER DATABASE [LKMT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LKMT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LKMT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LKMT] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LKMT] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LKMT] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'LKMT', N'ON'
GO
ALTER DATABASE [LKMT] SET QUERY_STORE = OFF
GO
USE [LKMT]
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_IDKH]    Script Date: 04/16/2024 12:48:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_IDKH]()
RETURNS VARCHAR(10)
AS
BEGIN
DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(id_khachhang) FROM khachhang) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(id_khachhang, 3)) FROM KHACHHANG
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'KH00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'KH0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
/****** Object:  Table [dbo].[admin]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admin](
	[id_admin] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](40) NOT NULL,
	[matkhau] [varchar](32) NOT NULL,
	[ten] [nvarchar](128) NOT NULL,
	[sodienthoai] [varchar](11) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_admin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[chitietdonhang]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chitietdonhang](
	[id_donhang] [varchar](12) NOT NULL,
	[id_sanpham] [varchar](10) NOT NULL,
	[dongia] [decimal](15, 4) NOT NULL,
	[soluong] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_donhang] ASC,
	[id_sanpham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[donhang]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[donhang](
	[id_donhang] [varchar](12) NOT NULL,
	[id_khachhang] [int] NOT NULL,
	[ngaydathang] [datetime] NOT NULL,
	[id_thanhtoan] [int] NOT NULL,
	[tinhtrang] [nvarchar](20) NOT NULL,
	[ghichu] [nvarchar](158) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_donhang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[giohang]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[giohang](
	[id] [int] NOT NULL,
	[id_sanpham] [varchar](10) NOT NULL,
	[soluong] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[id_sanpham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[khachhang]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[khachhang](
	[id_khachhang] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](40) NULL,
	[matkhau] [varchar](32) NULL,
	[ten] [nvarchar](128) NOT NULL,
	[sodienthoai] [varchar](11) NULL,
	[diachi] [nvarchar](128) NULL,
	[ngaytao] [datetime] NOT NULL,
	[ngaycapnhat] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_khachhang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[loaisanpham]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loaisanpham](
	[id_loai] [varchar](5) NOT NULL,
	[id_nhom] [varchar](5) NOT NULL,
	[tenloai] [nvarchar](32) NOT NULL,
	[ngaytao] [datetime] NOT NULL,
	[ngaycapnhat] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_loai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nhomsanpham]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nhomsanpham](
	[id_nhom] [varchar](5) NOT NULL,
	[tennhom] [nvarchar](32) NOT NULL,
	[ngaytao] [datetime] NOT NULL,
	[ngaycapnhat] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_nhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[phieugiaohang]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phieugiaohang](
	[id_pgh] [int] IDENTITY(1,1) NOT NULL,
	[ngaygiaohang] [datetime] NOT NULL,
	[diachi] [nvarchar](50) NULL,
	[tenkhachhang] [nvarchar](128) NOT NULL,
	[sodienthoai] [varchar](11) NOT NULL,
	[id_donhang] [varchar](12) NOT NULL,
	[ghichu] [nvarchar](158) NULL,
	[phigiaohang] [decimal](9, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pgh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[phieunhap]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phieunhap](
	[id_phieunhap] [int] IDENTITY(1,1) NOT NULL,
	[id_sanpham] [varchar](10) NOT NULL,
	[soluongsp] [int] NOT NULL,
	[gianhap] [decimal](15, 4) NOT NULL,
	[ngaynhap] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_phieunhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[phieuxuat]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phieuxuat](
	[id_phieuxuat] [int] IDENTITY(1,1) NOT NULL,
	[id_sanpham] [varchar](10) NOT NULL,
	[soluong] [int] NOT NULL,
	[ngayxuat] [datetime] NULL,
	[id_donhang] [varchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_phieuxuat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[phuongthucthanhtoan]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phuongthucthanhtoan](
	[id_thanhtoan] [int] IDENTITY(1,1) NOT NULL,
	[tenthanhtoan] [nvarchar](48) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_thanhtoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanpham]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanpham](
	[id_sanpham] [varchar](10) NOT NULL,
	[tensanpham] [nvarchar](52) NOT NULL,
	[id_loai] [varchar](5) NOT NULL,
	[gia] [decimal](15, 4) NOT NULL,
	[id_thuonghieu] [int] NOT NULL,
	[baohanh] [int] NOT NULL,
	[khuyenmai] [int] NOT NULL,
	[hinh] [varchar](128) NOT NULL,
	[mota] [text] NULL,
	[ngaytao] [datetime] NOT NULL,
	[ngaycapnhat] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sanpham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[thuonghieu]    Script Date: 04/16/2024 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[thuonghieu](
	[id_thuonghieu] [int] IDENTITY(1,1) NOT NULL,
	[id_nhom] [varchar](5) NULL,
	[tenthuonghieu] [nvarchar](40) NOT NULL,
	[ngaytao] [datetime] NOT NULL,
	[ngaycapnhat] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_thuonghieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[admin] ON 

INSERT [dbo].[admin] ([id_admin], [email], [matkhau], [ten], [sodienthoai]) VALUES (1, N'thu', N'123', N'Nguyen Thi Minh Thu', N'0965349315')
INSERT [dbo].[admin] ([id_admin], [email], [matkhau], [ten], [sodienthoai]) VALUES (2, N'tram', N'123', N'thu', N'0965349315')
SET IDENTITY_INSERT [dbo].[admin] OFF
GO
SET IDENTITY_INSERT [dbo].[khachhang] ON 

INSERT [dbo].[khachhang] ([id_khachhang], [email], [matkhau], [ten], [sodienthoai], [diachi], [ngaytao], [ngaycapnhat]) VALUES (33, N'lientran123@gmail.com', N'lienlien123', N'Trần Thị Liên', N'1', N'Q6 TPHCM', CAST(N'2024-05-19T08:56:37.000' AS DateTime), CAST(N'2024-05-21T09:19:11.067' AS DateTime))
INSERT [dbo].[khachhang] ([id_khachhang], [email], [matkhau], [ten], [sodienthoai], [diachi], [ngaytao], [ngaycapnhat]) VALUES (36, N'trantruong452@gmail.com', N'truongtran452', N'Trần Vũ Trường', N'0965349315', N'Q8 TPHCM', CAST(N'2024-05-21T09:18:34.000' AS DateTime), CAST(N'2024-05-21T09:19:20.857' AS DateTime))
INSERT [dbo].[khachhang] ([id_khachhang], [email], [matkhau], [ten], [sodienthoai], [diachi], [ngaytao], [ngaycapnhat]) VALUES (39, N'viethung302@gmail.com', N'viethung302', N'Trần Việt Hùng', N'0523659655', N'Q2 TPHCM', CAST(N'2024-05-21T10:20:35.000' AS DateTime), CAST(N'2024-05-21T10:23:01.923' AS DateTime))
INSERT [dbo].[khachhang] ([id_khachhang], [email], [matkhau], [ten], [sodienthoai], [diachi], [ngaytao], [ngaycapnhat]) VALUES (40, N'vutran123@gmail.com', N'vutran123', N'Trần Hoàng Vũ', N'0123652456', N'Chơn Thành, Bình Phước', CAST(N'2024-05-21T10:22:12.507' AS DateTime), CAST(N'2024-05-21T10:22:12.507' AS DateTime))
INSERT [dbo].[khachhang] ([id_khachhang], [email], [matkhau], [ten], [sodienthoai], [diachi], [ngaytao], [ngaycapnhat]) VALUES (42, N'ngoctramngoclinh@gmail.com', N'tramneuwu', N'Trương Thị Ngọc Trâm', N'0326123652', N'Nghệ An', CAST(N'2024-05-21T10:24:47.000' AS DateTime), CAST(N'2024-05-21T10:33:26.353' AS DateTime))
INSERT [dbo].[khachhang] ([id_khachhang], [email], [matkhau], [ten], [sodienthoai], [diachi], [ngaytao], [ngaycapnhat]) VALUES (45, N'toannguyen@gmail.com', N'', N'Nguyễn Văn Toàn', N'0962356123', N'Q3 TPHCM', CAST(N'2024-05-21T10:32:28.000' AS DateTime), CAST(N'2024-05-21T10:34:22.840' AS DateTime))
INSERT [dbo].[khachhang] ([id_khachhang], [email], [matkhau], [ten], [sodienthoai], [diachi], [ngaytao], [ngaycapnhat]) VALUES (46, N'', N'', N'Phạm Trần Thanh Thuận', N'0965349314', N'', CAST(N'2023-05-21T10:32:32.000' AS DateTime), CAST(N'2024-05-21T10:35:18.950' AS DateTime))
SET IDENTITY_INSERT [dbo].[khachhang] OFF
GO
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'HDD1', N'HDD', N'Ổ cứng dưới 500GB', CAST(N'2024-05-12T23:59:59.000' AS DateTime), CAST(N'2024-05-09T00:00:00.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'HDD2', N'HDD', N'HDD', CAST(N'2024-05-12T23:59:59.000' AS DateTime), CAST(N'2024-12-09T00:00:00.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'HDD3', N'HDD', N'Ổ cứng 2-6TB', CAST(N'2024-05-12T23:59:59.000' AS DateTime), CAST(N'2024-12-09T00:00:00.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'L0841', N'VGA', N'VGA GTX 1070-1080', CAST(N'2024-04-21T11:10:05.807' AS DateTime), CAST(N'2024-05-21T11:10:05.807' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'L1647', N'CPU', N'Intel Core I7', CAST(N'2024-04-20T15:54:43.030' AS DateTime), CAST(N'2024-05-20T15:54:43.030' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'L2261', N'CPU', N'Intel Core I5', CAST(N'2024-04-18T00:00:00.000' AS DateTime), CAST(N'2024-04-18T00:00:00.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'L4154', N'VGA', N'VGA GTX 1050-1060', CAST(N'2024-04-21T11:09:46.643' AS DateTime), CAST(N'2024-04-21T11:09:46.643' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'L6263', N'CPU', N'Intel Core I3', CAST(N'2024-04-20T15:54:34.523' AS DateTime), CAST(N'2024-04-20T15:54:34.523' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'MAINB', N'MAIN', N'Main dòng B', CAST(N'2024-05-12T23:59:59.000' AS DateTime), CAST(N'2024-05-12T23:59:59.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'MAINH', N'MAIN', N'Main dòng H', CAST(N'2024-05-12T23:59:59.000' AS DateTime), CAST(N'2024-05-12T23:59:59.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'MAINZ', N'MAIN', N'Main dòng Z', CAST(N'2024-05-12T23:59:59.000' AS DateTime), CAST(N'2024-05-12T23:59:59.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'RAM1', N'RAM', N'RAM 4GB-8GB', CAST(N'2024-05-12T23:59:59.000' AS DateTime), CAST(N'2024-05-12T23:59:59.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'RAM2', N'RAM', N'RAM 16GB-32GB', CAST(N'2023-05-12T23:59:59.000' AS DateTime), CAST(N'2024-05-12T23:59:59.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'RAM3', N'RAM', N'RAM DDR3', CAST(N'2023-05-12T23:59:59.000' AS DateTime), CAST(N'2024-05-12T23:59:59.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'RAM4', N'RAM', N'RAM DDR4', CAST(N'2023-05-09T00:00:00.000' AS DateTime), CAST(N'2023-05-09T00:00:00.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'SSD1', N'SSD', N'Ổ cứng 120-128GB', CAST(N'2024-05-12T23:59:59.000' AS DateTime), CAST(N'2024-05-09T00:00:00.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'SSD2', N'SSD', N'Ổ cứng 240-256GB', CAST(N'2024-05-12T23:59:59.000' AS DateTime), CAST(N'2024-12-09T00:00:00.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'SSD3', N'SSD', N'Ổ cứng 480-1TB', CAST(N'2024-05-12T23:59:59.000' AS DateTime), CAST(N'2024-05-09T00:00:00.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'USB1', N'USB', N'USB 32GB', CAST(N'2024-05-13T00:00:00.000' AS DateTime), CAST(N'2024-05-13T00:00:00.000' AS DateTime))
INSERT [dbo].[loaisanpham] ([id_loai], [id_nhom], [tenloai], [ngaytao], [ngaycapnhat]) VALUES (N'VGA1', N'VGA', N'VGA 2GB VRAM', CAST(N'2024-05-13T00:00:00.000' AS DateTime), CAST(N'2024-05-13T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[nhomsanpham] ([id_nhom], [tennhom], [ngaytao], [ngaycapnhat]) VALUES (N'CASE', N'Thùng máy', CAST(N'2024-05-21T10:59:21.833' AS DateTime), CAST(N'2024-05-21T10:59:21.833' AS DateTime))
INSERT [dbo].[nhomsanpham] ([id_nhom], [tennhom], [ngaytao], [ngaycapnhat]) VALUES (N'CPU', N'CPU - Bộ vi xử lí', CAST(N'2024-05-12T00:00:00.000' AS DateTime), CAST(N'2024-05-18T15:06:51.073' AS DateTime))
INSERT [dbo].[nhomsanpham] ([id_nhom], [tennhom], [ngaytao], [ngaycapnhat]) VALUES (N'HDD', N'HDD - Ổ cứng PC', CAST(N'2024-05-12T00:00:00.000' AS DateTime), CAST(N'2024-05-18T21:05:42.763' AS DateTime))
INSERT [dbo].[nhomsanpham] ([id_nhom], [tennhom], [ngaytao], [ngaycapnhat]) VALUES (N'MAIN', N'Mainboard - Bo mạch chủ', CAST(N'2024-05-12T00:00:00.000' AS DateTime), CAST(N'2024-05-18T00:00:00.000' AS DateTime))
INSERT [dbo].[nhomsanpham] ([id_nhom], [tennhom], [ngaytao], [ngaycapnhat]) VALUES (N'PSU', N'PSU - Bộ nguồn', CAST(N'2024-05-21T10:58:42.880' AS DateTime), CAST(N'2024-05-21T10:58:42.880' AS DateTime))
INSERT [dbo].[nhomsanpham] ([id_nhom], [tennhom], [ngaytao], [ngaycapnhat]) VALUES (N'RAM', N'Ram - Bộ nhớ trong', CAST(N'2024-05-12T00:00:00.000' AS DateTime), CAST(N'2024-05-18T21:05:33.783' AS DateTime))
INSERT [dbo].[nhomsanpham] ([id_nhom], [tennhom], [ngaytao], [ngaycapnhat]) VALUES (N'SSD', N'SSD - Ổ cứng rắn', CAST(N'2024-05-12T00:00:00.000' AS DateTime), CAST(N'2024-05-18T00:00:00.000' AS DateTime))
INSERT [dbo].[nhomsanpham] ([id_nhom], [tennhom], [ngaytao], [ngaycapnhat]) VALUES (N'USB', N'USB - Bộ nhớ di động', CAST(N'2024-05-09T00:00:00.000' AS DateTime), CAST(N'2024-05-18T00:00:00.000' AS DateTime))
INSERT [dbo].[nhomsanpham] ([id_nhom], [tennhom], [ngaytao], [ngaycapnhat]) VALUES (N'VGA', N'VGA - Card màn hình', CAST(N'2024-05-13T00:00:00.000' AS DateTime), CAST(N'2024-05-18T15:11:41.337' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[phieunhap] ON 

INSERT [dbo].[phieunhap] ([id_phieunhap], [id_sanpham], [soluongsp], [gianhap], [ngaynhap]) VALUES (1, N'SP18127313', 20, CAST(50000.0000 AS Decimal(15, 4)), CAST(N'2024-02-18T14:50:26.100' AS DateTime))
INSERT [dbo].[phieunhap] ([id_phieunhap], [id_sanpham], [soluongsp], [gianhap], [ngaynhap]) VALUES (2, N'SP20127303', 20, CAST(15000.0000 AS Decimal(15, 4)), CAST(N'2024-04-20T16:46:13.833' AS DateTime))
SET IDENTITY_INSERT [dbo].[phieunhap] OFF
GO
SET IDENTITY_INSERT [dbo].[phuongthucthanhtoan] ON 

INSERT [dbo].[phuongthucthanhtoan] ([id_thanhtoan], [tenthanhtoan]) VALUES (2, N'Thanh toán bằng ví điện tử')
INSERT [dbo].[phuongthucthanhtoan] ([id_thanhtoan], [tenthanhtoan]) VALUES (3, N'Thanh toán khi nhận hàng')
INSERT [dbo].[phuongthucthanhtoan] ([id_thanhtoan], [tenthanhtoan]) VALUES (4, N'Chuyển khoản ngân hàng')
INSERT [dbo].[phuongthucthanhtoan] ([id_thanhtoan], [tenthanhtoan]) VALUES (5, N'Quẹt thẻ tại quầy')
INSERT [dbo].[phuongthucthanhtoan] ([id_thanhtoan], [tenthanhtoan]) VALUES (6, N'Thanh toán bằng tiền mặt')
SET IDENTITY_INSERT [dbo].[phuongthucthanhtoan] OFF
GO
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP18127313', N'RAM 4GB Kinston', N'RAM1', CAST(500000.0000 AS Decimal(15, 4)), 1, 18, 0, N'item_XL_23017849_32350345.jpg', N'', CAST(N'2024-05-18T00:00:00.000' AS DateTime), CAST(N'2024-05-21T12:12:41.733' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP20127303', N'Cpu Intel Core i5', N'L2261', CAST(4000000.0000 AS Decimal(15, 4)), 1008, 24, 0, N'26877_34235_71i66qev_hl__sl1500_.jpg', N'Core i5', CAST(N'2024-05-20T16:44:42.000' AS DateTime), CAST(N'2024-05-21T11:24:59.423' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21120154', N'VGA Nvidia GTX 1060', N'L4154', CAST(5300000.0000 AS Decimal(15, 4)), 1025, 24, 0, N'34870_products_id_437_1.png', N'', CAST(N'2024-05-21T11:46:26.000' AS DateTime), CAST(N'2024-05-21T12:15:50.017' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21120711', N'SSD Samsung 1TB', N'SSD3', CAST(15000000.0000 AS Decimal(15, 4)), 1014, 24, 5, N'images (1).jpg', N'', CAST(N'2024-05-21T11:39:20.263' AS DateTime), CAST(N'2024-05-21T11:39:20.263' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21120738', N'Ram Kinstorn DDR3 4GB', N'RAM3', CAST(480000.0000 AS Decimal(15, 4)), 1, 12, 0, N'dato-4g-1600-3.jpg', N'', CAST(N'2024-05-21T11:27:39.000' AS DateTime), CAST(N'2024-05-21T12:14:14.610' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21121240', N'VGA Asus 1030 2GB', N'VGA1', CAST(120000.0000 AS Decimal(15, 4)), 1027, 24, 0, N'28530_asus_ph_gt1030_o2g_h1s.jpg', N'', CAST(N'2024-05-21T11:58:11.410' AS DateTime), CAST(N'2024-05-21T11:58:11.410' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21121384', N'Ram Kinstorn DDR4 8GB', N'RAM4', CAST(1200000.0000 AS Decimal(15, 4)), 1, 12, 0, N'item_XL_23017849_32350345.jpg', N'', CAST(N'2024-05-21T12:03:49.397' AS DateTime), CAST(N'2024-05-21T12:03:49.397' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21121650', N'Main Gigabyte B500M', N'MAINB', CAST(3600000.0000 AS Decimal(15, 4)), 1021, 24, 0, N'22679-1.png', N'', CAST(N'2024-05-21T11:59:11.517' AS DateTime), CAST(N'2024-05-21T11:59:11.517' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21121720', N'SSD Samsung 128GB', N'SSD1', CAST(1280000.0000 AS Decimal(15, 4)), 1014, 12, 0, N'images.jpg', N'', CAST(N'2024-05-21T11:33:57.223' AS DateTime), CAST(N'2024-05-21T11:33:57.223' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21123440', N'HDD Western 1TB Black', N'HDD2', CAST(4000000.0000 AS Decimal(15, 4)), 1035, 24, 0, N'118_74ff6bc79970adde993ff5b4f5142cce.jpg', N'', CAST(N'2024-05-21T11:55:14.523' AS DateTime), CAST(N'2024-05-21T11:55:14.523' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21124124', N'Main MSI B450', N'MAINB', CAST(4300000.0000 AS Decimal(15, 4)), 1023, 12, 0, N'MSI-B450-Tomahawk-Max-1024x699.jpg', N'', CAST(N'2024-05-21T11:50:35.807' AS DateTime), CAST(N'2024-05-21T11:50:35.807' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21124527', N'HDD Western 500GB Blue', N'HDD1', CAST(2500000.0000 AS Decimal(15, 4)), 1035, 24, 0, N'21930_wester_digital_wd5000azlx_blue_01.jpg', N'', CAST(N'2024-05-21T11:55:46.413' AS DateTime), CAST(N'2024-05-21T11:55:46.413' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21124853', N'Cpu Intel Core i3', N'L1647', CAST(2500000.0000 AS Decimal(15, 4)), 1008, 24, 0, N'45170_hnc_intel_core_i3_9100f_right_face_850x850.jpg', N'Vi xu li dien tu Intel voi tac vu xu lí cao', CAST(N'2024-05-21T11:25:46.717' AS DateTime), CAST(N'2024-05-21T11:25:46.717' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21125514', N'Ram Kinston 8GB', N'RAM1', CAST(1300000.0000 AS Decimal(15, 4)), 1, 24, 0, N'dato-4g-1600-3.jpg', N'', CAST(N'2024-05-21T12:11:52.393' AS DateTime), CAST(N'2024-05-21T12:11:52.393' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21125763', N'Main Gigabyte B550M', N'MAINB', CAST(3000000.0000 AS Decimal(15, 4)), 1024, 24, 0, N'22679-1.png', N'', CAST(N'2024-05-21T11:49:55.223' AS DateTime), CAST(N'2024-05-21T11:49:55.223' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21125788', N'VGA Nvidia GTX 1050', N'L4154', CAST(4500000.0000 AS Decimal(15, 4)), 1025, 24, 0, N'ta?i xuô´ng.jpg', N'', CAST(N'2024-05-21T11:45:08.000' AS DateTime), CAST(N'2024-05-21T12:15:35.777' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21126211', N'VGA Nvidia GTX 1070', N'L0841', CAST(7000000.0000 AS Decimal(15, 4)), 1025, 24, 0, N'24904_3754308_gtx_1070_gaming_x_8g.png', N'', CAST(N'2024-05-21T11:43:14.107' AS DateTime), CAST(N'2024-05-21T11:43:14.107' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21126214', N'Cpu Intel Core i7', N'L1647', CAST(7000000.0000 AS Decimal(15, 4)), 1008, 18, 0, N'44015_hnc_intel_i7_9700k_right_facing_850x850.jpg', N'Vi xu li dien tu Intel voi tac vu xu lí cao', CAST(N'2024-05-21T11:24:20.000' AS DateTime), CAST(N'2024-05-21T12:16:06.857' AS DateTime))
INSERT [dbo].[sanpham] ([id_sanpham], [tensanpham], [id_loai], [gia], [id_thuonghieu], [baohanh], [khuyenmai], [hinh], [mota], [ngaytao], [ngaycapnhat]) VALUES (N'SP21127330', N'SSD Samsung 248GB', N'SSD2', CAST(3000000.0000 AS Decimal(15, 4)), 1014, 12, 0, N'ssd_samsung_860_evo_1tb_sata3_1_1-300x300.jpg', N'', CAST(N'2023-05-21T11:36:48.000' AS DateTime), CAST(N'2024-05-21T12:16:00.763' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[thuonghieu] ON 

INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1, N'RAM', N'Kinston', CAST(N'2024-05-09T00:00:00.000' AS DateTime), CAST(N'2024-05-11T00:00:00.000' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1006, N'USB', N'Transcend', CAST(N'2024-05-13T00:00:00.000' AS DateTime), CAST(N'2024-05-13T00:00:00.000' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1008, N'CPU', N'Intel', CAST(N'2024-05-20T16:17:01.140' AS DateTime), CAST(N'2024-05-20T16:17:01.140' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1009, N'CPU', N'AMD', CAST(N'2024-05-20T16:17:07.947' AS DateTime), CAST(N'2024-05-20T16:17:07.947' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1014, N'SSD', N'Samsung', CAST(N'2024-05-21T11:03:08.847' AS DateTime), CAST(N'2024-05-21T11:03:08.847' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1015, N'SSD', N'Gigabyte', CAST(N'2024-05-21T11:03:16.053' AS DateTime), CAST(N'2024-05-21T11:03:16.053' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1016, N'SSD', N'Kinston', CAST(N'2024-05-21T11:03:25.097' AS DateTime), CAST(N'2024-05-21T11:03:25.097' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1017, N'SSD', N'Plextor', CAST(N'2024-05-21T11:03:58.320' AS DateTime), CAST(N'2024-05-21T11:03:58.320' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1018, N'SSD', N'WD', CAST(N'2024-05-21T11:04:08.073' AS DateTime), CAST(N'2024-05-21T11:04:08.073' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1019, N'MAIN', N'AMD', CAST(N'2024-05-21T11:04:50.570' AS DateTime), CAST(N'2024-05-21T11:04:50.570' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1020, N'MAIN', N'ASUS', CAST(N'2024-05-21T11:05:26.807' AS DateTime), CAST(N'2024-05-21T11:05:26.807' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1021, N'MAIN', N'ASROCK', CAST(N'2024-05-21T11:05:32.087' AS DateTime), CAST(N'2024-05-21T11:05:32.087' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1022, N'MAIN', N'Biostar', CAST(N'2020-12-21T11:05:44.923' AS DateTime), CAST(N'2024-05-21T11:05:44.923' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1023, N'MAIN', N'MSI', CAST(N'2024-05-21T11:05:51.970' AS DateTime), CAST(N'2024-05-21T11:05:51.970' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1024, N'MAIN', N'Gigabyte', CAST(N'2024-05-21T11:05:59.523' AS DateTime), CAST(N'2024-05-21T11:05:59.523' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1025, N'VGA', N'Nvidia', CAST(N'2024-05-21T11:06:28.723' AS DateTime), CAST(N'2024-05-21T11:06:28.723' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1026, N'VGA', N'AMD', CAST(N'2024-05-21T11:06:32.570' AS DateTime), CAST(N'2024-05-21T11:06:32.570' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1027, N'VGA', N'ASUS', CAST(N'2024-05-21T11:06:37.273' AS DateTime), CAST(N'2024-05-21T11:06:37.273' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1028, N'VGA', N'Galax', CAST(N'2024-05-21T11:06:43.077' AS DateTime), CAST(N'2024-05-21T11:06:43.077' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1029, N'VGA', N'Gigabyte', CAST(N'2024-05-21T11:06:55.623' AS DateTime), CAST(N'2024-05-21T11:06:55.623' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1030, N'VGA', N'MSI', CAST(N'2024-05-21T11:07:09.213' AS DateTime), CAST(N'2024-05-21T11:07:09.213' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1031, N'VGA', N'Zotac', CAST(N'2024-05-21T11:07:15.393' AS DateTime), CAST(N'2024-05-21T11:07:15.393' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1032, N'PSU', N'Acbel', CAST(N'2024-05-21T11:07:34.097' AS DateTime), CAST(N'2024-05-21T11:07:34.097' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1033, N'PSU', N'Cooler Master', CAST(N'2024-05-21T11:07:42.437' AS DateTime), CAST(N'2024-05-21T11:07:42.437' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1034, N'PSU', N'Sama', CAST(N'2024-05-21T11:07:50.143' AS DateTime), CAST(N'2024-05-21T11:07:50.143' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1035, N'HDD', N'Western', CAST(N'2024-05-21T11:08:43.040' AS DateTime), CAST(N'2024-05-21T11:08:43.040' AS DateTime))
INSERT [dbo].[thuonghieu] ([id_thuonghieu], [id_nhom], [tenthuonghieu], [ngaytao], [ngaycapnhat]) VALUES (1036, N'HDD', N'Seagate', CAST(N'2024-05-21T11:08:51.763' AS DateTime), CAST(N'2024-05-21T11:08:51.763' AS DateTime))
SET IDENTITY_INSERT [dbo].[thuonghieu] OFF
GO
/****** Object:  Index [UQ__admin__89472E9406D566D6]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[admin] ADD UNIQUE NONCLUSTERED 
(
	[id_admin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__admin__AB6E6164E7506A28]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[admin] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__chitietd__638F44CF2E586D16]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[chitietdonhang] ADD UNIQUE NONCLUSTERED 
(
	[id_donhang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__donhang__638F44CFB9BBD9AB]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[donhang] ADD UNIQUE NONCLUSTERED 
(
	[id_donhang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__giohang__3213E83E958628A8]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[giohang] ADD UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UC_Sodienthoai]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[khachhang] ADD  CONSTRAINT [UC_Sodienthoai] UNIQUE NONCLUSTERED 
(
	[sodienthoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__khachhan__63966DBC4B7058A6]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[khachhang] ADD UNIQUE NONCLUSTERED 
(
	[id_khachhang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__loaisanp__9A03AA7309B0CC60]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[loaisanpham] ADD UNIQUE NONCLUSTERED 
(
	[id_loai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__nhomsanp__284B2F9D1F070559]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[nhomsanpham] ADD UNIQUE NONCLUSTERED 
(
	[id_nhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__phieunha__19D0785F7E9532B3]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[phieunhap] ADD UNIQUE NONCLUSTERED 
(
	[id_phieunhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__phieuxua__5E30FDD53AC71BCB]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[phieuxuat] ADD UNIQUE NONCLUSTERED 
(
	[id_phieuxuat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__phuongth__257DA41B9978D845]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[phuongthucthanhtoan] ADD UNIQUE NONCLUSTERED 
(
	[id_thanhtoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__sanpham__5D76C1A3BD689E25]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[sanpham] ADD UNIQUE NONCLUSTERED 
(
	[id_sanpham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__thuonghi__8FCB194DE8A36F14]    Script Date: 04/16/2024 12:48:54 ******/
ALTER TABLE [dbo].[thuonghieu] ADD UNIQUE NONCLUSTERED 
(
	[id_thuonghieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sanpham] ADD  DEFAULT ((0)) FOR [khuyenmai]
GO
ALTER TABLE [dbo].[chitietdonhang]  WITH CHECK ADD  CONSTRAINT [FK_chitietdonhang_donhang] FOREIGN KEY([id_donhang])
REFERENCES [dbo].[donhang] ([id_donhang])
GO
ALTER TABLE [dbo].[chitietdonhang] CHECK CONSTRAINT [FK_chitietdonhang_donhang]
GO
ALTER TABLE [dbo].[chitietdonhang]  WITH CHECK ADD  CONSTRAINT [FK_chitietdonhang_sanpham] FOREIGN KEY([id_sanpham])
REFERENCES [dbo].[sanpham] ([id_sanpham])
GO
ALTER TABLE [dbo].[chitietdonhang] CHECK CONSTRAINT [FK_chitietdonhang_sanpham]
GO
ALTER TABLE [dbo].[donhang]  WITH CHECK ADD  CONSTRAINT [FK_donhang_khachhang] FOREIGN KEY([id_khachhang])
REFERENCES [dbo].[khachhang] ([id_khachhang])
GO
ALTER TABLE [dbo].[donhang] CHECK CONSTRAINT [FK_donhang_khachhang]
GO
ALTER TABLE [dbo].[donhang]  WITH CHECK ADD  CONSTRAINT [FK_donhang_phuongthucthanhtoan] FOREIGN KEY([id_thanhtoan])
REFERENCES [dbo].[phuongthucthanhtoan] ([id_thanhtoan])
GO
ALTER TABLE [dbo].[donhang] CHECK CONSTRAINT [FK_donhang_phuongthucthanhtoan]
GO
ALTER TABLE [dbo].[giohang]  WITH CHECK ADD  CONSTRAINT [FK_giohang_sanpham] FOREIGN KEY([id_sanpham])
REFERENCES [dbo].[sanpham] ([id_sanpham])
GO
ALTER TABLE [dbo].[giohang] CHECK CONSTRAINT [FK_giohang_sanpham]
GO
ALTER TABLE [dbo].[loaisanpham]  WITH CHECK ADD  CONSTRAINT [FK_loaisanpham_nhomsanpham] FOREIGN KEY([id_nhom])
REFERENCES [dbo].[nhomsanpham] ([id_nhom])
GO
ALTER TABLE [dbo].[loaisanpham] CHECK CONSTRAINT [FK_loaisanpham_nhomsanpham]
GO
ALTER TABLE [dbo].[phieugiaohang]  WITH CHECK ADD  CONSTRAINT [FK_phieugiaohang_donhang] FOREIGN KEY([id_donhang])
REFERENCES [dbo].[donhang] ([id_donhang])
GO
ALTER TABLE [dbo].[phieugiaohang] CHECK CONSTRAINT [FK_phieugiaohang_donhang]
GO
ALTER TABLE [dbo].[phieunhap]  WITH CHECK ADD  CONSTRAINT [FK_phieunhap_sanpham] FOREIGN KEY([id_sanpham])
REFERENCES [dbo].[sanpham] ([id_sanpham])
GO
ALTER TABLE [dbo].[phieunhap] CHECK CONSTRAINT [FK_phieunhap_sanpham]
GO
ALTER TABLE [dbo].[phieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_phieuxuat_sanpham] FOREIGN KEY([id_sanpham])
REFERENCES [dbo].[sanpham] ([id_sanpham])
GO
ALTER TABLE [dbo].[phieuxuat] CHECK CONSTRAINT [FK_phieuxuat_sanpham]
GO
ALTER TABLE [dbo].[sanpham]  WITH CHECK ADD  CONSTRAINT [FK_sanpham_loaisanpham] FOREIGN KEY([id_loai])
REFERENCES [dbo].[loaisanpham] ([id_loai])
GO
ALTER TABLE [dbo].[sanpham] CHECK CONSTRAINT [FK_sanpham_loaisanpham]
GO
ALTER TABLE [dbo].[sanpham]  WITH CHECK ADD  CONSTRAINT [FK_sanpham_thuonghieu] FOREIGN KEY([id_thuonghieu])
REFERENCES [dbo].[thuonghieu] ([id_thuonghieu])
GO
ALTER TABLE [dbo].[sanpham] CHECK CONSTRAINT [FK_sanpham_thuonghieu]
GO
ALTER TABLE [dbo].[thuonghieu]  WITH CHECK ADD  CONSTRAINT [FK_thuonghieu_nhomsanpham] FOREIGN KEY([id_nhom])
REFERENCES [dbo].[nhomsanpham] ([id_nhom])
GO
ALTER TABLE [dbo].[thuonghieu] CHECK CONSTRAINT [FK_thuonghieu_nhomsanpham]
GO
USE [master]
GO
ALTER DATABASE [LKMT] SET  READ_WRITE 
GO

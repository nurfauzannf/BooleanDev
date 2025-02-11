USE [TopUpGame]
GO
/****** Object:  Table [dbo].[MstGender]    Script Date: 10/10/2024 14:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MstGender](
	[IdGender] [varchar](5) NOT NULL,
	[GenderDesc] [varchar](20) NULL,
 CONSTRAINT [PK_MstGender] PRIMARY KEY CLUSTERED 
(
	[IdGender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrnCustomer]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrnCustomer](
	[CustomerId] [varchar](50) NOT NULL,
	[CustName] [varchar](50) NULL,
	[CustContact] [varchar](50) NULL,
	[CustDOB] [date] NULL,
	[CustGender] [varchar](50) NULL,
	[CustLevel] [varchar](50) NULL,
	[CustPassword] [varchar](50) NULL,
	[CustPin] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [varchar](50) NULL,
	[ModifyDate] [datetime2](7) NULL,
	[ModifyBy] [varchar](50) NULL,
 CONSTRAINT [PK_TrnCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwGenderCustomers]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwGenderCustomers]
AS
SELECT        dbo.TrnCustomer.CustomerId, dbo.TrnCustomer.CustName, dbo.TrnCustomer.CustContact, dbo.TrnCustomer.CustDOB, dbo.MstGender.GenderDesc, dbo.TrnCustomer.CustLevel, dbo.TrnCustomer.Status, 
                         dbo.TrnCustomer.CreateDate, dbo.TrnCustomer.CreateBy, dbo.TrnCustomer.ModifyDate, dbo.TrnCustomer.ModifyBy
FROM            dbo.MstGender INNER JOIN
                         dbo.TrnCustomer ON dbo.MstGender.IdGender = dbo.TrnCustomer.CustGender
GO
/****** Object:  Table [dbo].[MstProduct]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MstProduct](
	[MobilePriceId] [varchar](50) NOT NULL,
	[MobileProductId] [varchar](50) NOT NULL,
	[MobileGamesDesc] [varchar](100) NOT NULL,
	[Type] [varchar](50) NULL,
	[Amount] [varchar](15) NOT NULL,
 CONSTRAINT [PK_MstProduct] PRIMARY KEY CLUSTERED 
(
	[MobilePriceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrnPricing]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrnPricing](
	[IdTrnPricing] [varchar](50) NOT NULL,
	[IdProduct] [varchar](50) NOT NULL,
	[Price] [varchar](50) NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[CreateBy] [varchar](50) NOT NULL,
	[ModifyDate] [datetime2](7) NULL,
	[ModifyBy] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MstPayment]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MstPayment](
	[IdPayment] [varchar](50) NOT NULL,
	[PaymentDesc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MstPayment] PRIMARY KEY CLUSTERED 
(
	[IdPayment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrnTopUp]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrnTopUp](
	[IdTrnTopUp] [varchar](50) NOT NULL,
	[CustomerId] [varchar](50) NOT NULL,
	[ProductId] [varchar](50) NOT NULL,
	[PriceId] [varchar](50) NOT NULL,
	[PaymentMethod] [varchar](50) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[CreateBy] [varchar](50) NOT NULL,
	[ModifyDate] [datetime2](7) NULL,
	[ModifyBy] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwCustomerTopUpPaymentProduct]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCustomerTopUpPaymentProduct]
AS
SELECT        TOP (100) PERCENT dbo.TrnTopUp.IdTrnTopUp, dbo.TrnCustomer.CustName, dbo.MstProduct.MobileGamesDesc, dbo.MstProduct.Type, dbo.MstProduct.Amount, dbo.TrnPricing.Price, dbo.MstPayment.PaymentDesc AS Payment,
                          dbo.TrnTopUp.Status, dbo.TrnTopUp.CreateDate AS TransactionDate
FROM            dbo.TrnCustomer INNER JOIN
                         dbo.TrnTopUp ON dbo.TrnCustomer.CustomerId = dbo.TrnTopUp.CustomerId INNER JOIN
                         dbo.MstPayment ON dbo.TrnTopUp.PaymentMethod = dbo.MstPayment.IdPayment INNER JOIN
                         dbo.TrnPricing ON dbo.TrnTopUp.PriceId = dbo.TrnPricing.IdProduct INNER JOIN
                         dbo.MstProduct ON dbo.TrnTopUp.PriceId = dbo.MstProduct.MobilePriceId
ORDER BY TransactionDate DESC
GO
/****** Object:  Table [dbo].[MstLevel]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MstLevel](
	[IdLevel] [varchar](20) NOT NULL,
	[LevelDesc] [varchar](25) NULL,
 CONSTRAINT [PK_MstLevel] PRIMARY KEY CLUSTERED 
(
	[IdLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MstStatus]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MstStatus](
	[StatusId] [int] NOT NULL,
	[StatusDesc] [varchar](20) NULL,
 CONSTRAINT [PK_MstStatus] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwCustomerLevel]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCustomerLevel]
AS
SELECT        TOP (100) PERCENT dbo.TrnCustomer.CustomerId, dbo.TrnCustomer.CustName, dbo.TrnCustomer.CustContact, dbo.TrnCustomer.CustDOB, dbo.MstGender.GenderDesc, dbo.MstLevel.LevelDesc, dbo.MstStatus.StatusDesc, 
                         dbo.TrnCustomer.CreateDate, dbo.TrnCustomer.CreateBy, dbo.TrnCustomer.ModifyDate, dbo.TrnCustomer.ModifyBy
FROM            dbo.TrnCustomer INNER JOIN
                         dbo.MstLevel ON dbo.TrnCustomer.CustLevel = dbo.MstLevel.IdLevel INNER JOIN
                         dbo.MstGender ON dbo.TrnCustomer.CustGender = dbo.MstGender.IdGender INNER JOIN
                         dbo.MstStatus ON dbo.TrnCustomer.Status = dbo.MstStatus.StatusId
ORDER BY dbo.TrnCustomer.CreateDate DESC
GO
/****** Object:  Table [dbo].[MstSteamPrice]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MstSteamPrice](
	[IdMstSteam] [varchar](50) NOT NULL,
	[Type] [varchar](100) NULL,
	[Amount] [varchar](50) NULL,
 CONSTRAINT [PK_MstSteamPrice] PRIMARY KEY CLUSTERED 
(
	[IdMstSteam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrnSteam]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrnSteam](
	[IdTrnSteam] [varchar](50) NOT NULL,
	[CustomerId] [varchar](50) NOT NULL,
	[ProductId] [varchar](50) NOT NULL,
	[PaymentMethod] [varchar](50) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[CreateBy] [varchar](50) NOT NULL,
	[ModifyDate] [datetime2](7) NULL,
	[ModifyBy] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwCustomerSteamPayment]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCustomerSteamPayment]
AS
SELECT        TOP (100) PERCENT dbo.TrnSteam.CustomerId, dbo.TrnCustomer.CustName, dbo.MstSteamPrice.Type, dbo.MstSteamPrice.Amount, dbo.TrnPricing.Price, dbo.MstPayment.PaymentDesc, dbo.TrnSteam.Status, 
                         dbo.TrnSteam.CreateDate AS TransactionDate
FROM            dbo.TrnCustomer INNER JOIN
                         dbo.TrnSteam ON dbo.TrnCustomer.CustomerId = dbo.TrnSteam.CustomerId INNER JOIN
                         dbo.MstPayment ON dbo.TrnSteam.PaymentMethod = dbo.MstPayment.IdPayment INNER JOIN
                         dbo.TrnPricing ON dbo.TrnSteam.ProductId = dbo.TrnPricing.IdProduct INNER JOIN
                         dbo.MstSteamPrice ON dbo.TrnSteam.ProductId = dbo.MstSteamPrice.IdMstSteam
ORDER BY TransactionDate DESC
GO
/****** Object:  View [dbo].[vwSteamPricing]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwSteamPricing]
AS
SELECT        TOP (100) PERCENT dbo.MstSteamPrice.Type, dbo.MstSteamPrice.Amount, dbo.TrnPricing.Price, dbo.TrnPricing.ModifyDate AS LastUpdate
FROM            dbo.TrnPricing INNER JOIN
                         dbo.MstSteamPrice ON dbo.TrnPricing.IdProduct = dbo.MstSteamPrice.IdMstSteam
ORDER BY LastUpdate DESC
GO
/****** Object:  View [dbo].[vwProductPricing]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwProductPricing]
AS
SELECT        TOP (100) PERCENT dbo.MstProduct.MobileGamesDesc, dbo.MstProduct.Type, dbo.MstProduct.Amount, dbo.TrnPricing.Price, dbo.TrnPricing.ModifyDate AS LastUpdate
FROM            dbo.TrnPricing INNER JOIN
                         dbo.MstProduct ON dbo.TrnPricing.IdProduct = dbo.MstProduct.MobilePriceId
ORDER BY LastUpdate DESC
GO
/****** Object:  Table [dbo].[TrnLogCustomer]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrnLogCustomer](
	[IdLogCust] [varchar](50) NOT NULL,
	[CustomerId] [varchar](50) NOT NULL,
	[Remark] [varchar](50) NOT NULL,
	[LogStatus] [varchar](50) NOT NULL,
	[LogDesc] [varchar](50) NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[CreateBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TrnLogCustomer] PRIMARY KEY CLUSTERED 
(
	[IdLogCust] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrnLogPricing]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrnLogPricing](
	[IdTrnLogPricing] [varchar](50) NOT NULL,
	[IdProduct] [varchar](50) NOT NULL,
	[Remark] [varchar](50) NOT NULL,
	[LogStatus] [varchar](50) NOT NULL,
	[LogDesc] [varchar](50) NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TrnLogPricing] PRIMARY KEY CLUSTERED 
(
	[IdTrnLogPricing] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrnLogSteam]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrnLogSteam](
	[IdLogTrnSteam] [varchar](50) NOT NULL,
	[CustomerId] [varchar](50) NOT NULL,
	[Remark] [varchar](50) NOT NULL,
	[LogStatus] [varchar](50) NOT NULL,
	[LogDesc] [varchar](50) NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[CreateBy] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrnLogTopUp]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrnLogTopUp](
	[IdLogTopUp] [varchar](50) NOT NULL,
	[CustomerId] [varchar](50) NOT NULL,
	[Remark] [varchar](50) NOT NULL,
	[LogStatus] [varchar](50) NOT NULL,
	[LogDesc] [varchar](50) NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[CreateBy] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spCustomer]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nur Fauzan
-- Create date: 20240731
-- Description:	sp where
-- =============================================
CREATE PROCEDURE [dbo].[spCustomer] 
	-- Add the parameters for the stored procedure here
	@CustomerId varchar(100)
AS
BEGIN
	SELECT * FROM [dbo].[TrnCustomer]
	WHERE CustomerId = @CustomerId
END
GO
/****** Object:  StoredProcedure [dbo].[spCustomerGender]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nur Fauzan
-- Create date: 20240731
-- Description:	sp where
-- =============================================
CREATE PROCEDURE [dbo].[spCustomerGender] 
	@CustName varchar(100)
AS
BEGIN
	SELECT        dbo.TrnCustomer.CustomerId, dbo.TrnCustomer.CustName, dbo.TrnCustomer.CustContact, dbo.TrnCustomer.CustDOB, dbo.MstGender.GenderDesc, dbo.TrnCustomer.Status, 
                         dbo.TrnCustomer.CreateDate, dbo.TrnCustomer.CreateBy, dbo.TrnCustomer.ModifyDate, dbo.TrnCustomer.ModifyBy
FROM            dbo.MstGender INNER JOIN
                         dbo.TrnCustomer ON dbo.MstGender.IdGender = dbo.TrnCustomer.CustGender

WHERE CustName = @CustName
END
GO
/****** Object:  StoredProcedure [dbo].[spCustomerLevel]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nur Fauzan
-- Create date: 20240731
-- Description:	sp where
-- =============================================
CREATE PROCEDURE [dbo].[spCustomerLevel]
	-- Add the parameters for the stored procedure here
	@CustName varchar(100)
AS
BEGIN
	SELECT      dbo.TrnCustomer.CustomerId, dbo.TrnCustomer.CustName, dbo.TrnCustomer.CustContact, dbo.TrnCustomer.CustDOB, dbo.MstGender.GenderDesc, dbo.MstLevel.LevelDesc, dbo.MstStatus.StatusDesc, 
                         dbo.TrnCustomer.CreateDate, dbo.TrnCustomer.CreateBy, dbo.TrnCustomer.ModifyDate, dbo.TrnCustomer.ModifyBy
FROM            dbo.TrnCustomer INNER JOIN
                         dbo.MstLevel ON dbo.TrnCustomer.CustLevel = dbo.MstLevel.IdLevel INNER JOIN
                         dbo.MstGender ON dbo.TrnCustomer.CustGender = dbo.MstGender.IdGender INNER JOIN
                         dbo.MstStatus ON dbo.TrnCustomer.Status = dbo.MstStatus.StatusId

WHERE CustName = @CustName
END
GO
/****** Object:  StoredProcedure [dbo].[spCustomerProductPricingPayment]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nur Fauzan
-- Create date: 20240731
-- Description:	sp where
-- =============================================
CREATE PROCEDURE [dbo].[spCustomerProductPricingPayment]
	-- Add the parameters for the stored procedure here
	@MobileGamesDesc varchar(100)
AS
BEGIN
	SELECT     dbo.TrnTopUp.IdTrnTopUp, dbo.TrnCustomer.CustName, dbo.MstProduct.MobileGamesDesc, dbo.MstProduct.Type, dbo.MstProduct.Amount, dbo.TrnPricing.Price, dbo.MstPayment.PaymentDesc AS Payment,
                          dbo.TrnTopUp.Status, dbo.TrnTopUp.CreateDate AS TransactionDate
FROM            dbo.TrnCustomer INNER JOIN
                         dbo.TrnTopUp ON dbo.TrnCustomer.CustomerId = dbo.TrnTopUp.CustomerId INNER JOIN
                         dbo.MstPayment ON dbo.TrnTopUp.PaymentMethod = dbo.MstPayment.IdPayment INNER JOIN
                         dbo.TrnPricing ON dbo.TrnTopUp.PriceId = dbo.TrnPricing.IdProduct INNER JOIN
                         dbo.MstProduct ON dbo.TrnTopUp.PriceId = dbo.MstProduct.MobilePriceId
						 
WHERE MobileGamesDesc = @MobileGamesDesc
END
GO
/****** Object:  StoredProcedure [dbo].[spCustomerSteamPricingPayment]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nur Fauzan
-- Create date: 20240731
-- Description:	sp where
-- =============================================
CREATE PROCEDURE [dbo].[spCustomerSteamPricingPayment]
	-- Add the parameters for the stored procedure here
	@CustName varchar(100)
AS
BEGIN
	SELECT      dbo.TrnSteam.CustomerId, dbo.TrnCustomer.CustName, dbo.MstSteamPrice.Type, dbo.MstSteamPrice.Amount, dbo.TrnPricing.Price, dbo.MstPayment.PaymentDesc, dbo.TrnSteam.Status, 
                         dbo.TrnSteam.CreateDate AS TransactionDate
FROM            dbo.TrnCustomer INNER JOIN
                         dbo.TrnSteam ON dbo.TrnCustomer.CustomerId = dbo.TrnSteam.CustomerId INNER JOIN
                         dbo.MstPayment ON dbo.TrnSteam.PaymentMethod = dbo.MstPayment.IdPayment INNER JOIN
                         dbo.TrnPricing ON dbo.TrnSteam.ProductId = dbo.TrnPricing.IdProduct INNER JOIN
                         dbo.MstSteamPrice ON dbo.TrnSteam.ProductId = dbo.MstSteamPrice.IdMstSteam
WHERE CustName = @CustName
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteCustomer]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nur Fauzan
-- Create date: 20240801
-- Description:	Insert Data 2 Tabel
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteCustomer] 
	-- Add the parameters for the stored procedure here
	@CustomerId varchar(50),

	@Remark varchar(50),
    @LogStatus varchar(50), 
    @LogDesc varchar(50),
	@CreateBy varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE [dbo].[TrnCustomer]
	WHERE CustomerId = @CustomerId

	SELECT * FROM [dbo].[TrnCustomer]

	INSERT INTO [dbo].[TrnLogCustomer]
		   (
		    [IdLogCust]
		   ,[CustomerId]
		   ,[Remark]
		   ,[LogStatus]
		   ,[LogDesc]
		   ,[CreateDate]
		   ,[CreateBy]
		   )
     VALUES
           (
		   NEWID(),
           @CustomerId, 
           @Remark,
           @LogStatus, 
           @LogDesc,
           getdate(),
           @CreateBy
		   )
		   SELECT * FROM [dbo].[TrnLogCustomer] ORDER BY [CreateDate] DESC
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertCustomer]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nur Fauzan
-- Create date: 20240801
-- Description:	Insert Data
-- =============================================
CREATE PROCEDURE [dbo].[spInsertCustomer]
	-- Add the parameters for the stored procedure here
	@CustomerId varchar(50),
	@CustName varchar(50),
	@CustContact varchar(50),
	@CustDOB varchar(50),
	@CustGender varchar(50),
	@CustLevel varchar(50),
	@CustPassword varchar(50),
	@CustPin varchar(50),
	@Status varchar(50),
	@CreateBy varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[TrnCustomer]
	([CustomerId],
	[CustName],
	[CustContact],
	[CustDOB],
	[CustGender],
	[CustLevel],
	[CustPassword],
	[CustPin],
	[Status],
	[CreateDate],
	[CreateBy])

	VALUES
	(
	@CustomerId, 
	@CustName,
	@CustContact,
	@CustDOB,
	@CustGender,
	@CustLevel,
	@CustPassword,
	@CustPin,
	@Status,
	getdate(),
	@CreateBy
	)
		
	SELECT * FROM [dbo].[TrnCustomer] ORDER BY [CreateDate]
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertCustomerLog]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nur Fauzan
-- Create date: 20240801
-- Description:	Insert Data 2 Tabel
-- =============================================
CREATE PROCEDURE [dbo].[spInsertCustomerLog] 
	-- Add the parameters for the stored procedure here
	@CustomerId varchar(50),
	@CustName varchar(50),
	@CustContact varchar(50),
	@CustDOB varchar(50),
	@CustGender varchar(50),
	@CustLevel varchar(50),
	@CustPassword varchar(50),
	@CustPin varchar(50),
	@Status varchar(50),
	@CreateBy varchar(50),

    @Remark varchar(50),
    @LogStatus varchar(50), 
    @LogDesc varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[TrnCustomer]
	(
			[CustomerId],
			[CustName],
			[CustContact],
			[CustDOB],
			[CustGender],
			[CustLevel],
			[CustPassword],
			[CustPin],
			[Status],
			[CreateDate],
			[CreateBy]
	)

	VALUES
	(
			@CustomerId, 
			@CustName,
			@CustContact,
			@CustDOB,
			@CustGender,
			@CustLevel,
			@CustPassword,
			@CustPin,
			@Status,
			getdate(),
			@CreateBy
	)
		
	SELECT * FROM [dbo].[TrnCustomer]
	WHERE CustomerId = @CustomerId


	INSERT INTO [dbo].[TrnLogCustomer]
		   (
		    [IdLogCust]
		   ,[CustomerId]
		   ,[Remark]
		   ,[LogStatus]
		   ,[LogDesc]
		   ,[CreateDate]
		   ,[CreateBy]
		   )
     VALUES
           (
		   NEWID(),
           @CustomerId, 
           @Remark,
           @LogStatus, 
           @LogDesc,
           getdate(),
           @CreateBy
		   )
		   SELECT * FROM [dbo].[TrnLogCustomer] ORDER BY [CreateDate] DESC
END
GO
/****** Object:  StoredProcedure [dbo].[spProduct]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nur Fauzan
-- Create date: 20240731
-- Description:	sp where
-- =============================================
CREATE PROCEDURE [dbo].[spProduct]
	-- Add the parameters for the stored procedure here
	@MobileGamesDesc varchar(100)
AS
BEGIN
	SELECT * FROM [dbo].[MstProduct]
	WHERE MobileGamesDesc = @MobileGamesDesc
END
GO
/****** Object:  StoredProcedure [dbo].[spProductPricing]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nur Fauzan
-- Create date: 20240731
-- Description:	sp where
-- =============================================
CREATE PROCEDURE [dbo].[spProductPricing]
	-- Add the parameters for the stored procedure here
	@MobileGamesDesc varchar(100)
AS
BEGIN
	SELECT        dbo.MstProduct.MobileGamesDesc, dbo.MstProduct.Type, dbo.MstProduct.Amount, dbo.TrnPricing.Price, dbo.TrnPricing.ModifyDate AS LastUpdate
FROM            dbo.TrnPricing INNER JOIN
                         dbo.MstProduct ON dbo.TrnPricing.IdProduct = dbo.MstProduct.MobilePriceId

WHERE MobileGamesDesc = @MobileGamesDesc
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCustomer]    Script Date: 10/10/2024 14:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nur Fauzan
-- Create date: 20240801
-- Description:	Update Data
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateCustomer] 
	-- Add the parameters for the stored procedure here
	@CustomerId varchar(50),
	@CustName varchar(50),
	@CustContact varchar(50),
	@CustDOB varchar(50),
	@CustGender varchar(50),
	@CustLevel varchar(50),
	@CustPassword varchar(50),
	@CustPin varchar(50),
	@Status varchar(50),
	@ModifyBy varchar(50),

	
    @Remark varchar(50),
    @LogStatus varchar(50), 
    @LogDesc varchar(50),
	@CreateBy varchar(50)

AS
BEGIN
    -- Insert statements for procedure here
	UPDATE [dbo].[TrnCustomer]
	SET 
	[CustName] = @CustName,
	[CustContact] = @CustContact,
	[CustDOB] = @CustDOB,
	[CustGender] = @CustGender,
	[CustLevel] = @CustLevel,
	[CustPassword] = @CustPassword,
	[CustPin] = @CustPin,
	[Status] = @Status,
	[ModifyDate] = GETDATE(),
	[ModifyBy] = @ModifyBy
	WHERE CustomerId = @CustomerId

	SELECT * FROM [dbo].[TrnCustomer]
	WHERE CustomerId = @CustomerId

	INSERT INTO [dbo].[TrnLogCustomer]
		   (
		    [IdLogCust]
		   ,[CustomerId]
		   ,[Remark]
		   ,[LogStatus]
		   ,[LogDesc]
		   ,[CreateDate]
		   ,[CreateBy]
		   )
     VALUES
           (
		   NEWID(),
           @CustomerId, 
           @Remark,
           @LogStatus, 
           @LogDesc,
           getdate(),
           @CreateBy
		   )
		   SELECT * FROM [dbo].[TrnLogCustomer] ORDER BY [CreateDate] DESC
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[11] 2[17] 3) )"
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
         Begin Table = "TrnCustomer"
            Begin Extent = 
               Top = 9
               Left = 312
               Bottom = 202
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "MstLevel"
            Begin Extent = 
               Top = 28
               Left = 27
               Bottom = 198
               Right = 197
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MstGender"
            Begin Extent = 
               Top = 5
               Left = 670
               Bottom = 110
               Right = 840
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MstStatus"
            Begin Extent = 
               Top = 131
               Left = 682
               Bottom = 227
               Right = 852
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
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
         Filter = ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCustomerLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCustomerLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCustomerLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[14] 2[9] 3) )"
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
         Begin Table = "TrnCustomer"
            Begin Extent = 
               Top = 1
               Left = 784
               Bottom = 209
               Right = 954
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TrnSteam"
            Begin Extent = 
               Top = 1
               Left = 346
               Bottom = 201
               Right = 524
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MstPayment"
            Begin Extent = 
               Top = 108
               Left = 572
               Bottom = 204
               Right = 742
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TrnPricing"
            Begin Extent = 
               Top = 110
               Left = 39
               Bottom = 245
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "MstSteamPrice"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 112
               Right = 208
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2340
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3570
         Alias =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCustomerSteamPayment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 900
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCustomerSteamPayment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCustomerSteamPayment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[4] 2[33] 3) )"
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
         Begin Table = "TrnCustomer"
            Begin Extent = 
               Top = 0
               Left = 6
               Bottom = 130
               Right = 176
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TrnTopUp"
            Begin Extent = 
               Top = 0
               Left = 597
               Bottom = 199
               Right = 775
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MstPayment"
            Begin Extent = 
               Top = 21
               Left = 836
               Bottom = 117
               Right = 1006
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TrnPricing"
            Begin Extent = 
               Top = 147
               Left = 8
               Bottom = 327
               Right = 178
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MstProduct"
            Begin Extent = 
               Top = 147
               Left = 366
               Bottom = 277
               Right = 553
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
      Begin ColumnWidths = 21
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1155
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCustomerTopUpPaymentProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4485
         Alias = 900
         Table = 2415
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCustomerTopUpPaymentProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCustomerTopUpPaymentProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[20] 2[23] 3) )"
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
         Begin Table = "MstGender"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 115
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TrnCustomer"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 214
               Right = 581
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
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGenderCustomers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGenderCustomers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[20] 2[12] 3) )"
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
         Begin Table = "TrnPricing"
            Begin Extent = 
               Top = 3
               Left = 382
               Bottom = 209
               Right = 552
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MstProduct"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 211
               Right = 225
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2595
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwProductPricing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwProductPricing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[14] 3) )"
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
         Begin Table = "TrnPricing"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 214
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MstSteamPrice"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 142
               Right = 208
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3555
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2550
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSteamPricing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSteamPricing'
GO

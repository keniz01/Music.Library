/****** Object:  UserDefinedFunction [dbo].[ufn_StringTokenizer]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[ufn_StringTokenizer] 
(
	@SearchPhrase NVARCHAR(250), 
	@Delimiter CHAR(1) = ','
)
RETURNS NVARCHAR(250)   
AS 
BEGIN 
    DECLARE @TokenCount INT = (SELECT COUNT(*) FROM STRING_SPLIT(@SearchPhrase, @Delimiter))
    DECLARE @Counter INT = 0
    DECLARE @Token NVARCHAR(250) = NULL
    DECLARE @Query NVARCHAR(250) = ''

    -- Loop through tokens
    WHILE (@Counter < @TokenCount)
    BEGIN
        -- Get token value
        SELECT @Token = [value]
        FROM STRING_SPLIT(@SearchPhrase, @Delimiter)
        ORDER BY [value] ASC
        OFFSET @Counter ROWS
        FETCH NEXT 1 ROWS ONLY

        IF(@Counter != @TokenCount -1)
        BEGIN            
            SET @Query = @Query + '"*' + @Token + '*" OR '  
        END
        ELSE
        BEGIN
            SET @Query = @Query + '"*' + @Token + '*"'
        END

        -- Increment counter
        SET @Counter = @Counter + 1
    END
    RETURN @Query
END
GO
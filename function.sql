-- musterinin rezervasyonlarini bulur
DROP FUNCTION IF EXISTS dbo.fnRezervasyonBul
GO
CREATE FUNCTION fnRezervasyonBul(@musteriId INT)
RETURNS TABLE
AS
RETURN (
	SELECT * FROM dbo.Rezervasyon R WHERE R.MusteriId = @musteriId
)

GO
SELECT * FROM dbo.fnRezervasyonBul(1)
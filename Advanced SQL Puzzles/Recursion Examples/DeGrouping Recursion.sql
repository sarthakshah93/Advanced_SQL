DROP TABLE IF EXISTS #Ungroup;
GO

CREATE TABLE #Ungroup
(
ProductDescription  VARCHAR(100) PRIMARY KEY,
Quantity            INTEGER NOT NULL
);
GO

INSERT INTO #Ungroup (ProductDescription, Quantity) VALUES
('Pencil',3),('Eraser',4),('Notebook',2);
GO

WITH cte_Recursion AS
    (
    SELECT  ProductDescription,Quantity 
    FROM    #Ungroup
    UNION ALL
    SELECT  ProductDescription,Quantity-1
    FROM    cte_Recursion
    WHERE   Quantity >= 2
    )
SELECT  ProductDescription,1 AS Quantity
FROM   cte_Recursion
ORDER BY ProductDescription DESC;
GO
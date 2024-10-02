create schema retailshop;
use retailshop;

select * from online_retail;
DESCRIBE online_retail;
SELECT CustomerID, SUM(UnitPrice * Quantity) AS TotalOrderValue
FROM online_retail
GROUP BY CustomerID;
SELECT CustomerID, COUNT(DISTINCT StockCode) AS UniqueProductsPurchased
FROM online_retail
GROUP BY CustomerID;
SELECT CustomerID
FROM online_retail
GROUP BY CustomerID
HAVING COUNT(DISTINCT InvoiceNo) = 1;
SELECT a.StockCode AS Product1, b.StockCode AS Product2, COUNT(*) AS PurchaseCount
FROM online_retail a
JOIN online_retail b ON a.InvoiceNo = b.InvoiceNo AND a.StockCode < b.StockCode
GROUP BY a.StockCode, b.StockCode
ORDER BY PurchaseCount DESC;

SELECT CustomerID,
       CASE
         WHEN COUNT(DISTINCT InvoiceNo) > 20 THEN 'High Frequency'
         WHEN COUNT(DISTINCT InvoiceNo) BETWEEN 10 AND 20 THEN 'Medium Frequency'
         ELSE 'Low Frequency'
       END AS PurchaseFrequencySegment
FROM online_retail
GROUP BY CustomerID;


SELECT Country, AVG(UnitPrice * Quantity) AS AverageOrderValue
FROM online_retail
GROUP BY Country
order by AverageOrderValue DESC;

SELECT CustomerID FROM online_retail
 WHERE InvoiceDate < NOW() - INTERVAL 6 MONTH 
GROUP BY CustomerID 
HAVING COUNT(DISTINCT InvoiceNo) > 0;

SELECT a.StockCode AS Product1, b.StockCode AS Product2, COUNT(*) AS CoPurchaseCount
FROM online_retail a
JOIN online_retail b ON a.InvoiceNo = b.InvoiceNo AND a.StockCode <> b.StockCode
GROUP BY a.StockCode, b.StockCode
ORDER BY CoPurchaseCount DESC;
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, SUM(UnitPrice * Quantity) AS MonthlySales
FROM online_retail
GROUP BY Month
ORDER BY Month;
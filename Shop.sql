--Hər bir müştərinin ümumi sifariş sayini tapın
SELECT
    c.Id AS CustomerId,
    c.Name AS CustomerName,
    COUNT(o.Id) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON o.CustomerId = c.Id
GROUP BY c.Id, c.Name
ORDER BY TotalOrders DESC;


--total pricesi 2000 den yuxari olan musteriler goster
SELECT 
    C.Id,
    C.Name,
    C.Email,
    SUM(O.TotalPrice) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.Id = O.CustomerId
GROUP BY C.Id, C.Name, C.Email
HAVING SUM(O.TotalPrice) > 2000;


--Hər məhsul kateqoriyası üzrə satılan toplam məhsul sayı və toplam satış məbləğini tapın
SELECT 
    cat.Name AS CategoryName,
    SUM(oi.Quantity) AS TotalSoldProducts,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSalesAmount
FROM Categories cat
JOIN Products p ON p.CategoryId = cat.Id
JOIN OrderItems oi ON oi.ProductId = p.Id
GROUP BY cat.Name
ORDER BY TotalSalesAmount DESC;

--Hər müştərinin ən çox sifariş etdiyi məhsul kateqoriyasını tapın
WITH CustomerCategoryTotals AS (
    SELECT
        c.Id AS CustomerId,
        c.Name AS CustomerName,
        cat.Id AS CategoryId,
        cat.Name AS CategoryName,
        SUM(oi.Quantity) AS TotalQuantity
    FROM Customers c
    JOIN Orders o ON o.CustomerId = c.Id
    JOIN OrderItems oi ON oi.OrderId = o.Id
    JOIN Products p ON p.Id = oi.ProductId
    JOIN Categories cat ON cat.Id = p.CategoryId
    GROUP BY c.Id, c.Name, cat.Id, cat.Name
),
MaxCategory AS (
    SELECT
        CustomerId,
        MAX(TotalQuantity) AS MaxQuantity
    FROM CustomerCategoryTotals
    GROUP BY CustomerId
)
SELECT 
    cct.CustomerId,
    cct.CustomerName,
    cct.CategoryId,
    cct.CategoryName,
    cct.TotalQuantity
FROM CustomerCategoryTotals cct
JOIN MaxCategory mc
    ON cct.CustomerId = mc.CustomerId
    AND cct.TotalQuantity = mc.MaxQuantity
ORDER BY cct.CustomerId;


CREATE VIEW CustomerOrderSummary AS
WITH CustomerOrders AS (
    -- 1. Hər müştərinin ümumi sifariş sayı və toplam xərci
    SELECT 
        c.Id AS CustomerId,
        c.Name AS CustomerName,
        COUNT(o.Id) AS TotalOrders,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
    FROM Customers c
    LEFT JOIN Orders o ON o.CustomerId = c.Id
    LEFT JOIN OrderItems oi ON oi.OrderId = o.Id
    GROUP BY c.Id, c.Name
),
FilteredCustomers AS (
    -- 2. Yalnız ümumi sifarişləri 5000-dən çox olan müştərilər
    SELECT *
    FROM CustomerOrders
    WHERE TotalSpent > 5000
),
OrderAmounts AS (
    -- 3. Hər sifariş üçün məhsulların ümumi qiyməti və sifarişin TotalPrice müqayisəsi
    SELECT 
        o.Id AS OrderId,
        o.CustomerId,
        SUM(oi.Quantity * oi.UnitPrice) AS CalculatedTotal,
        o.TotalPrice AS OrderTotalPrice
    FROM Orders o
    JOIN OrderItems oi ON oi.OrderId = o.Id
    GROUP BY o.Id, o.CustomerId, o.TotalPrice
),
CategorySales AS (
    -- 4. Hər məhsul kateqoriyası üzrə toplam satış və sayı
    SELECT 
        cat.Id AS CategoryId,
        cat.Name AS CategoryName,
        SUM(oi.Quantity) AS TotalSoldProducts,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSalesAmount
    FROM Categories cat
    JOIN Products p ON p.CategoryId = cat.Id
    JOIN OrderItems oi ON oi.ProductId = p.Id
    GROUP BY cat.Id, cat.Name
),
CustomerFavoriteCategory AS (
    -- 5. Hər müştərinin ən çox sifariş etdiyi kateqoriya
    WITH CustomerCategoryTotals AS (
        SELECT
            c.Id AS CustomerId,
            cat.Id AS CategoryId,
            SUM(oi.Quantity) AS TotalQuantity
        FROM Customers c
        JOIN Orders o ON o.CustomerId = c.Id
        JOIN OrderItems oi ON oi.OrderId = o.Id
        JOIN Products p ON p.Id = oi.ProductId
        JOIN Categories cat ON cat.Id = p.CategoryId
        GROUP BY c.Id, cat.Id
    ),
    MaxCategory AS (
        SELECT
            CustomerId,
            MAX(TotalQuantity) AS MaxQuantity
        FROM CustomerCategoryTotals
        GROUP BY CustomerId
    )
    SELECT cct.CustomerId, cct.CategoryId, cat.Name AS CategoryName
    FROM CustomerCategoryTotals cct
    JOIN MaxCategory mc
        ON cct.CustomerId = mc.CustomerId
        AND cct.TotalQuantity = mc.MaxQuantity
    JOIN Categories cat ON cct.CategoryId = cat.Id
)
-- Əsas SELECT: Bütün məlumatları birləşdiririk
SELECT
    fc.CustomerId,
    fc.CustomerName,
    fc.TotalOrders,
    fc.TotalSpent,
    fav.CategoryName AS FavoriteCategory
FROM FilteredCustomers fc
LEFT JOIN CustomerFavoriteCategory fav
    ON fc.CustomerId = fav.CustomerId;

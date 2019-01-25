-- The Assignment

-- In this project, we'll continue to use Chinook to create more intermediate SQL queries.

-- Sprint 1

-- Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

SELECT 
    FirstName || " " || LastName AS 'Full Name', 
    CustomerId, 
    Country 
FROM Customer
WHERE Country != 'USA';

-- Provide a query only showing the Customers from Brazil.

SELECT * 
FROM Customer
WHERE Country = 'Brazil';

-- Provide a query showing the Invoices of customers who are from Brazil. 
-- The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT
	C.FirstName || " " || C.LastName AS 'Full Name',
    I.InvoiceId,
    I.InvoiceDate,
    I.BillingCountry
FROM Customer C
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
WHERE C.Country = 'Brazil';

-- Provide a query showing only the Employees who are Sales Agents.

SELECT * 
FROM Employee
WHERE Title = 'Sales Support Agent';

-- Provide a query showing a unique/distinct list of billing countries from the Invoice table.

SELECT 
    DISTINCT BillingCountry 
FROM Invoice
ORDER BY BillingCountry;

-- Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT
    E.FirstName || " " || E.LastName AS 'Full Name',
    I.InvoiceId
FROM Employee E
INNER JOIN Customer C 
ON E.EmployeeId = C.SupportRepId
INNER JOIN Invoice I 
ON C.CustomerId = I.CustomerId;

-- Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT
    I.Total,
    C.FirstName || " " || C.LastName AS 'Customer Name',
    C.Country,
    E.FirstName || " " || E.LastName AS 'Sale Agent Name'
FROM Invoice I
INNER JOIN Customer C 
ON I.CustomerId = C.CustomerId
INNER JOIN Employee E 
ON E.EmployeeId = C.SupportRepId;

-- How many Invoices were there in 2009 and 2011?

SELECT 
    COUNT(*) AS 'Invoices', 
    strftime('%Y', InvoiceDate) AS 'Year'
FROM Invoice
WHERE strftime('%Y', InvoiceDate) IN ('2009', '2011')
GROUP BY strftime('%Y', InvoiceDate);


-- What are the respective total sales for each of those years?

SELECT 
    SUM(Total) AS 'Total', 
    strftime('%Y', InvoiceDate) AS 'Year'
FROM Invoice
WHERE strftime('%Y', InvoiceDate) IN ('2009', '2011')
GROUP BY strftime('%Y', InvoiceDate);

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT 
    InvoiceId, 
    COUNT(InvoiceLineId)
FROM InvoiceLine
WHERE InvoiceId = 37;

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.

SELECT  
    InvoiceId, 
    COUNT(InvoiceLineId)
FROM InvoiceLine
GROUP BY InvoiceId;

-- Provide a query that includes the purchased track name with each invoice line item.

SELECT 
    I.InvoiceLineId, 
    T.Name AS 'Track Name'
FROM InvoiceLine I
INNER JOIN Track T
ON I.TrackId = T.TrackId
ORDER BY InvoiceLineId;

-- Provide a query that includes the purchased track name AND artist name with each invoice line item.

SELECT 
    I.InvoiceLineId, 
    T.Name, 
    Ar.Name
FROM InvoiceLine I
INNER JOIN Track T
ON I.TrackId = T.TrackId
INNER JOIN Album A
ON T.AlbumId = A.AlbumId
INNER JOIN Artist Ar
ON A.ArtistId = Ar.ArtistId
ORDER BY I.InvoiceLineId;

-- Provide a query that shows the # of invoices per country.

SELECT 
    BillingCountry, 
    count(InvoiceId)
FROM Invoice
GROUP BY BillingCountry;

-- Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.

SELECT 
    P.Name AS 'Playlist Name', 
    Count(T.TrackId) AS 'Number of Tracks'
FROM Playlist P
INNER JOIN PlaylistTrack PT
ON P.PlaylistId = PT.PlaylistId
INNER JOIN Track T
ON PT.TrackId = T.TrackId
GROUP BY P.Name;

-- Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.

SELECT 
	T.Name AS 'Track Name',
    A.Title AS 'Album Name',
    M.Name AS 'Media Type',
    G.Name AS 'Genre'
FROM Track T
INNER JOIN Album A
ON T.AlbumId = A.AlbumId
INNER JOIN MediaType M
ON T.MediaTypeId = M.MediaTypeId
INNER JOIN Genre G
ON T.GenreId = G.GenreId;

-- Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT 
	InvoiceId,
    COUNT(InvoiceLineId) AS 'Number of Invoice Line Items'
FROM InvoiceLine
GROUP BY InvoiceId;


-- Provide a query that shows total sales made by each sales agent.

SELECT 
	E.FirstName || " " || E.LastName AS 'Sales Agent',
    SUM(I.Total) AS 'Total Sales'
FROM Employee E
INNER JOIN Customer C
ON E.EmployeeId = C.SupportRepId
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
GROUP BY E.EmployeeId;


-- Which sales agent made the most in sales in 2009?

SELECT
	SalesAgent,
	MAX(TotalSales) AS 'Top Sales in 2009'
FROM 
(
SELECT 
	E.FirstName || " " || E.LastName AS 'SalesAgent',
    SUM(I.Total) AS 'TotalSales'
FROM Employee E
INNER JOIN Customer C
ON E.EmployeeId = C.SupportRepId
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
WHERE strftime('%Y', I.InvoiceDate) IN ('2009')
GROUP BY E.EmployeeId
);

-- Which sales agent made the most in sales over all?

SELECT 
	SalesAgent,
    MAX(TotalSales) AS 'Top Sales over all'
FROM
(
SELECT 
	E.FirstName || " " || E.LastName AS 'SalesAgent',
    SUM(I.Total) AS 'TotalSales'
FROM Employee E
INNER JOIN Customer C
ON E.EmployeeId = C.SupportRepId
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
GROUP BY E.EmployeeId
);

-- Provide a query that shows the count of customers assigned to each sales agent.

SELECT 
	E.FirstName || " " || E.LastName AS 'SalesAgent',
    COUNT(C.SupportRepId) AS 'customers assigned'
FROM Employee E
INNER JOIN Customer C
ON E.EmployeeId = C.SupportRepId
GROUP BY E.EmployeeId;


-- Provide a query that shows the total sales per country.

SELECT 
	BillingCountry AS 'Country',
    SUM(Total) AS 'TotalSales'
FROM Invoice
GROUP BY BillingCountry;

-- Which country's customers spent the most?

SELECT
    Country,
    MAX(TotalSales)
FROM
(
SELECT 
	BillingCountry AS 'Country',
    SUM(Total) AS 'TotalSales'
FROM Invoice
GROUP BY BillingCountry
);

-- Provide a query that shows the most purchased track of 2013.

SELECT
	TrackName,
	MAX(PurchaseTimes) AS 'most purchased in 2003'
FROM
(
SELECT
	T.Name AS 'TrackName',
    COUNT(IL.InvoiceLineId) AS 'PurchaseTimes'
FROM Invoice I
INNER JOIN InvoiceLine IL 
ON I.InvoiceId = IL.InvoiceId
INNER JOIN Track T 
ON IL.TrackId = T.TrackId
WHERE strftime('%Y', i.InvoiceDate) = '2013'
GROUP BY T.TrackId
);

-- Provide a query that shows the top 5 most purchased tracks over all.

SELECT
	T.Name AS 'TrackName',
    COUNT(IL.InvoiceLineId) AS 'PurchaseTimes'
FROM Invoice I
INNER JOIN InvoiceLine IL 
ON I.InvoiceId = IL.InvoiceId
INNER JOIN Track T 
ON IL.TrackId = T.TrackId
GROUP BY T.TrackId
ORDER BY PurchaseTimes DESC
LIMIT 5;

-- Provide a query that shows the top 3 best selling artists.

SELECT
  AR.Name AS 'ArtistName',
  COUNT(IL.TrackId) AS 'TracksSold',
  SUM(IL.UnitPrice) AS 'Total'
FROM Artist AR
INNER JOIN Album AL
ON AR.ArtistId = AL.ArtistId
INNER JOIN Track T
ON AL.AlbumId = T.AlbumId
INNER JOIN InvoiceLine IL
ON T.TrackId = IL.TrackId
GROUP BY AR.Name
ORDER BY SUM(IL.UnitPrice) DESC
LIMIT 3;

-- Provide a query that shows the most purchased Media Type.

SELECT
  MediaType,
  MAX(Total)
FROM
(
SELECT
  MT.Name AS 'MediaType',
  SUM(T.UnitPrice) AS 'Total'
FROM MediaType MT
INNER JOIN Track t 
ON T.MediaTypeId = MT.MediaTypeId
INNER JOIN InvoiceLine il 
ON IL.TrackId = T.TrackId
GROUP BY MT.Name
);
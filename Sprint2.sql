-- Sprint 2

-- Get all invoices where the UnitPrice on the InvoiceLine is greater than $0.99.

SELECT *
FROM Invoice I
INNER JOIN InvoiceLine IL 
ON I.invoiceId = IL.invoiceId
WHERE IL.UnitPrice > 0.99;

-- Get the InvoiceDate, customer FirstName and LastName, and Total from all invoices.

SELECT 
    I.InvoiceDate AS 'Invoice Date', 
    C.FirstName AS 'Customer FirstName', 
    C.LastName AS 'Customer LastName', 
    I.Total AS 'Total'
FROM Invoice I
INNER JOIN Customer C 
ON I.CustomerId = C.CustomerId;

-- Get the customer FirstName and LastName and the support rep's FirstName and LastName from all customers.
-- Support reps are on the Employee table.

SELECT 
    C.FirstName AS 'Customer FirstName', 
    C.LastName AS 'Customer LastName', 
    E.FirstName AS "support rep's FirstName", 
    E.LastName AS "support rep's LastName"
FROM Customer C
INNER JOIN Employee E 
ON C.SupportRepId = E.EmployeeId;

-- Get the album Title and the artist Name from all albums.

SELECT 
    AL.Title AS 'Album Title', 
    AR.Name AS 'Artist Name'
FROM Album AL
INNER JOIN Artist AR 
ON AL.ArtistId = AR.ArtistId;

-- Get all PlaylistTrack TrackIds where the playlist Name is Music.

SELECT 
    PT.TrackId AS 'TrackId'
FROM PlaylistTrack PT
INNER JOIN Playlist P 
ON PT.PlaylistId = P.PlaylistId
WHERE P.Name = 'Music';

-- Get all Track Names for PlaylistId 5.

SELECT 
    T.Name AS 'Track Name'
FROM Track T
INNER JOIN PlaylistTrack PT 
ON T.TrackId = PT.TrackId
WHERE PT.PlaylistId = 5;

-- Get all Track Names and the playlist Name that they're on.

SELECT 
    T.name AS 'Track Name', 
    P.Name AS 'Playlist Name'
FROM Track T
INNER JOIN PlaylistTrack PT 
ON T.TrackId = PT.TrackId
INNER JOIN Playlist P 
ON PT.PlaylistId = P.PlaylistId;

-- Get all Track Names and Album Titles that are the genre "Alternative".

SELECT 
    T.Name AS 'Track Name', 
    A.title AS 'Album Title'
FROM Album A
INNER JOIN Track T 
ON A.AlbumId = T.AlbumId
INNER JOIN Genre G 
ON T.GenreId = G.GenreId
WHERE G.Name = "Alternative";
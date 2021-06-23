USE albums_db; # 1
SHOW TABLES; # 2
DESCRIBE albums; # 3
SELECT id FROM albums; # 3a 31 rows
SELECT DISTINCT artist FROM albums; # 3b 23 artists
# 3c use Structure tab to identify primary key, answer is id
SELECT release_date from albums ORDER BY release_date; # 3d oldest release date is 1967, most recent is 2011

SELECT # 4a albums from Pink Floyd are DSOTM and The Wall
	artist,
	name
FROM albums
WHERE artist = 'Pink Floyd'; 
SELECT # 4b release year for this is 1967
	name,
	release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band'; 

SELECT # 4c genre of Nevermind is Grunge, Alternative rock
	name,
	genre
FROM albums
WHERE name = 'Nevermind';

SELECT # There's a lot, just run the command again
	release_date,
	name
FROM albums
WHERE release_date BETWEEN '1990' AND '1999';

SELECT sales FROM albums;
SELECT # Multiple albums, just run the query
	sales,
	name
FROM albums
WHERE sales < 20.0;


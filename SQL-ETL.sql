-- Copy teams to new storage
DROP TABLE IF EXISTS BigDanceTeams;
DROP TABLE IF EXISTS LastFiveYears;
DROP TABLE IF EXISTS FinalTeamConference;

-- Get last 5 years of data
SELECT DISTINCT "TEAM", "CONF"
INTO LastFiveYears
FROM "Conference" 
WHERE "YEAR" >= 2015
ORDER BY "TEAM";

SELECT DISTINCT BD_Team 
INTO BigDanceTeams
FROM (
	SELECT DISTINCT "Home_Team" AS BD_Team FROM "BigDance"
	UNION 
	SELECT DISTINCT "Away_Team" AS BD_Team FROM "BigDance"
) AS x

-----------------------------------------------
-----------------------------------------------
-- DATA STANDARDIZATION
-- CBB data has St.; BigDance as "St"
UPDATE LastFiveYears
SET "TEAM" = REPLACE("TEAM", '.', '');

-- CBB data has Mary's; BigDance has Marys
UPDATE LastFiveYears
SET "TEAM" = REPLACE("TEAM", '''', '');

-- DATA QUALITY PROBLEMS
-- Cal Irvine in 2015 became UC Irvine later in 2019
UPDATE "BigDance"
SET "Away_Team" = 'UC Irvine'
WHERE "Away_Team" = 'Cal Irvine';

UPDATE LastFiveYears
SET "TEAM" = 'NC State'
WHERE "TEAM" = 'North Carolina St';

UPDATE LastFiveYears
SET "TEAM" = 'Ole Miss'
WHERE "TEAM" = 'Mississippi';

UPDATE LastFiveYears
SET "TEAM" = 'Wisconsin Green Bay'
WHERE "TEAM" = 'Green Bay';

UPDATE LastFiveYears
SET "TEAM" = 'Miami'
WHERE "TEAM" = 'Miami FL';

UPDATE LastFiveYears
SET "TEAM" = 'Middle Tennessee St'
WHERE "TEAM" = 'Middle Tennessee';

UPDATE LastFiveYears
SET "TEAM" = 'St Louis'
WHERE "TEAM" = 'Saint Louis';

UPDATE LastFiveYears
SET "TEAM" = 'Central Florida'
WHERE "TEAM" = 'UCF'

UPDATE LastFiveYears
SET "TEAM" = 'Pennsylvania'
WHERE "TEAM" = 'Penn';

UPDATE LastFiveYears
SET "TEAM" = 'St Josephs'
WHERE "TEAM" = 'Saint Josephs';

UPDATE LastFiveYears
SET "TEAM" = 'St Marys'
WHERE "TEAM" = 'Saint Marys';
------------------------------------------
-------------------------------------------
SELECT (SELECT COUNT(*) AS "BigDance" FROM BigDanceTeams) AS BigDance
	, (SELECT COUNT(*) AS "Conference" FROM LastFiveYears) AS Conference

-- All rows mapped
SELECT *
FROM BigDanceTeams b
WHERE BD_Team NOT IN (SELECT "TEAM" FROM LastFiveYears);

-- All teams w conference:
SELECT b.BD_Team AS "Team", l."CONF" AS "Conference"
INTO FinalTeamConference
FROM BigDanceTeams b
LEFT JOIN LastFiveYears l
	ON b.BD_Team = l."TEAM";
	
SELECT "Team"
FROM FinalTeamConference
GROUP BY "Team"
HAVING COUNT(*) > 1

-- Some teams changed conferences - we opted to remove those teams totally
DELETE FROM FinalTeamConference
WHERE "Team" IN (
	'Hampton'
	, 'Valparaiso'
	, 'Northern Kentucky'
	, 'Wichita St'
	, 'Coastal Carolina'
)

DELETE FROM "BigDance"
WHERE "Home_Team" IN (
	'Hampton'
	, 'Valparaiso'
	, 'Northern Kentucky'
	, 'Wichita St'
	, 'Coastal Carolina'
) OR  "Away_Team" IN (
	'Hampton'
	, 'Valparaiso'
	, 'Northern Kentucky'
	, 'Wichita St'
	, 'Coastal Carolina'
)

-- Unneeded in final:
ALTER TABLE "BigDance" DROP "Conference";
	
CREATE VIEW FinalData AS
SELECT *
	, (
		SELECT "Conference" FROM FinalTeamConference c WHERE b."Home_Team" = c."Team" LIMIT 1
	) AS "Home_Conference"
	, (
		SELECT "Conference" FROM FinalTeamConference c WHERE b."Away_Team" = c."Team" LIMIT 1
	) AS "Away_Conference"
FROM "BigDance" b;

SELECT * FROM FinalData
ORDER BY "Year", "Round", "Region Number"
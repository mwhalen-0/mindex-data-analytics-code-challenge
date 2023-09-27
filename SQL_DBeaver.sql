CREATE OR REPLACE VIEW season_summary AS
WITH ReceiverYards AS (
    SELECT
        SUM(CASE WHEN "Receiver" = 'Boyd' THEN "TotalYards" END) AS "Boyd_Yards",
        SUM(CASE WHEN "Receiver" = 'Higgins' THEN "TotalYards" END) AS "Higgins_Yards",
        SUM(CASE WHEN "Receiver" = 'Chase' THEN "TotalYards" END) AS "Chase_Yards"
    FROM (
        SELECT 'Boyd' AS "Receiver", SUM("Boyd_Yards") AS "TotalYards" FROM michael_whalen GROUP BY "Receiver"
        UNION ALL
        SELECT 'Higgins' AS "Receiver", SUM("Higgins_Yards") AS "TotalYards" FROM michael_whalen GROUP BY "Receiver"
        UNION ALL
        SELECT 'Chase' AS "Receiver", SUM("Chase_Yards") AS "TotalYards" FROM michael_whalen GROUP BY "Receiver"
    ) subquery
),
TeamRecord AS (
    SELECT
        SUM(CASE WHEN "Result" = 'Win' THEN 1 ELSE 0 END) AS "Wins",
        SUM(CASE WHEN "Result" = 'Loss' THEN 1 ELSE 0 END) AS "Losses"
    FROM michael_whalen
)
SELECT
    "Boyd_Yards",
    "Higgins_Yards",
    "Chase_Yards",
    "Wins" || '-' || "Losses" AS "Win/Loss"
FROM ReceiverYards, TeamRecord;

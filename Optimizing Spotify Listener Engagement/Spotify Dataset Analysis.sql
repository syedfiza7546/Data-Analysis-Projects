-- Checking dataset 
SELECT * FROM public.spotify
LIMIT 100;

-- the first 10 rows
SELECT * FROM public.spotify LIMIT 10;
-- Counting missing values, there are none, everything is populated
SELECT 
    COUNT(*) AS total_records,
    SUM(CASE WHEN Artist IS NULL THEN 1 ELSE 0 END) AS missing_artist,
    SUM(CASE WHEN Track IS NULL THEN 1 ELSE 0 END) AS missing_track,
    SUM(CASE WHEN Views IS NULL THEN 1 ELSE 0 END) AS missing_views,
    SUM(CASE WHEN Stream IS NULL THEN 1 ELSE 0 END) AS missing_stream
FROM public.spotify;

--remove duplicates, (0 rows affected, no duplicates)
DELETE FROM public.spotify
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM public.spotify
    GROUP BY Track, Artist
);

-- Genre and Music Category Analysis

SELECT Album_type, COUNT(*) AS total_tracks
FROM public.spotify
GROUP BY Album_type
ORDER BY total_tracks DESC;

--popular albums
SELECT Album,  AVG(Views) AS avg_views
FROM public.spotify
GROUP BY Album
ORDER BY avg_views DESC
LIMIT 5;

-- List the top 10 artists with the most songs
SELECT artist, COUNT(*) AS total_songs
FROM spotify
GROUP BY artist
ORDER BY total_songs DESC
LIMIT 10;

--artists with the highest average views per track
SELECT Artist, AVG(Views) AS avg_views
FROM public.spotify
GROUP BY Artist
ORDER BY avg_views DESC
LIMIT 10;

--Popularity by Song Duration
SELECT 
    CASE 
        WHEN Duration_min < 3 THEN 'Short (< 3 mins)'
        WHEN Duration_min BETWEEN 3 AND 5 THEN 'Medium (3-5 mins)'
        ELSE 'Long (> 5 mins)'
    END AS duration_category,
    AVG(Views) AS avg_views,
    COUNT(*) AS total_songs
FROM public.spotify
GROUP BY duration_category
ORDER BY avg_views DESC;

--songs based on energy and liveness
SELECT 
    CASE 
        WHEN Energy > 0.7 AND Liveness > 0.7 THEN 'High Energy & Live'
        WHEN Energy > 0.7 THEN 'High Energy'
        WHEN Liveness > 0.7 THEN 'Live Performance'
        ELSE 'Other'
    END AS cluster,
    COUNT(*) AS total_songs,
    AVG(Views) AS avg_views
FROM public.spotify
GROUP BY cluster;


-- Analyze track releases by month
SELECT 
    EXTRACT(MONTH FROM most_playedon) AS release_month,
    COUNT(*) AS total_tracks
FROM public.spotify
GROUP BY release_month
ORDER BY release_month;


--tracks with featured artists in the title
SELECT 
    COUNT(*) AS total_collaborations,
    AVG(Views) AS avg_views
FROM public.spotify
WHERE Title LIKE '%feat.%' OR Title LIKE '%ft.%';


--views for tracks with and without collaborations
SELECT 
    CASE 
        WHEN Title LIKE '%feat.%' OR Title LIKE '%ft.%' THEN 'Collaboration'
        ELSE 'Solo'
    END AS track_type,
    AVG(Views) AS avg_views,
    COUNT(*) AS total_tracks
FROM public.spotify
GROUP BY track_type;

--songs most frequently added to playlists
SELECT Track, Artist, MAX(Stream) AS max_streams
FROM public.spotify
GROUP BY Track, Artist
ORDER BY max_streams DESC
LIMIT 10;

WITH duration_buckets AS (
    SELECT
        CASE
            WHEN Duration_min < 2 THEN 'Short (< 2 min)'
            WHEN Duration_min BETWEEN 2 AND 4 THEN 'Medium (2-4 min)'
            ELSE 'Long (> 4 min)'
        END AS duration_category,
        COUNT(*) AS total_tracks,
        AVG(Stream) AS avg_streams,
        SUM(Stream) AS total_streams
    FROM public.spotify
    WHERE Duration_min IS NOT NULL 
    GROUP BY duration_category
),
ranked_buckets AS (
    SELECT
        duration_category,
        total_tracks,
        avg_streams,
        total_streams,
        RANK() OVER (ORDER BY total_tracks DESC) AS rank_by_tracks,
        DENSE_RANK() OVER (ORDER BY total_streams DESC) AS rank_by_streams
    FROM duration_buckets
)
SELECT
    duration_category,
    total_tracks,
    avg_streams,
    total_streams,
    rank_by_tracks,
    rank_by_streams
FROM ranked_buckets
ORDER BY rank_by_tracks;

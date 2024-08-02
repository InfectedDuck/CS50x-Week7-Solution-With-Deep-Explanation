SELECT DISTINCT people.name
FROM stars
JOIN people ON stars.person_id=people.id
WHERE stars.movie_id IN (SELECT id FROM movies WHERE year=2004)
ORDER BY people.birth;

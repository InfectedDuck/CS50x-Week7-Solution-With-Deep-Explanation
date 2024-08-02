SELECT DISTINCT people.name
FROM directors
JOIN people ON directors.person_id=people.id
WHERE movie_id IN (
    SELECT id
    FROM movies
    JOIN ratings ON ratings.movie_id=movies.id
    WHERE ratings.rating>=9.0
);

SELECT rating,movies.title
FROM ratings
JOIN movies ON movies.id=ratings.movie_id
WHERE movies.year=2010 and ratings.rating!=""
ORDER BY ratings.rating DESC,movies.title;

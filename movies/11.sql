SELECT movies.title
FROM stars
JOIN movies ON movies.id=stars.movie_id
JOIN people ON people.id=stars.person_id
JOIN ratings ON ratings.movie_id=stars.movie_id
WHERE people.name='Chadwick Boseman'
ORDER BY ratings.rating DESC
LIMIT 5;

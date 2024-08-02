SELECT people.name
FROM stars
JOIN people ON stars.person_id=people.id
WHERE movie_id IN (SELECT id FROM movies WHERE title='Toy Story');

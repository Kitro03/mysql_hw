-- 1 

select count(*) from movies
join companies on companies.id = movies.company_id
where companies.title = 'Universal Pictures'

-- 2

select count(*) from movies
join directors on directors.id = movies.director_id
where directors.full_name = 'Фрэнсис Форд Коппола'

-- 3

SELECT COUNT(*) AS movies_count
FROM movies
WHERE year >= YEAR(CURDATE()) - 20;

-- 4

SELECT distinct genres.title
FROM genres
join movies on movies.genre_id = genres.id
join directors on movies.director_id = directors.id

where directors.full_name = 'Стивен Спилберг'

-- 5

SELECT movies.title, genres.title, directors.full_name
FROM genres
join movies on movies.genre_id = genres.id
join directors on movies.director_id = directors.id
order by movies.budget desc
limit 5

-- 6 

SELECT directors.full_name AS director, COUNT(*) AS total_films
FROM movies
JOIN directors ON movies.director_id = directors.id
GROUP BY director
ORDER BY total_films DESC
LIMIT 1;

-- 7

SELECT movies.title, genres.title AS genre
FROM movies
JOIN genres ON movies.genre_id = genres.id
WHERE movies.company_id = (
    SELECT company_id
    FROM movies
    GROUP BY company_id
    ORDER BY SUM(budget) DESC
    LIMIT 1
);

-- 8

SELECT AVG(budget) AS AverageBudget
FROM movies
JOIN companies ON movies.company_id = companies.id
WHERE companies.title = 'Warner Bros.';

-- 9

SELECT genres.title AS genre, COUNT(*) AS num_movies, AVG(budget) AS average_budget
FROM movies
JOIN genres ON movies.genre_id = genres.id
GROUP BY genres.title;

-- 10

DELETE FROM movies 
WHERE id IN (
    SELECT id FROM (
        SELECT movies.id 
        FROM movies 
        JOIN genres ON movies.genre_id = genres.id 
        WHERE movies.title = 'Дикие истории' AND genres.title = 'комедия'
    ) AS subquery
) AND year = 2014;



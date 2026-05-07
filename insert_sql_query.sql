SELECT name, email, join_date 
FROM members 
ORDER BY join_date DESC 
LIMIT 3;


SELECT title, author 
FROM books 
WHERE category_id = 5;


SELECT rental_id, member_id, book_id, rental_date 
FROM rentals 
WHERE return_date IS NULL;


SELECT rental_id, book_id, rental_date 
FROM rentals 
WHERE rental_date >= '2026-04-15';


SELECT b.title, c.category_name 
FROM books b
INNER JOIN categories c ON b.category_id = c.category_id;


SELECT m.name, b.title, r.rental_date
FROM rentals r
INNER JOIN members m ON r.member_id = m.member_id
INNER JOIN books b ON r.book_id = b.book_id
WHERE m.name = '김철수';


SELECT c.category_name, COUNT(b.book_id) as book_count
FROM categories c LEFT JOIN books b ON c.category_id = b.category_id
GROUP BY c.category_name;


SELECT m.name, m.phone, b.title, r.rental_date
FROM rentals r
INNER JOIN members m ON r.member_id = m.member_id
INNER JOIN books b ON r.book_id = b.book_id
WHERE r.return_date IS NULL;


SELECT category_id, COUNT(*) as total_books
FROM books
GROUP BY category_id;


SELECT member_id, COUNT(rental_id) as rental_count
FROM rentals
GROUP BY member_id
ORDER BY rental_count DESC;


SELECT ROUND(AVG(julianday(return_date) - julianday(rental_date)), 1) as avg_rental_days
FROM rentals
WHERE return_date IS NOT NULL;


SELECT name 
FROM members 
WHERE member_id IN (
    SELECT member_id 
    FROM rentals 
    WHERE book_id IN (
        SELECT book_id 
        FROM books 
        WHERE author = '칼 세이건'
    )
);


UPDATE rentals 
SET return_date = date('now') 
WHERE rental_id = 4;


DELETE FROM categories 
WHERE category_id NOT IN (SELECT DISTINCT category_id FROM books);


CREATE INDEX idx_books_title ON books(title);
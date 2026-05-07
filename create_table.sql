PRAGMA foreign_keys = ON;
-- 1. 회원(members) 테이블
CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    join_date DATE DEFAULT (date('now'))
);  

-- 2. 카테고리(categories) 테이블
CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

-- 3. 도서(books) 테이블
CREATE TABLE books (
    book_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    category_id INTEGER NOT NULL,
    publish_date DATE,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories
);

-- 4. 대출 기록(rentals) 테이블
CREATE TABLE rentals (
    rental_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    rental_date DATE DEFAULT (date('now')),
    return_date DATE, -- 반납되지 않은 경우 NULL
    FOREIGN KEY (member_id) REFERENCES members,
    FOREIGN KEY (book_id) REFERENCES books
);
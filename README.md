## 전체 er-diagram 구조
![alt text](images/image.png)

### DB 실행 방식
- `sqlite3` 명령 통해 sqlite 실행
- `.open test.db` 명령 통해 test.db 파일 생성
- `.read 파일이름.sql` 통해 특정 sql 구문 실행 가능
----

### 1. 스키마 생성 스크립트 (create_table.sql)

#### 총 4개의 테이블(members, categories, books, rentals)을 설계했습니다.

- 1:N 관계 1: categories (1) -> books (many)
- 1:N 관계 2: members (1) -> rentals (many)
- 1:N 관계 3: books (1) -> rentals (many)

- 각 table의 기본키는 따로 입력되지 않더라도 자동으로 입력 및 추가되도록 AUTOINCREMENT 태그 추가
- 외례키 조건 reference 추가하여 해당 attribute에는 대상 table에 있는 내용만 추가되도록 설정
- not null 태그 부여된 열에는 null 값 사용시 에러 발생
- default 태그 값은 insert시 해당 값이 명시되지 않으면 사용될 것

```
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

```


### 2. 샘플 데이터 입력 스크립트 (insert_table.sql)
#### insert into (table) values (내용) 구문을 통해 table에 각 행의 데이터 추가
- 각 table의 기본키는 명시하지 않아도 자동으로 추가될 것 (autoIncrease)

```
-- 회원 데이터 10건
INSERT INTO members (name, email, phone, join_date) VALUES 
('김철수', 'chulsoo@example.com', '010-1111-2222', '2025-10-01'),
('이영희', 'younghee@example.com', '010-3333-4444', '2025-10-05'),
('박민수', 'minsoo@example.com', '010-5555-6666', '2025-10-10'),
('정수진', 'soojin@example.com', '010-7777-8888', '2025-11-02'),
('최동훈', 'donghoon@example.com', '010-9999-0000', '2025-11-15'),
('강지영', 'jiyoung@example.com', '010-1234-5678', '2025-12-01'),
('윤호준', 'hojun@example.com', '010-8765-4321', '2026-01-10'),
('임유리', 'yuri@example.com', '010-1357-2468', '2026-02-20'),
('한성민', 'sungmin@example.com', '010-2468-1357', '2026-03-05'),
('송지아', 'jia@example.com', '010-1122-3344', '2026-04-12');

-- 카테고리 데이터 10건
INSERT INTO categories (category_name) VALUES 
('소설'), ('에세이'), ('역사'), ('과학'), ('IT/프로그래밍'), 
('경제/경영'), ('자기계발'), ('인문학'), ('예술'), ('만화');

-- 도서 데이터 10건
INSERT INTO books (title, author, category_id, publish_date, isbn) VALUES 
('해리포터와 마법사의 돌', 'J.K. 롤링', 1, '1997-06-26', '9788983920677'),
('클린 코드', '로버트 C. 마틴', 5, '2013-12-24', '9788966260959'),
('사피엔스', '유발 하라리', 3, '2015-11-23', '9788934972464'),
('코스모스', '칼 세이건', 4, '2006-12-20', '9788983711892'),
('부의 추월차선', '엠제이 드마코', 6, '2013-08-20', '9788997396144'),
('아주 작은 습관의 힘', '제임스 클리어', 7, '2019-02-26', '9791162540640'),
('이기적 유전자', '리처드 도킨스', 4, '2018-10-20', '9788932473901'),
('객체지향의 사실과 오해', '조영호', 5, '2015-06-17', '9788998139766'),
('침묵의 봄', '레이첼 카슨', 4, '2011-12-30', '9788962620450'),
('군주론', '니콜로 마키아벨리', 8, '2015-05-15', '9788932473338');

-- 대출 데이터 10건 (반납 완료 7건, 미반납 3건)
INSERT INTO rentals (member_id, book_id, rental_date, return_date) VALUES 
(1, 2, '2026-04-01', '2026-04-08'),
(2, 3, '2026-04-05', '2026-04-12'),
(1, 8, '2026-04-10', '2026-04-17'),
(3, 1, '2026-04-12', NULL),  -- 미반납
(4, 5, '2026-04-15', '2026-04-20'),
(5, 4, '2026-04-18', '2026-04-25'),
(6, 6, '2026-04-20', NULL),  -- 미반납
(1, 7, '2026-04-22', '2026-04-29'),
(2, 9, '2026-05-01', NULL),  -- 미반납
(7, 10, '2026-05-02', '2026-05-06');

```
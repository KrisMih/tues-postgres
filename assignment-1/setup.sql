CREATE TABLE students (
    id          SERIAL PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL
);

CREATE TABLE books (
    id      SERIAL PRIMARY KEY,
    title   VARCHAR(200) NOT NULL,
    author  VARCHAR(100) NOT NULL,
    year    INTEGER NOT NULL CHECK (year BETWEEN 1000 AND 2100)
);

CREATE TABLE loans (
    id           SERIAL PRIMARY KEY,
    book_id      INTEGER NOT NULL REFERENCES books(id),
    student_id   INTEGER NOT NULL REFERENCES students(id),
    taken_on     DATE NOT NULL,
    returned_on  DATE,
    CHECK (returned_on IS NULL OR returned_on >= taken_on)
);

CREATE UNIQUE INDEX one_open_loan_per_book
    ON loans(book_id) WHERE returned_on IS NULL;

INSERT INTO students (first_name, last_name) VALUES
('Иван', 'Петров'),
('Мария', 'Георгиева'),
('Георги', 'Димитров'),
('Елена', 'Николова'),
('Петър', 'Стоянов');

INSERT INTO books (title, author, year) VALUES
('Под игото', 'Иван Вазов', 1894),
('Бай Ганьо', 'Алеко Константинов', 1895),
('Тютюн', 'Димитър Димов', 1951),
('Железният светилник', 'Димитър Талев', 1952),
('Малкият принц', 'Антоан дьо Сент-Екзюпери', 1943),
('1984', 'Джордж Оруел', 1949);

INSERT INTO loans (book_id, student_id, taken_on, returned_on) VALUES
(1, 1, '2026-09-01', '2026-09-15'),
(1, 2, '2026-10-01', NULL),
(3, 3, '2026-09-20', NULL),
(6, 1, '2026-10-22', NULL),
(5, 4, '2026-09-05', '2026-10-10'),
(2, 2, '2026-10-15', '2026-10-20'),
(4, 4, '2026-10-24', NULL);
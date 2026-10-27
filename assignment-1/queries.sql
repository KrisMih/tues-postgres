-- Въпрос 1: Кои книги са взети в момента и у кого са?
-- Връща: заглавие, ученик, дата на взимане (само невърнатите книги).
SELECT b.title,
       s.first_name || ' ' || s.last_name AS student,
       l.taken_on
FROM loans l
JOIN books b    ON b.id = l.book_id
JOIN students s ON s.id = l.student_id
WHERE l.returned_on IS NULL
ORDER BY l.taken_on;

-- Въпрос 2: Кой държи книга повече от 14 дни и коя е тя?
-- Връща: ученик, заглавие, дата на взимане, брой дни (невърнати, взети преди повече от 14 дни).
SELECT s.first_name || ' ' || s.last_name AS student,
       b.title,
       l.taken_on,
       CURRENT_DATE - l.taken_on AS days_kept
FROM loans l
JOIN books b    ON b.id = l.book_id
JOIN students s ON s.id = l.student_id
WHERE l.returned_on IS NULL
  AND CURRENT_DATE - l.taken_on > 14
ORDER BY days_kept DESC;
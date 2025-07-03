USE LIBRARYDB2;

CREATE VIEW BorrowHistory AS
SELECT br.record_id, m.name AS member_name, b.title, br.borrow_date, br.return_date,
       DATEDIFF(br.return_date, br.borrow_date) AS duration_days
FROM BorrowRecords br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE br.return_date IS NOT NULL;

CREATE VIEW InactiveMembers AS
SELECT m.member_id, m.name, m.join_date
FROM Members m
WHERE m.member_id NOT IN (
    SELECT DISTINCT member_id FROM BorrowRecords
);

SELECT * FROM BorrowHistory;
SELECT * FROM InactiveMembers;

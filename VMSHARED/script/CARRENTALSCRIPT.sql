DROP TABLE Payment CASCADE CONSTRAINTS;
DROP TABLE Dates CASCADE CONSTRAINTS;
DROP TABLE Rental CASCADE CONSTRAINTS;
DROP TABLE Book_Copy CASCADE CONSTRAINTS;
DROP TABLE Book CASCADE CONSTRAINTS;
DROP TABLE Student CASCADE CONSTRAINTS;
DROP TABLE Author CASCADE CONSTRAINTS;
DROP TABLE Category CASCADE CONSTRAINTS;
DROP TABLE Language CASCADE CONSTRAINTS;
DROP TABLE Publisher CASCADE CONSTRAINTS;


CREATE TABLE Publisher (
  pub_id NUMBER(5) PRIMARY KEY,
  pub_name VARCHAR2(80),
  street NUMBER(3),
  town VARCHAR2(20),
  city VARCHAR2(20),
  country VARCHAR2(50),
  post_code NUMBER(5),
  zip NUMBER(5),
  email VARCHAR2(50),
  phone NUMBER(10)
);

CREATE TABLE Language (
  language_id NUMBER(5) PRIMARY KEY,
  language_name VARCHAR2(50)
);

CREATE TABLE Category (
  category_id NUMBER(5) PRIMARY KEY,
  cat_description VARCHAR2(100)
);

CREATE TABLE Author (
  au_id NUMBER(5) PRIMARY KEY,
  last_name VARCHAR2(50),
  first_name VARCHAR2(50)
);

CREATE TABLE Book (
  book_id NUMBER(5) PRIMARY KEY,
  title VARCHAR2(20),
  isbn VARCHAR2(20),
  year_published NUMBER(4),
  quantity_on_hand NUMBER(5),
  rental_price NUMBER(10,2),
  publisher_id NUMBER(5),
  language_id NUMBER(5),
  category_id NUMBER(5),
  author_id NUMBER(5),
  FOREIGN KEY (publisher_id) REFERENCES Publisher(pub_id),
  FOREIGN KEY (language_id) REFERENCES Language(language_id),
  FOREIGN KEY (category_id) REFERENCES Category(category_id),
  FOREIGN KEY (author_id) REFERENCES Author(au_id)
);

CREATE TABLE Book_Copy (
  book_copy_barcode VARCHAR2(30) PRIMARY KEY,
  copy_status VARCHAR2(20),
  book_id NUMBER(5),
  FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

CREATE TABLE Student (
  student_id NUMBER(5) PRIMARY KEY,
  last_name VARCHAR2(50),
  first_name VARCHAR2(50),
  date_of_birth DATE,
  nic VARCHAR2(15),
  mobile NUMBER(8),
  email VARCHAR2(80),
  street NUMBER(3),
  town VARCHAR2(20),
  district VARCHAR2(50),
  post_code NUMBER(5),
  gender VARCHAR2(10)
);

CREATE TABLE Rental (
  rental_id NUMBER(5) PRIMARY KEY,
  rental_date DATE,
  student_id NUMBER(5),
  FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Dates (
  rental_id NUMBER(5),
  book_copy_barcode VARCHAR2(30),
  rental_date DATE,
  rental_due_date DATE,
  rental_returning_date DATE,
  PRIMARY KEY (rental_id, book_copy_barcode),
  FOREIGN KEY (rental_id) REFERENCES Rental(rental_id),
  FOREIGN KEY (book_copy_barcode) REFERENCES Book_Copy(book_copy_barcode)
);

CREATE TABLE Payment (
  pay_id NUMBER(5) PRIMARY KEY,
  pay_date DATE,
  pay_amount NUMBER(10,2),
  pay_method VARCHAR2(20),
  rental_id NUMBER(5),
  FOREIGN KEY (rental_id) REFERENCES Rental(rental_id)
);

-- PUBLISHERS
INSERT INTO Publisher VALUES (001, 'Island books publishing', 12, 'Quatre bornes', 'Mauritius', 'Mauritius', 11586, 15651, 'info@islandbook.mu', 2305988429);
INSERT INTO Publisher VALUES (002, 'Maple ink press', 204, 'King', 'Toronto', 'Canada', 9846, 8498, 'contact@mapleink.ca', 1416291849);
INSERT INTO Publisher VALUES (003, 'Red panga publishing', 91, 'Orchard', 'Ottawa', 'Canada', 4988, 4986, 'red@panda.ca', 1416198498);
INSERT INTO Publisher VALUES (004, 'Aurora House publication', 8, 'Crescent', 'Port louis', 'Mauritius', 15485, 48549, 'contact@aurorapub.mu', 2301564789);
INSERT INTO Publisher VALUES (005, 'Blue Horizon', 199, 'Pacific', 'Texas', 'USA', 91871, 89165, 'support@bluehorizon.com', 1415581432);

-- LANGUAGES
INSERT INTO Language VALUES (020, 'English');
INSERT INTO Language VALUES (021, 'Japanese');
INSERT INTO Language VALUES (022, 'Chinese');
INSERT INTO Language VALUES (023, 'Spanish');
INSERT INTO Language VALUES (025, 'French');

-- CATEGORIES
INSERT INTO Category VALUES (101, 'Life science');
INSERT INTO Category VALUES (102, 'Computer');
INSERT INTO Category VALUES (103, 'Motivational');
INSERT INTO Category VALUES (104, 'Self-awareness and study');
INSERT INTO Category VALUES (105, 'Romance');

-- AUTHORS
INSERT INTO Author VALUES (501, 'Mc Carthy', 'Paul');
INSERT INTO Author VALUES (502, 'Lorenzo', 'Marie');
INSERT INTO Author VALUES (503, 'Connor', 'Henri');
INSERT INTO Author VALUES (504, 'Han', 'Covey');
INSERT INTO Author VALUES (505, 'Hossen', 'Anju');

-- BOOKS
INSERT INTO Book VALUES (010, 'Biology Matters', '14-8717-498-549', 2005, 80, 400.00, 001, 020, 101, 501);
INSERT INTO Book VALUES (012, 'Database concept', '28-6517-9794', 2014, 20, 600.00, 002, 020, 102, 502);
INSERT INTO Book VALUES (013, 'Our left eyes', '684-654987-864', 1998, 10, 1200.00, 001, 020, 104, 503);
INSERT INTO Book VALUES (014, 'Computer science', '984-497-94989', 2015, 50, 500.00, 003, 025, 102, 524);
INSERT INTO Book VALUES (015, 'Quiet', '794-684-9889', 2020, 70, 450.00, 004, 025, 104, 540);

-- BOOK COPIES
INSERT INTO Book_Copy VALUES ('01564851849', 'Good', 010);
INSERT INTO Book_Copy VALUES ('0468654684', 'Good', 012);
INSERT INTO Book_Copy VALUES ('1648468498', 'Damaged', 010);
INSERT INTO Book_Copy VALUES ('546846846', 'Good', 013);
INSERT INTO Book_Copy VALUES ('548466464', 'Lost', 010);

-- STUDENTS
INSERT INTO Student VALUES (700, 'Hassal', 'Eric', TO_DATE('10-10-2005','DD-MM-YYYY'), '51165198652', 58365151, 'Hassal.eric@gmail.com', 12, 'Port Louis', 'Port Louis', 1486, 'Male');
INSERT INTO Student VALUES (701, 'Kim', 'Joshua', TO_DATE('12-01-2004','DD-MM-YYYY'), '6598516541', 51654961, 'kimjoshua@gmail.com', 51, 'Moka', 'Moka', 5168, 'Female');
INSERT INTO Student VALUES (702, 'Lovasoa', 'Aina', TO_DATE('13-07-2000','DD-MM-YYYY'), 'A15X1841651', 52111115987, 'loaina@gmail.com', 65, 'Curepipe', 'Curepipe', 5498, 'Female');
INSERT INTO Student VALUES (703, 'Rabarijohn', 'Kanto', TO_DATE('18-01-2005','DD-MM-YYYY'), 'A15X62498', 54161648, 'rabharinjiva@gmail.com', 58, 'Curepipe', 'Curepipe', 5499, 'Male');
INSERT INTO Student VALUES (704, 'Velontsoa', 'Harena', TO_DATE('19-09-1998','DD-MM-YYYY'), 'A20X846111', 59154651, 'veloharena@gmail.com', 29, 'Pailles', 'Pailles', 1684, 'Male');

-- RENTALS
INSERT INTO Rental VALUES (420, TO_DATE('18-05-2024','DD-MM-YYYY'), 700);
INSERT INTO Rental VALUES (421, TO_DATE('24-06-2025','DD-MM-YYYY'), 701);
INSERT INTO Rental VALUES (422, TO_DATE('30-04-2025','DD-MM-YYYY'), 700);
INSERT INTO Rental VALUES (423, TO_DATE('30-12-2024','DD-MM-YYYY'), 702);
INSERT INTO Rental VALUES (424, TO_DATE('12-12-2024','DD-MM-YYYY'), 704);

-- DATES
INSERT INTO Dates VALUES (420, '01564851849', TO_DATE('18-05-2024','DD-MM-YYYY'), TO_DATE('18-06-2024','DD-MM-YYYY'), TO_DATE('26-05-2024','DD-MM-YYYY'));
INSERT INTO Dates VALUES (421, '0468654684', TO_DATE('24-06-2025','DD-MM-YYYY'), TO_DATE('24-07-2025','DD-MM-YYYY'), TO_DATE('21-07-2025','DD-MM-YYYY'));
INSERT INTO Dates VALUES (422, '1648468498', TO_DATE('30-04-2025','DD-MM-YYYY'), TO_DATE('30-05-2025','DD-MM-YYYY'), TO_DATE('03-05-2025','DD-MM-YYYY'));
INSERT INTO Dates VALUES (423, '546846846', TO_DATE('30-12-2024','DD-MM-YYYY'), TO_DATE('30-01-2025','DD-MM-YYYY'), TO_DATE('30-01-2025','DD-MM-YYYY'));
INSERT INTO Dates VALUES (424, '548466464', TO_DATE('12-12-2024','DD-MM-YYYY'), TO_DATE('12-01-2025','DD-MM-YYYY'), NULL);

-- PAYMENTS
INSERT INTO Payment VALUES (1001, TO_DATE('18-05-2024','DD-MM-YYYY'), 400.00, 'Juice', 420);
INSERT INTO Payment VALUES (1002, TO_DATE('24-06-2025','DD-MM-YYYY'), 600.00, 'Debit card', 421);
INSERT INTO Payment VALUES (1003, TO_DATE('30-04-2025','DD-MM-YYYY'), 400.00, 'Juice', 422);
INSERT INTO Payment VALUES (1004, TO_DATE('30-12-2024','DD-MM-YYYY'), 1200.00, 'Cheque', 423);
INSERT INTO Payment VALUES (1005, TO_DATE('12-12-2024','DD-MM-YYYY'), 400.00, 'Juice', 424);


SELECT title, isbn
FROM book
WHERE category_id = 101;

SELECT title, isbn
FROM book
WHERE author_id = 501;

SELECT *
FROM book
WHERE publisher_id = 001;

SELECT *
FROM book
WHERE year_published BETWEEN 2000 AND 2020;

SELECT d.book_copy_barcode, b.title
FROM dates d
JOIN book_copy bc ON d.book_copy_barcode = bc.book_copy_barcode
JOIN book b ON bc.book_id = b.book_id
WHERE d.rental_returning_date IS NULL
  AND d.rental_due_date = TO_DATE('12-01-2025', 'DD-MM-YYYY');

SELECT bc.book_copy_barcode, bc.copy_status
FROM book_copy bc
WHERE bc.book_id = 010
  AND LOWER(bc.copy_status) = 'good'
  AND bc.book_copy_barcode NOT IN (
    SELECT d.book_copy_barcode
    FROM dates d
    WHERE d.rental_date <= TO_DATE('15-06-2024', 'DD-MM-YYYY')
      AND (d.rental_returning_date IS NULL OR d.rental_returning_date > TO_DATE('15-06-2024', 'DD-MM-YYYY'))
  );

SELECT *
FROM payment
WHERE pay_date = TO_DATE('18-05-2024', 'DD-MM-YYYY');

SELECT b.title, SUM(p.pay_amount) AS total_revenue
FROM book b
JOIN book_copy bc ON b.book_id = bc.book_id
JOIN dates d ON bc.book_copy_barcode = d.book_copy_barcode
JOIN rental r ON d.rental_id = r.rental_id
JOIN payment p ON r.rental_id = p.rental_id
WHERE b.book_id = 010
GROUP BY b.title;

SELECT DISTINCT s.last_name, s.first_name
FROM student s
JOIN rental r ON s.student_id = r.student_id
JOIN dates d ON r.rental_id = d.rental_id
JOIN book_copy bc ON d.book_copy_barcode = bc.book_copy_barcode
WHERE bc.book_id = 010;

SELECT DISTINCT b.*
FROM book_copy bc
JOIN book b ON bc.book_id = b.book_id
WHERE LOWER(bc.copy_status) = 'lost';

CREATE SEQUENCE seq_pub_id START WITH 6 INCREMENT BY 1;
CREATE SEQUENCE seq_language_id START WITH 26 INCREMENT BY 1;
CREATE SEQUENCE seq_category_id START WITH 106 INCREMENT BY 1;
CREATE SEQUENCE seq_au_id START WITH 506 INCREMENT BY 1;
CREATE SEQUENCE seq_book_id START WITH 16 INCREMENT BY 1;
CREATE SEQUENCE seq_student_id START WITH 705 INCREMENT BY 1;
CREATE SEQUENCE seq_rental_id START WITH 425 INCREMENT BY 1;
CREATE SEQUENCE seq_pay_id START WITH 1006 INCREMENT BY 1;

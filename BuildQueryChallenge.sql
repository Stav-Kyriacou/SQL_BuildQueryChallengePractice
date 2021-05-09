--Stavros Kyriacou 101610510

--RELATIONAL SCHEMA

--Subject (SubjectCode, Description)
--PRIMARY KEY (SubjCode)

--Teacher (StaffID, Surname, GivenName)
--PRIMARY KEY (StaffID)

--Student (StudentID, Surname, GIvenName, Gender)
--PRIMARY KEY (StudentID)

--SubjectOffering (Year, Semester, Fee, SubjCode, StaffID)
--PRIMARY KEY (Year, Semester, Subjcode)
--FOREIGN KEY (SubjCode) REFERENCES Subject
--FOREIGN KEY (StaffID) REFERENCES Teacher

--Enrolment (StudentID, Year, Semester)
--PRIMARY KEY (StudenID, Year, Semester)
--FOREIGN KEY (StudentID) REFERENCES Student
--FOREIGN KEY (Year, Semester) REFERENCES SubjectOffering

IF OBJECT_ID('ENROLMENT') IS NOT NULL
    DROP TABLE ENROLMENT;

IF OBJECT_ID('SUBJECT_OFFERING') IS NOT NULL
    DROP TABLE SUBJECT_OFFERING;

IF OBJECT_ID('TEACHER') IS NOT NULL
    DROP TABLE TEACHER;

IF OBJECT_ID('STUDENT') IS NOT NULL
    DROP TABLE STUDENT;

IF OBJECT_ID('SUBJECT') IS NOT NULL
    DROP TABLE SUBJECT;


CREATE TABLE SUBJECT(
    SubjCode        NVARCHAR(100)
,   Description     NVARCHAR(500)
,   PRIMARY KEY (SubjCode)
);

CREATE TABLE TEACHER(
    StaffID         INT CHECK (LEN(StaffID) = 8)
,   Surname         NVARCHAR(100) NOT NULL
,   GivenName       NVARCHAR(100) NOT NULL
,   PRIMARY KEY (StaffID)
);

CREATE TABLE STUDENT(
    StudentID       NVARCHAR(10)
,   Surname         NVARCHAR(100) NOT NULL
,   GivenName       NVARCHAR(100) NOT NULL
,   Gender          NVARCHAR(1) CHECK (Gender IN ('M', 'F', 'I'))
,   PRIMARY KEY (StudentID)
);

CREATE TABLE SUBJECT_OFFERING(
    SubjCode        NVARCHAR(100)
,   Year            INT CHECK (LEN(Year) = 4)
,   Semester        INT CHECK (Semester IN (1, 2))
,   Fee             INT CHECK (Fee > 0) NOT NULL
,   StaffID         INT 
,   PRIMARY KEY (SubjCode, Year, Semester)
,   FOREIGN KEY (SubjCode) REFERENCES SUBJECT(SubjCode)
,   FOREIGN KEY (StaffID) REFERENCES TEACHER(StaffID)
);

CREATE TABLE ENROLMENT(
    StudentID       NVARCHAR(10)
,   SubjCode        NVARCHAR(100)
,   Year            INT CHECK (LEN(Year) = 4)
,   Semester        INT CHECK (Semester IN (1, 2))
,   Grade           NVARCHAR(2) CHECK (Grade IN ('N', 'P', 'C', 'D', 'HD')) DEFAULT NULL
,   DateEnrolled    DATE
,   PRIMARY KEY (StudentID, SubjCode, Year, Semester)
,   FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID)
,   FOREIGN KEY (SubjCode, Year, Semester) REFERENCES SUBJECT_OFFERING(SubjCode, Year, Semester)
);

INSERT INTO SUBJECT 
(SubjCode,      Description) VALUES
('ICTWEB425',   'Apply SQL to extract & manipulate data'),
('ICTDBS403',   'Create Basic Databases'),
('ICTDBS502',   'Design a Database');

INSERT INTO TEACHER 
(StaffID,   Surname,        GivenName) VALUES
(98776655,  'Starr',        'Ringo'),
(87665544,  'Lennon',       'John'),
(76554433,  'McCartney',    'Paul');

INSERT INTO STUDENT 
(StudentID,     Surname,    GivenName,  Gender) VALUES
('s12233445',	'Morrison',	'Scott',	'M'),
('s23344556',	'Gillard',	'Julia',	'F'),
('s34455667',	'Whitlam',	'Gough',	'M'),
('s101610510',  'Kyriacou', 'Stavros',  'M');

INSERT INTO SUBJECT_OFFERING 
(SubjCode,      Year,   Semester,   Fee,    StaffID) VALUES
('ICTWEB425',	2020,	1,	        200,	98776655),
('ICTWEB425',	2021,	1,	        225,	98776655),
('ICTDBS403',	2021,	1,	        200,	87665544),
('ICTDBS403',	2021,	2,	        200,	76554433),
('ICTDBS502',	2021,	2,	        225,	87665544);

INSERT INTO ENROLMENT 
(StudentID,     SubjCode,       Year,   Semester,   Grade,  DateEnrolled) VALUES
('s12233445',	'ICTWEB425',	2020,	1,	        'D',	'2019-02-25'),
('s23344556',	'ICTWEB425',	2020,	1,	        'P',	'2019-02-15'),
('s12233445',	'ICTWEB425',	2021,	1,	        'C',	'2020-01-29'),
('s23344556',	'ICTWEB425',	2021,	1,	        'HD',	'2020-02-26'),
('s34455667',	'ICTWEB425',	2020,	1,	        'P',	'2020-01-28'),
('s12233445',	'ICTDBS403',	2021,	1,	        'C',	'2020-02-08'),
('s23344556',	'ICTDBS403',	2021,	2,	        NULL,   '2021-02-21'),
('s34455667',	'ICTDBS403',	2021,	2,	        NULL,   '2021-03-03'),
('s23344556',	'ICTDBS502',	2021,	2,	        'P',	'2019-07-01'),
('s34455667',	'ICTDBS502',	2021,	2,	        'N',    '2019-07-13');

SELECT stu.GivenName, stu.Surname, e.SubjCode, sub.Description, e.Year, e.Semester, offer.Fee, t.GivenName, t.Surname
FROM STUDENT stu
INNER JOIN ENROLMENT e
ON stu.StudentID = e.StudentID

INNER JOIN SUBJECT sub
ON e.SubjCode = sub.SubjCode

INNER JOIN SUBJECT_OFFERING offer
ON e.SubjCode = offer.SubjCode

INNER JOIN TEACHER t
ON offer.StaffID = t.StaffID



SELECT Year, Semester, Count(*) AS 'Num Enrollments'
FROM ENROLMENT
GROUP BY Year, Semester

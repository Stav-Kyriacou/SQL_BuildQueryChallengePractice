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

IF OBJECT_ID('SUBJECT_OFFERING') IS NOT NULL
    DROP TABLE SUBJECT_OFFERING;

IF OBJECT_ID('ENROLMENT') IS NOT NULL
    DROP TABLE ENROLMENT;

IF OBJECT_ID('SUBJECT') IS NOT NULL
    DROP TABLE SUBJECT;

IF OBJECT_ID('TEACHER') IS NOT NULL
    DROP TABLE TEACHER;

IF OBJECT_ID('STUDENT') IS NOT NULL
    DROP TABLE STUDENT;


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
,   Fee             MONEY CHECK (Fee > 0) NOT NULL
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


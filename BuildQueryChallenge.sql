--Stavros Kyriacou 101610510

--RELATIONAL SCHEMA

--Subject (SubjectCode, Description)
--PRIMARY KEY (SubjCode)

--Teacher (StaffID, Surname, GivenName)
--PRIMARY KEY (StaffID)

--SubjectOffering (Year, Semester, Fee, SubjCode)
--PRIMARY KEY (Year, Semester, Subjcode)
--FOREIGN KEY (SubjCode) REFERENCES Subject

--Student (StudentID, Surname, GIvenName, Gender)
--PRIMARY KEY (StudentID)

--Enrolment (StudentID, Year, Semester)
--PRIMARY KEY (StudenID, Year, Semester)
--FOREIGN KEY (StudentID) REFERENCES Student
--FOREIGN KEY (Year, Semester) REFERENCES SubjectOffering
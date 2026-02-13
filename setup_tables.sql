-- Run this in Access 2007 Query SQL View
-- Create -> Query Design -> Close tables -> SQL View
-- Then copy-paste all of this and click Run (!)

CREATE TABLE Students (
    ID AUTOINCREMENT PRIMARY KEY,
    FullName TEXT(100),
    Email TEXT(100),
    Grade TEXT(10),
    TargetYear TEXT(4),
    Password TEXT(100),
    CreatedDate DATE,
    LastLogin DATE
);

CREATE TABLE Courses (
    ID AUTOINCREMENT PRIMARY KEY,
    StudentID INTEGER,
    CourseName TEXT(100),
    CourseCode TEXT(20),
    Category TEXT(10),
    CourseType TEXT(5),
    Grade INTEGER,
    Credits DOUBLE,
    Status TEXT(20),
    Term TEXT(20),
    Year INTEGER
);

CREATE TABLE Universities (
    ID AUTOINCREMENT PRIMARY KEY,
    Name TEXT(100),
    OUACCode TEXT(10),
    Location TEXT(100),
    Website TEXT(200),
    MinGPA DOUBLE,
    CompetitiveGPA DOUBLE,
    RequiresENG4U YESNO,
    RequiresCalculus YESNO,
    ApplicationDeadline DATE,
    PopularPrograms MEMO,
    Ranking INTEGER,
    AdmissionLink TEXT(200)
);

CREATE TABLE Programs (
    ID AUTOINCREMENT PRIMARY KEY,
    UniID INTEGER,
    ProgramName TEXT(100),
    ProgramCode TEXT(20),
    Description MEMO,
    Duration TEXT(50),
    MinGPA DOUBLE,
    RequiredCourses MEMO,
    ApplicationDeadline DATE,
    Tuition TEXT(50)
);

CREATE TABLE Applications (
    ID AUTOINCREMENT PRIMARY KEY,
    StudentID INTEGER,
    UniID INTEGER,
    ProgramID INTEGER,
    Status TEXT(20),
    ApplicationDate DATE,
    OUACReference TEXT(50),
    Notes MEMO,
    CreatedDate DATE
);

CREATE TABLE PersonalStatements (
    ID AUTOINCREMENT PRIMARY KEY,
    ApplicationID INTEGER,
    SectionName TEXT(50),
    Content MEMO,
    Version INTEGER,
    IsFinal YESNO,
    LastModified DATE
);

CREATE TABLE Recommendations (
    ID AUTOINCREMENT PRIMARY KEY,
    StudentID INTEGER,
    RefereeName TEXT(100),
    RefereeEmail TEXT(100),
    RefereeTitle TEXT(100),
    Status TEXT(20),
    RequestDate DATE,
    SubmitDate DATE,
    Notes MEMO
);

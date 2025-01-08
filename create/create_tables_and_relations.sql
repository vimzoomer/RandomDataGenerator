CREATE TABLE Courses (
    CourseID INT NOT NULL IDENTITY(1,1),
    ServiceID INT NOT NULL,
    Price MONEY NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Description TEXT NOT NULL,
    Advance MONEY NOT NULL,
    PersonLimit INT NOT NULL,
    CONSTRAINT Courses_pk PRIMARY KEY (CourseID)
);

CREATE TABLE Employee (
    EmployeeID INT NOT NULL IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Login VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Region VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Phone VARCHAR(50) NOT NULL,
    CONSTRAINT Employee_pk PRIMARY KEY (EmployeeID)
);

CREATE TABLE EmployeeRoles (
    RoleID INT NOT NULL,
    EmployeeID INT NOT NULL,
    CONSTRAINT EmployeeRoles_pk PRIMARY KEY (EmployeeID, RoleID)
);

CREATE TABLE Exams (
    ExamID INT NOT NULL IDENTITY(1,1),
    Passed BIT NOT NULL,
    Date DATE NOT NULL,
    StudiesID INT NOT NULL,
    UserID INT NOT NULL,
    CONSTRAINT Exams_pk PRIMARY KEY (ExamID)
);

CREATE TABLE InternishipDays (
    InternshipDayID INT NOT NULL IDENTITY(1,1),
    Date DATETIME NOT NULL,
    InternshipID INT NOT NULL,
    WasPresent BIT NOT NULL,
    CONSTRAINT InternishipDays_pk PRIMARY KEY (InternshipDayID)
);

CREATE TABLE Internships (
    InternshipID INT NOT NULL IDENTITY(1,1),
    Passed BIT NOT NULL,
    StudiesID INT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    UserID INT NOT NULL,
    CONSTRAINT Internships_pk PRIMARY KEY (InternshipID)
);

CREATE TABLE Meeting (
    MeetingID INT NOT NULL IDENTITY(1,1),
    TypeOfMeetingID INT NOT NULL,
    ClassromNo INT NULL,
    BuildingNo INT NULL,
    MeetingLink VARCHAR(100) NULL,
    RecordingLink VARCHAR(100) NULL,
    TranslatorID INT NULL,
    LecturerID INT NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Description TEXT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Language VARCHAR(50) NOT NULL,
    ModuleID INT NOT NULL,
    CONSTRAINT Meeting_pk PRIMARY KEY (MeetingID)
);

CREATE TABLE Module (
    ModuleID INT NOT NULL IDENTITY(1,1),
    CourseID INT NULL,
    LecturerID INT NOT NULL,
    IndividualPrice MONEY NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Price MONEY NOT NULL,
    ModuleProgrammeID INT NULL,
    StudiesID INT NULL,
    PersonLimit INT NOT NULL,
    ServiceID INT NOT NULL,
    CONSTRAINT Module_pk PRIMARY KEY (ModuleID)
);

CREATE TABLE Orders (
    OrderID INT NOT NULL IDENTITY(1,1),
    OrderDate DATETIME NOT NULL,
    ShipAddress VARCHAR(50) NOT NULL,
    ShipCity VARCHAR(50) NOT NULL,
    UserID INT NOT NULL,
    CONSTRAINT Orders_pk PRIMARY KEY (OrderID)
);

CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ServiceID INT NOT NULL,
    OrderDetailsID INT NOT NULL IDENTITY(1,1),
    ShippedDate DATE NOT NULL,
    CONSTRAINT OrderDetails_pk PRIMARY KEY (OrderDetailsID)
);

CREATE TABLE Payments (
    PaymentID INT NOT NULL IDENTITY(1,1),
    Paid BIT NOT NULL,
    AdvancePaid BIT NULL,
    OrderDetailsID INT NOT NULL,
    ServiceID INT NOT NULL,
    DueDate DATE NOT NULL,
    CONSTRAINT PaymentID PRIMARY KEY (PaymentID)
);

CREATE TABLE Roles (
    RoleID INT NOT NULL IDENTITY(1,1),
    RoleName VARCHAR(50) NOT NULL,
    CONSTRAINT Roles_pk PRIMARY KEY (RoleID)
);

CREATE TABLE Schedule (
    ScheduleID INT NOT NULL IDENTITY(1,1),
    MeetingID INT NULL,
    WasPresent BIT NOT NULL,
    WebinarID INT NULL,
    MadeUp BIT NULL,
    PaymentID INT NOT NULL,
    CONSTRAINT Schedule_pk PRIMARY KEY (ScheduleID)
);

CREATE TABLE Services (
    ServiceID INT NOT NULL IDENTITY(1,1),
    TypeOfServiceID INT NOT NULL,
    CONSTRAINT Services_pk PRIMARY KEY (ServiceID)
);

CREATE TABLE Studies (
    StudiesID INT NOT NULL IDENTITY(1,1),
    ServiceID INT NOT NULL,
    ProgrammeID INT NOT NULL,
    Price MONEY NOT NULL,
    StartDate DATETIME NOT NULL,
    PersonLimit INT NOT NULL,
    Ready BIT NOT NULL,
    CONSTRAINT Studies_pk PRIMARY KEY (StudiesID)
);

CREATE TABLE StudiesProgramme (
    ProgrammeID INT NOT NULL IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Description TEXT NOT NULL,
    CONSTRAINT StudiesProgramme_pk PRIMARY KEY (ProgrammeID)
);

CREATE TABLE StudiesProgrammeModules (
    ModuleProgrammeID INT NOT NULL IDENTITY(1,1),
    ProgrammeID INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Description TEXT NOT NULL,
    CONSTRAINT StudiesProgrammeModules_pk PRIMARY KEY (ModuleProgrammeID)
);

CREATE TABLE TypeOfMeeting (
    TypeOfMeetingID INT NOT NULL IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Description TEXT NOT NULL,
    CONSTRAINT TypeOfMeeting_pk PRIMARY KEY (TypeOfMeetingID)
);

CREATE TABLE TypeOfService (
    TypeOfServiceID INT NOT NULL IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Description TEXT NOT NULL,
    CONSTRAINT TypeOfService_pk PRIMARY KEY (TypeOfServiceID)
);

CREATE TABLE [User] (
    UserID INT NOT NULL IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Login VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Region VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Phone VARCHAR(50) NOT NULL,
    CONSTRAINT User_pk PRIMARY KEY (UserID)
);

CREATE TABLE Webinars (
    WebinarID INT NOT NULL IDENTITY(1,1),
    ServiceID INT NOT NULL,
    LecturerID INT NOT NULL,
    TranslatorID INT NOT NULL,
    Price MONEY NULL,
    MeetingLink VARCHAR(100) NOT NULL,
    RecordingLink VARCHAR(100) NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Title TEXT NOT NULL,
    Description TEXT NOT NULL,
    Language VARCHAR(50) NOT NULL,
    CONSTRAINT Webinars_pk PRIMARY KEY (WebinarID)
);

ALTER TABLE EmployeeRoles ADD CONSTRAINT EmployeeRoles_Employee
    FOREIGN KEY (EmployeeID)
    REFERENCES Employee (EmployeeID);

ALTER TABLE EmployeeRoles ADD CONSTRAINT EmployeeRoles_Roles
    FOREIGN KEY (RoleID)
    REFERENCES Roles (RoleID);

ALTER TABLE Exams ADD CONSTRAINT Exams_Studies
    FOREIGN KEY (StudiesID)
    REFERENCES Studies (StudiesID);

ALTER TABLE Exams ADD CONSTRAINT Exams_User
    FOREIGN KEY (UserID)
    REFERENCES "User" (UserID);

ALTER TABLE InternishipDays ADD CONSTRAINT InternishipDays_Internships
    FOREIGN KEY (InternshipID)
    REFERENCES Internships (InternshipID);

ALTER TABLE Internships ADD CONSTRAINT Internships_Studies
    FOREIGN KEY (StudiesID)
    REFERENCES Studies (StudiesID);

ALTER TABLE Internships ADD CONSTRAINT Internships_User
    FOREIGN KEY (UserID)
    REFERENCES "User" (UserID);

ALTER TABLE Meeting ADD CONSTRAINT Meeting_Employee
    FOREIGN KEY (LecturerID)
    REFERENCES Employee (EmployeeID);

ALTER TABLE Meeting ADD CONSTRAINT Meeting_Employee2
    FOREIGN KEY (TranslatorID)
    REFERENCES Employee (EmployeeID);

ALTER TABLE Meeting ADD CONSTRAINT Meeting_Module
    FOREIGN KEY (ModuleID)
    REFERENCES Module (ModuleID);

ALTER TABLE Module ADD CONSTRAINT Meetings_Courses
    FOREIGN KEY (CourseID)
    REFERENCES Courses (CourseID);

ALTER TABLE Module ADD CONSTRAINT Module_Employee
    FOREIGN KEY (LecturerID)
    REFERENCES Employee (EmployeeID);

ALTER TABLE Module ADD CONSTRAINT Module_Studies
    FOREIGN KEY (StudiesID)
    REFERENCES Studies (StudiesID);

ALTER TABLE OrderDetails ADD CONSTRAINT OrderDetails_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

ALTER TABLE Orders ADD CONSTRAINT Orders_User
    FOREIGN KEY (UserID)
    REFERENCES "User" (UserID);

ALTER TABLE Payments ADD CONSTRAINT Payments_OrderDetails
    FOREIGN KEY (OrderDetailsID)
    REFERENCES OrderDetails (OrderDetailsID);

ALTER TABLE Payments ADD CONSTRAINT Payments_Services
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

ALTER TABLE Schedule ADD CONSTRAINT Schedule_Meeting
    FOREIGN KEY (MeetingID)
    REFERENCES Meeting (MeetingID);

ALTER TABLE Schedule ADD CONSTRAINT Schedule_Payments
    FOREIGN KEY (PaymentID)
    REFERENCES Payments (PaymentID);

ALTER TABLE Schedule ADD CONSTRAINT Schedule_Schedule
    FOREIGN KEY (ScheduleID)
    REFERENCES Schedule (ScheduleID);

ALTER TABLE Courses ADD CONSTRAINT Services_Courses
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

ALTER TABLE Module ADD CONSTRAINT Services_Module
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

ALTER TABLE OrderDetails ADD CONSTRAINT Services_OrderDetails
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

ALTER TABLE Studies ADD CONSTRAINT Services_Studies
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

ALTER TABLE Services ADD CONSTRAINT Services_TypeOfService
    FOREIGN KEY (TypeOfServiceID)
    REFERENCES TypeOfService (TypeOfServiceID);

ALTER TABLE Webinars ADD CONSTRAINT Services_Webinars
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

ALTER TABLE StudiesProgrammeModules ADD CONSTRAINT StudiesProgrammeModules_StudiesProgramme
    FOREIGN KEY (ProgrammeID)
    REFERENCES StudiesProgramme (ProgrammeID);

ALTER TABLE Studies ADD CONSTRAINT Studies_StudiesProgramme
    FOREIGN KEY (ProgrammeID)
    REFERENCES StudiesProgramme (ProgrammeID);

ALTER TABLE Meeting ADD CONSTRAINT TypeOfMeeting_Meeting
    FOREIGN KEY (TypeOfMeetingID)
    REFERENCES TypeOfMeeting (TypeOfMeetingID);

ALTER TABLE Webinars ADD CONSTRAINT Webinars_Employee
    FOREIGN KEY (LecturerID)
    REFERENCES Employee (EmployeeID);

ALTER TABLE Webinars ADD CONSTRAINT Webinars_Employee2
    FOREIGN KEY (TranslatorID)
    REFERENCES Employee (EmployeeID);

ALTER TABLE Schedule ADD CONSTRAINT Webinars_Schedule
    FOREIGN KEY (WebinarID)
    REFERENCES Webinars (WebinarID);
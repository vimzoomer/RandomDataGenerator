-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-01-06 23:42:46.023

-- tables
-- Table: Courses
CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) NOT NULL,
    ServiceID INT NOT NULL,
    Price MONEY NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Description TEXT NOT NULL,
    Advance MONEY NOT NULL,
    PersonLimit INT NOT NULL,
    CONSTRAINT Courses_pk PRIMARY KEY (CourseID)
);

-- Table: Employee
CREATE TABLE Employee (
    EmployeeID INT IDENTITY(1,1) NOT NULL,
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

-- Table: EmployeeRoles
CREATE TABLE EmployeeRoles (
    RoleID INT NOT NULL,
    EmployeeID INT NOT NULL,
    CONSTRAINT EmployeeRoles_pk PRIMARY KEY (EmployeeID, RoleID)
);

-- Table: Exams
CREATE TABLE Exams (
    ExamID INT IDENTITY(1,1) NOT NULL,
    Passed BIT NOT NULL,
    Date DATE NOT NULL,
    StudiesID INT NOT NULL,
    UserID INT NOT NULL,
    CONSTRAINT Exams_pk PRIMARY KEY (ExamID)
);

-- Table: InternishipDays
CREATE TABLE InternishipDays (
    InternshipDayID INT IDENTITY(1,1) NOT NULL,
    Date DATETIME NOT NULL,
    InternshipID INT NOT NULL,
    WasPresent BIT NOT NULL,
    CONSTRAINT InternishipDays_pk PRIMARY KEY (InternshipDayID)
);

-- Table: Internships
CREATE TABLE Internships (
    InternshipID INT IDENTITY(1,1) NOT NULL,
    Passed BIT NOT NULL,
    StudiesID INT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    UserID INT NOT NULL,
    CONSTRAINT Internships_pk PRIMARY KEY (InternshipID)
);

-- Table: Meeting
CREATE TABLE Meeting (
    MeetingID INT IDENTITY(1,1) NOT NULL,
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

-- Table: Module
CREATE TABLE Module (
    ModuleID INT IDENTITY(1,1) NOT NULL,
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

-- Table: OrderDetails
CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ServiceID INT NOT NULL,
    Date DATETIME NOT NULL,
    OrderDetailsID INT IDENTITY(1,1) NOT NULL,
    ShippedDate DATE NOT NULL,
    CONSTRAINT OrderDetails_pk PRIMARY KEY (OrderDetailsID)
);

-- Table: Orders
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) NOT NULL,
    OrderDate DATETIME NOT NULL,
    ShipAddress VARCHAR(50) NOT NULL,
    ShipCity VARCHAR(50) NOT NULL,
    UserID INT NOT NULL,
    CONSTRAINT Orders_pk PRIMARY KEY (OrderID)
);

-- Table: Payments
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) NOT NULL,
    Paid BIT NOT NULL,
    AdvancePaid BIT NULL,
    OrderDetailsID INT NOT NULL,
    ServiceID INT NOT NULL,
    DueDate DATE NOT NULL,
    CONSTRAINT PaymentID PRIMARY KEY (PaymentID)
);

-- Table: Roles
CREATE TABLE Roles (
    RoleID INT IDENTITY(1,1) NOT NULL,
    RoleName VARCHAR(50) NOT NULL,
    CONSTRAINT Roles_pk PRIMARY KEY (RoleID)
);

-- Table: Schedule
CREATE TABLE Schedule (
    ScheduleID INT IDENTITY(1,1) NOT NULL,
    MeetingID INT NULL,
    WasPresent BIT NOT NULL,
    WebinarID INT NULL,
    MadeUp BIT NULL,
    OrderDetailsID INT NOT NULL,
    CONSTRAINT Schedule_pk PRIMARY KEY (ScheduleID)
);

-- Table: Services
CREATE TABLE Services (
    ServiceID INT IDENTITY(1,1) NOT NULL,
    TypeOfServiceID INT NOT NULL,
    CONSTRAINT Services_pk PRIMARY KEY (ServiceID)
);

-- Table: Studies
CREATE TABLE Studies (
    StudiesID INT IDENTITY(1,1) NOT NULL,
    ServiceID INT NOT NULL,
    ProgrammeID INT NOT NULL,
    Price MONEY NOT NULL,
    StartDate DATETIME NOT NULL,
    PersonLimit INT NOT NULL,
    Ready BIT NOT NULL,
    CONSTRAINT Studies_pk PRIMARY KEY (StudiesID)
);

-- Table: StudiesProgramme
CREATE TABLE StudiesProgramme (
    ProgrammeID INT IDENTITY(1,1) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Desctiption TEXT NOT NULL,
    CONSTRAINT StudiesProgramme_pk PRIMARY KEY (ProgrammeID)
);

-- Table: StudiesProgrammeModules
CREATE TABLE StudiesProgrammeModules (
    ModuleProgrammeID INT IDENTITY(1,1) NOT NULL,
    ProgrammeID INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Desctiption TEXT NOT NULL,
    CONSTRAINT StudiesProgrammeModules_pk PRIMARY KEY (ModuleProgrammeID)
);

-- Table: TypeOfMeeting
CREATE TABLE TypeOfMeeting (
    TypeOfMeetingID INT IDENTITY(1,1) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Description TEXT NOT NULL,
    CONSTRAINT TypeOfMeeting_pk PRIMARY KEY (TypeOfMeetingID)
);

-- Table: TypeOfService
CREATE TABLE TypeOfService (
    TypeOfServiceID INT IDENTITY(1,1) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Description TEXT NOT NULL,
    CONSTRAINT TypeOfService_pk PRIMARY KEY (TypeOfServiceID)
);

-- Table: User
CREATE TABLE "User" (
    UserID INT IDENTITY(1,1) NOT NULL,
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

-- Table: Webinars
CREATE TABLE Webinars (
    WebinarID INT IDENTITY(1,1) NOT NULL,
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


-- foreign keys
-- Reference: EmployeeRoles_Employee (table: EmployeeRoles)
ALTER TABLE EmployeeRoles ADD CONSTRAINT EmployeeRoles_Employee
    FOREIGN KEY (EmployeeID)
    REFERENCES Employee (EmployeeID);

-- Reference: EmployeeRoles_Roles (table: EmployeeRoles)
ALTER TABLE EmployeeRoles ADD CONSTRAINT EmployeeRoles_Roles
    FOREIGN KEY (RoleID)
    REFERENCES Roles (RoleID);

-- Reference: Exams_Studies (table: Exams)
ALTER TABLE Exams ADD CONSTRAINT Exams_Studies
    FOREIGN KEY (StudiesID)
    REFERENCES Studies (StudiesID);

-- Reference: Exams_User (table: Exams)
ALTER TABLE Exams ADD CONSTRAINT Exams_User
    FOREIGN KEY (UserID)
    REFERENCES "User" (UserID);

-- Reference: InternishipDays_Internships (table: InternishipDays)
ALTER TABLE InternishipDays ADD CONSTRAINT InternishipDays_Internships
    FOREIGN KEY (InternshipID)
    REFERENCES Internships (InternshipID);

-- Reference: Internships_Studies (table: Internships)
ALTER TABLE Internships ADD CONSTRAINT Internships_Studies
    FOREIGN KEY (StudiesID)
    REFERENCES Studies (StudiesID);

-- Reference: Internships_User (table: Internships)
ALTER TABLE Internships ADD CONSTRAINT Internships_User
    FOREIGN KEY (UserID)
    REFERENCES "User" (UserID);

-- Reference: Meeting_Employee (table: Meeting)
ALTER TABLE Meeting ADD CONSTRAINT Meeting_Employee
    FOREIGN KEY (LecturerID)
    REFERENCES Employee (EmployeeID);

-- Reference: Meeting_Employee2 (table: Meeting)
ALTER TABLE Meeting ADD CONSTRAINT Meeting_Employee2
    FOREIGN KEY (TranslatorID)
    REFERENCES Employee (EmployeeID);

-- Reference: Meeting_Module (table: Meeting)
ALTER TABLE Meeting ADD CONSTRAINT Meeting_Module
    FOREIGN KEY (ModuleID)
    REFERENCES Module (ModuleID);

-- Reference: Meetings_Courses (table: Module)
ALTER TABLE Module ADD CONSTRAINT Meetings_Courses
    FOREIGN KEY (CourseID)
    REFERENCES Courses (CourseID);

-- Reference: Module_Employee (table: Module)
ALTER TABLE Module ADD CONSTRAINT Module_Employee
    FOREIGN KEY (LecturerID)
    REFERENCES Employee (EmployeeID);

-- Reference: Module_Studies (table: Module)
ALTER TABLE Module ADD CONSTRAINT Module_Studies
    FOREIGN KEY (StudiesID)
    REFERENCES Studies (StudiesID);

-- Reference: OrderDetails_Orders (table: OrderDetails)
ALTER TABLE OrderDetails ADD CONSTRAINT OrderDetails_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

-- Reference: Orders_User (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Orders_User
    FOREIGN KEY (UserID)
    REFERENCES "User" (UserID);

-- Reference: Payments_OrderDetails (table: Payments)
ALTER TABLE Payments ADD CONSTRAINT Payments_OrderDetails
    FOREIGN KEY (OrderDetailsID)
    REFERENCES OrderDetails (OrderDetailsID);

-- Reference: Payments_Services (table: Payments)
ALTER TABLE Payments ADD CONSTRAINT Payments_Services
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

-- Reference: Schedule_Meeting (table: Schedule)
ALTER TABLE Schedule ADD CONSTRAINT Schedule_Meeting
    FOREIGN KEY (MeetingID)
    REFERENCES Meeting (MeetingID);

-- Reference: Schedule_OrderDetails (table: Schedule)
ALTER TABLE Schedule ADD CONSTRAINT Schedule_OrderDetails
    FOREIGN KEY (OrderDetailsID)
    REFERENCES OrderDetails (OrderDetailsID);

-- Reference: Schedule_Schedule (table: Schedule)
ALTER TABLE Schedule ADD CONSTRAINT Schedule_Schedule
    FOREIGN KEY (ScheduleID)
    REFERENCES Schedule (ScheduleID);

-- Reference: Services_Courses (table: Courses)
ALTER TABLE Courses ADD CONSTRAINT Services_Courses
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

-- Reference: Services_Module (table: Module)
ALTER TABLE Module ADD CONSTRAINT Services_Module
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

-- Reference: Services_OrderDetails (table: OrderDetails)
ALTER TABLE OrderDetails ADD CONSTRAINT Services_OrderDetails
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

-- Reference: Services_Studies (table: Studies)
ALTER TABLE Studies ADD CONSTRAINT Services_Studies
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

-- Reference: Services_TypeOfService (table: Services)
ALTER TABLE Services ADD CONSTRAINT Services_TypeOfService
    FOREIGN KEY (TypeOfServiceID)
    REFERENCES TypeOfService (TypeOfServiceID);

-- Reference: Services_Webinars (table: Webinars)
ALTER TABLE Webinars ADD CONSTRAINT Services_Webinars
    FOREIGN KEY (ServiceID)
    REFERENCES Services (ServiceID);

-- Reference: StudiesProgrammeModules_StudiesProgramme (table: StudiesProgrammeModules)
ALTER TABLE StudiesProgrammeModules ADD CONSTRAINT StudiesProgrammeModules_StudiesProgramme
    FOREIGN KEY (ProgrammeID)
    REFERENCES StudiesProgramme (ProgrammeID);

-- Reference: Studies_StudiesProgramme (table: Studies)
ALTER TABLE Studies ADD CONSTRAINT Studies_StudiesProgramme
    FOREIGN KEY (ProgrammeID)
    REFERENCES StudiesProgramme (ProgrammeID);

-- Reference: TypeOfMeeting_Meeting (table: Meeting)
ALTER TABLE Meeting ADD CONSTRAINT TypeOfMeeting_Meeting
    FOREIGN KEY (TypeOfMeetingID)
    REFERENCES TypeOfMeeting (TypeOfMeetingID);

-- Reference: Webinars_Employee (table: Webinars)
ALTER TABLE Webinars ADD CONSTRAINT Webinars_Employee
    FOREIGN KEY (LecturerID)
    REFERENCES Employee (EmployeeID);

-- Reference: Webinars_Employee2 (table: Webinars)
ALTER TABLE Webinars ADD CONSTRAINT Webinars_Employee2
    FOREIGN KEY (TranslatorID)
    REFERENCES Employee (EmployeeID);

-- Reference: Webinars_Schedule (table: Schedule)
ALTER TABLE Schedule ADD CONSTRAINT Webinars_Schedule
    FOREIGN KEY (WebinarID)
    REFERENCES Webinars (WebinarID);
-- End of file.


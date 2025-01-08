CREATE TRIGGER trg_AddMeetingsAndWebinarsToSchedule
ON Payments
AFTER INSERT
AS
BEGIN
    DECLARE @PaymentID INT, @ServiceID INT;

    SELECT
        @PaymentID = PaymentID,
        @ServiceID = ServiceID
    FROM inserted;

    INSERT INTO Schedule (PaymentID, MeetingID, WasPresent)
    SELECT
        @PaymentID,
        M.MeetingID,
        0
    FROM Meeting M
    JOIN Module Mo ON M.ModuleID = Mo.ModuleID
    JOIN Courses C ON Mo.CourseID = C.CourseID
    WHERE C.ServiceID = @ServiceID;

    INSERT INTO Schedule (PaymentID, MeetingID, WasPresent)
    SELECT
        @PaymentID,
        M.MeetingID,
        0
    FROM Meeting M
    JOIN Module Mo ON M.ModuleID = Mo.ModuleID
    WHERE Mo.ServiceID = @ServiceID;

    INSERT INTO Schedule (PaymentID, WebinarID, WasPresent)
    SELECT
        @PaymentID,
        W.WebinarID,
        0
    FROM Webinars W
    WHERE W.ServiceID = @ServiceID;
END;

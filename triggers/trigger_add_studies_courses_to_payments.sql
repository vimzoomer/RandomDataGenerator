CREATE TRIGGER trg_AddStudiesCoursesToPayments
ON OrderDetails
AFTER INSERT
AS
BEGIN
    DECLARE @ServiceID INT;
    DECLARE @StudiesID INT;

    SELECT @ServiceID = ServiceID
    FROM inserted;

    SELECT @StudiesID = StudiesID
    FROM Studies
    WHERE ServiceID = @ServiceID;

    IF @StudiesID IS NOT NULL
    BEGIN
        INSERT INTO Payments (OrderDetailsID, ServiceID, Paid, DueDate)
        SELECT OD.OrderDetailsID, C.ServiceID, 0, DATEADD(DAY, -3, C.StartDate)
        FROM Courses C
        INNER JOIN OrderDetails OD ON OD.ServiceID = C.ServiceID
        WHERE C.ServiceID IN (SELECT ServiceID FROM Studies WHERE StudiesID = @StudiesID);
    END
END;

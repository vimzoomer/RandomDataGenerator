CREATE TRIGGER AddPaymentForService
ON OrderDetails
AFTER INSERT
AS
BEGIN
    DECLARE @OrderDetailsID INT, @ServiceID INT, @Paid BIT, @DueDate DATE, @CourseStartDate DATETIME;

    SELECT @OrderDetailsID = OrderDetailsID, @ServiceID = ServiceID
    FROM inserted;

    IF EXISTS (SELECT 1 FROM Services WHERE ServiceID = @ServiceID AND EXISTS (SELECT 1 FROM Courses WHERE ServiceID = @ServiceID))
    BEGIN
        SELECT @CourseStartDate = StartDate
        FROM Courses
        WHERE ServiceID = @ServiceID;

        SET @Paid = 0;
        SET @DueDate = DATEADD(DAY, -3, @CourseStartDate);

        INSERT INTO Payments (Paid, AdvancePaid, OrderDetailsID, ServiceID, DueDate)
        VALUES (0, 0, @OrderDetailsID, @ServiceID, @DueDate);
    END

    IF EXISTS (SELECT 1 FROM Services WHERE ServiceID = @ServiceID AND EXISTS (SELECT 1 FROM Studies WHERE ServiceID = @ServiceID))
    BEGIN
        SELECT @DueDate = StartDate
        FROM Courses
        WHERE ServiceID = @ServiceID;

        SET @Paid = 0;

        INSERT INTO Payments (Paid, AdvancePaid, OrderDetailsID, ServiceID, DueDate)
        VALUES (0, NULL, @OrderDetailsID, @ServiceID, @DueDate);
    END

    IF EXISTS (SELECT 1 FROM Services WHERE ServiceID = @ServiceID AND EXISTS (SELECT 1 FROM Webinars WHERE ServiceID = @ServiceID))
    BEGIN
        SELECT @DueDate = StartDate
        FROM Courses
        WHERE ServiceID = @ServiceID;

        SET @Paid = 0;

        INSERT INTO Payments (Paid, AdvancePaid, OrderDetailsID, ServiceID, DueDate)
        VALUES (0, NULL, @OrderDetailsID, @ServiceID, @DueDate);
    END

    IF EXISTS (SELECT 1 FROM Services WHERE ServiceID = @ServiceID AND EXISTS (SELECT 1 FROM Meeting WHERE ServiceID = @ServiceID))
    BEGIN
        SELECT @DueDate = StartDate
        FROM Courses
        WHERE ServiceID = @ServiceID;

        SET @Paid = 0;

        INSERT INTO Payments (Paid, AdvancePaid, OrderDetailsID, ServiceID, DueDate)
        VALUES (0, NULL, @OrderDetailsID, @ServiceID, @DueDate);
    END
END;

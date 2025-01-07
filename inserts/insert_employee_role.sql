INSERT INTO EmployeeRoles (EmployeeID, RoleID)
SELECT ?, RoleID
FROM Roles
WHERE RoleName = ?
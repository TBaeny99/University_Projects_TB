SELECT 
    E.EmployeeID,
    E.Name AS EmployeeName,
    D.DepartmentName,
    E.Salary,
    ROUND(AVG(E.Salary) OVER (PARTITION BY D.DepartmentID), 2) AS AverageSalaryInDepartment,
    ROUND(MAX(E.Salary) OVER (PARTITION BY D.DepartmentID), 2) AS MaxSalaryInDepartment,
    ROUND(MIN(E.Salary) OVER (PARTITION BY D.DepartmentID), 2) AS MinSalaryInDepartment,
    RANK() OVER (ORDER BY E.Salary DESC) AS OverallSalaryRank,
    ROW_NUMBER() OVER (PARTITION BY D.DepartmentID ORDER BY E.Salary DESC) AS SalaryRankInDepartment
FROM 
    Employees E
    INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
ORDER BY 
    D.DepartmentName, Salary DESC;





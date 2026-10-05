-- =====================================================
-- HR ANALYTICS SQL PROJECT
-- Employee Salary Analysis
-- =====================================================


-- Q1. Total Employees
SELECT COUNT(*) AS total_employees
FROM employees;


-- Q2. Employees by Department
SELECT department,
       COUNT(*) AS employee_count
FROM employees
GROUP BY department;


-- Q3. Average Salary by Department
SELECT department,
       AVG(salary) AS average_salary
FROM employees
GROUP BY department;


-- Q4. Highest Salary
SELECT employee_name,
       salary
FROM employees
ORDER BY salary DESC
LIMIT 1;


-- Q5. Lowest Salary
SELECT employee_name,
       salary
FROM employees
ORDER BY salary ASC
LIMIT 1;


-- Q6. Employees Earning More Than 60,000
SELECT employee_name,
       department,
       salary
FROM employees
WHERE salary > 60000
ORDER BY salary DESC;


-- Q7. Employees Earning Between 50,000 and 70,000
SELECT employee_name,
       department,
       salary
FROM employees
WHERE salary BETWEEN 50000 AND 70000
ORDER BY salary;


-- Q8. Department-wise HR Summary
SELECT department,
       COUNT(*) AS employee_count,
       AVG(salary) AS average_salary
FROM employees
GROUP BY department;


-- Q9. Departments Having More Than 2 Employees
SELECT department,
       COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;


-- Q10. Salary Category
SELECT employee_name,
       salary,
       CASE
           WHEN salary >= 70000 THEN 'High'
           WHEN salary >= 50000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_category
FROM employees;


-- Q11. Employees by Salary Category
SELECT
    CASE
        WHEN salary >= 70000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category,
    COUNT(*) AS employee_count
FROM employees
GROUP BY salary_category;


-- Q12. Employees Earning Above Company Average
SELECT employee_name,
       department,
       salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;


-- Q13. Highest Salary in Each Department
SELECT e1.employee_name,
       e1.department,
       e1.salary
FROM employees e1
WHERE e1.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department = e1.department
);


-- Q14. Employees in HR or Finance
SELECT employee_name,
       department,
       salary
FROM employees
WHERE department IN ('HR', 'Finance')
ORDER BY department, salary DESC;


-- Q15. Employees Not in HR
SELECT employee_name,
       department,
       salary
FROM employees
WHERE department NOT IN ('HR')
ORDER BY department;


-- Q16. Average Salary by Experience
SELECT experience_years,
       AVG(salary) AS average_salary
FROM employees
GROUP BY experience_years
ORDER BY experience_years;


-- Q17. Employees Earning Above Their Department Average
SELECT e1.employee_name,
       e1.department,
       e1.salary
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department = e1.department
)
ORDER BY e1.department, e1.salary DESC;


-- Q18. Rank Employees by Salary
SELECT employee_name,
       department,
       salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;


-- Q19. Compare RANK, DENSE_RANK and ROW_NUMBER
SELECT employee_name,
       department,
       salary,
       RANK() OVER (ORDER BY salary DESC) AS rank_salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank_salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_number_salary
FROM employees;


-- Q20. Top 3 Highest-Paid Employees
WITH ranked_employees AS (
    SELECT employee_name,
           department,
           salary,
           ROW_NUMBER() OVER (
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employees
)
SELECT employee_name,
       department,
       salary,
       salary_rank
FROM ranked_employees
WHERE salary_rank <= 3;


-- Q21. Top 3 Employees in Each Department
WITH ranked_employees AS (
    SELECT employee_name,
           department,
           salary,
           ROW_NUMBER() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employees
)
SELECT employee_name,
       department,
       salary,
       salary_rank
FROM ranked_employees
WHERE salary_rank <= 3
ORDER BY department, salary_rank;


-- Q22. Previous Employee Salary Using LAG
SELECT employee_name,
       department,
       salary,
       LAG(salary) OVER (
           ORDER BY salary DESC
       ) AS previous_salary
FROM employees;


-- Q23. Next Employee Salary Using LEAD
SELECT employee_name,
       department,
       salary,
       LEAD(salary) OVER (
           ORDER BY salary DESC
       ) AS next_salary
FROM employees;


-- Q24. Salary Difference from Previous Employee
SELECT employee_name,
       department,
       salary,
       LAG(salary) OVER (
           ORDER BY salary DESC
       ) AS previous_salary,
       salary - LAG(salary) OVER (
           ORDER BY salary DESC
       ) AS salary_difference
FROM employees;


-- Q25. Highest-Paid Employee in Each Department
WITH ranked_employees AS (
    SELECT employee_name,
           department,
           salary,
           ROW_NUMBER() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employees
)
SELECT employee_name,
       department,
       salary
FROM ranked_employees
WHERE salary_rank = 1
ORDER BY department;


-- Q26. Salary Category for Each Employee
SELECT employee_name,
       salary,
       CASE
           WHEN salary >= 70000 THEN 'High'
           WHEN salary >= 50000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_category
FROM employees;


-- Q27. Department with Highest Average Salary
SELECT department,
       AVG(salary) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC
LIMIT 1;


-- Q28. Employees Earning Above Their Department Average
SELECT employee_name,
       department,
       salary
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department = e.department
)
ORDER BY department, salary DESC;


-- Q29. Does Average Salary Increase with Experience?
SELECT experience_years,
       AVG(salary) AS average_salary
FROM employees
GROUP BY experience_years
ORDER BY experience_years;


-- Q30. Employees in Each Salary Band
SELECT
    CASE
        WHEN salary >= 70000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_band,
    COUNT(*) AS employee_count
FROM employees
GROUP BY salary_band;


-- Q31. Rank Departments by Average Salary
SELECT department,
       AVG(salary) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;


-- Q32. Top 2 Highest-Paid Employees in Each Department
SELECT employee_name,
       department,
       salary
FROM (
    SELECT employee_name,
           department,
           salary,
           ROW_NUMBER() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS rank_no
    FROM employees
)
WHERE rank_no <= 2
ORDER BY department, salary DESC;


-- Q33. Employees Earning Above Company Average
SELECT employee_name,
       department,
       salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;


-- Q34. Employee Salary Percentage of Department Total
SELECT employee_name,
       department,
       salary,
       ROUND(
           salary * 100.0 /
           SUM(salary) OVER (
               PARTITION BY department
           ),
           2
       ) AS salary_percentage
FROM employees
ORDER BY department, salary DESC;


-- Q35. Final HR Analytics Summary
SELECT department,
       COUNT(*) AS employee_count,
       ROUND(AVG(salary), 2) AS average_salary,
       MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;
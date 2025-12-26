-- ## **Задача 1. Базові SELECT**

-- 1. Вивести всіх студентів, які зареєструвалися після 2024‑01‑01.

select student_id, full_name, reg_date from students
where reg_date > '2024-01-01'::date

-- 2. Вивести всі курси категорії `"Data Science"`.

select course_id, course_name from courses
where category = 'Data Science'

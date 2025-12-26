-- ## **Задача 5. Віконні функції**

-- 1. Для кожного курсу визначити рейтинг студентів за середнім балом.

select e.course_id as course, 
       s.student_id as student,
       round(avg(p.score),2) as avg_score,
       rank() over(partition by e.course_id order by round(avg(p.score),2) desc) as score_rank
from pl_students s
inner join pl_enrollments e on s.student_id = e.student_id
inner join pl_progress p on p.enrollment_id = e.enrollment_id
group by course, student
order by course

-- 2. Порахувати кумулятивну кількість уроків, завершених студентом у хронологічному порядку.

select s.full_name,
       e.enroll_date,
       SUM(CASE WHEN p.completed THEN 1 ELSE 0 END)
       OVER (PARTITION BY s.student_id ORDER BY e.enroll_date, p.lesson_number) 
       AS cumulative_completed
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN progress p ON e.enrollment_id = p.enrollment_id
ORDER BY s.student_id, e.enroll_date, p.lesson_number;

-- 3. Для кожної категорії курсів знайти топ‑1 курс за кількістю студентів.

with ranked as (
select c.category,
       c.course_name,
       count(s.student_id) as quantity
from pl_courses c
left join pl_enrollments e on e.course_id = c.course_id
left join pl_students s on s.student_id = e.student_id
group by c.course_id)
select category,
       course_name,
       quantity,
       rank
from
(select category,
       course_name,
       quantity,
       rank() over(partition by category order by quantity desc) as rank
from ranked)
where rank = 1

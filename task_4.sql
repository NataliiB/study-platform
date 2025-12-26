-- ## **Задача 4. Аналітика прогресу**

-- 1. Порахувати середню оцінку кожного студента.

select s.full_name as student, round(avg(p.score),2) as avg_scoreavg_score
from students s
inner join enrollments e on e.student_id = s.student_id
inner join progress p on p.enrollment_id = e.enrollment_id
group by student

-- 2. Порахувати відсоток завершених уроків для кожного курсу.

select c.course_name as course, round((((sum(p.completed::int))/(nullif(((count(p.completed))::float),0)))*100)::numeric,2)
as percentage
from courses c
inner join enrollments e on c.course_id = e.course_id
inner join progress p on p.enrollment_id = e.enrollment_id
group by course

-- 3. Знайти студентів, які завершили всі уроки у своїх курсах.

with not_completed as (
select s.student_id
from students s
inner join enrollments e on s.student_id = e.student_id
inner join progress p on p.enrollment_id = e.enrollment_id
where p.completed = false
group by s.student_id, p.completed
)
select student 
from students
where student_id not in (select student_id from not_completed);
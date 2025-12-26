-- ## **Задача 2. Групування та агрегація**

-- 1. Порахувати кількість студентів у кожному місті.

select city, count(*) as quantity 
from students
group by city
order by quantity

-- 2. Порахувати кількість курсів у кожній категорії.

select category, count(*) as quantity
from courses
group by category
order by quantity

-- 3. Порахувати середню оцінку по кожному курсу.

select c.course_name, round(avg(p.score),2) as avg_score
from progress p
left join enrollments e on p.enrollment_id = e.enrollment_id
left join courses c on e.course_id = c.course_id
group by c.course_id
order by avg_score
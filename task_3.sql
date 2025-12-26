-- ## **Задача 3. JOIN‑аналіз**

-- 1. Вивести список курсів разом з іменами викладачів.

select c.course_name as course, i.full_name as instructor
from instructors i
inner join courses c on i.instructor_id = c.instructor_id
group by course, instructor
order by course

-- 2. Вивести студентів та назви курсів, на які вони записані.

select s.full_name as student, c.course_name as course
from students s
inner join enrollments e on s.student_id = e.student_id
inner join courses c on c.course_id = e.course_id
group by student, course
order by student

-- 3. Порахувати, скільки студентів у кожного викладача.

select i.full_name as instructor,count(s.student_id) as quantity
from instructors i
left join courses c on c.instructor_id = i.instructor_id
left join enrollments e on e.course_id = c.course_id
left join students s on s.student_id = e.student_id
group by instructor

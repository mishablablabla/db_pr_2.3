-- Вибір всіх викладачів з академічним ступенем "Doctor of Sciences"
SELECT full_name, academic_degree
FROM Teachers
WHERE academic_degree = 'Doctor of Sciences'
ORDER BY full_name;

-- Вибір груп, номер яких починається на "GROUP-1"
SELECT group_number
FROM Groups
WHERE group_number LIKE 'GROUP-1%'
ORDER BY group_number;

-- Вибір унікальних предметів, що проводяться в аудиториях типу 'Lecture'
SELECT DISTINCT Subjects.name
FROM Subjects
JOIN Auditoriums ON Auditoriums.type = 'Lecture'
ORDER BY Subjects.name;

-- Вибір викладачів, які читають лише лекції (без практики)
SELECT full_name
FROM Teachers
WHERE teaching_types LIKE '%Lecture%'
  AND teaching_types NOT LIKE '%Practice%'
ORDER BY full_name;

-- Вибір аудиторій типу 'Laboratory'
SELECT room_number
FROM Auditoriums
WHERE type = 'Laboratory'
ORDER BY room_number;


-- ====================================================
-- Завдання 3. Формування запитів із застосуванням WHERE
-- (1 запит, як приклад)
-- "Вибір викладачів з академічним ступенем 'PhD'"
-- ====================================================
SELECT full_name, academic_degree, department, teaching_types
FROM Teachers
WHERE academic_degree = 'PhD'
ORDER BY full_name;


-- ====================================================
-- Завдання 4. Застосування логічних операторів (AND, OR, NOT)
-- (5 запитів)
-- ====================================================

-- 1. Вибір викладачів з кафедри 'Informatics', які мають ступінь 'PhD' або не проводять практику
SELECT full_name, department, academic_degree, teaching_types
FROM Teachers
WHERE department = 'Informatics'
  AND (academic_degree = 'PhD' OR teaching_types NOT LIKE '%Practice%')
ORDER BY full_name;

-- 2. Вибір викладачів з кафедри 'Mathematics', які мають ступінь 'PhD'
SELECT full_name, department, academic_degree
FROM Teachers
WHERE department = 'Mathematics'
  AND academic_degree = 'PhD'
ORDER BY full_name;

-- 3. Вибір груп з курсом більше 3 і спеціальністю, що не дорівнює 'Physics'
SELECT group_number, course, specialty
FROM Groups
WHERE course > 3
  AND specialty <> 'Physics'
ORDER BY group_number;

-- 4. Вибір викладачів з кафедри 'Chemistry', у яких ступінь не 'PhD'
SELECT full_name, department, academic_degree
FROM Teachers
WHERE department = 'Chemistry'
  AND academic_degree <> 'PhD'
ORDER BY full_name;

-- 5. Вибір груп, де курс рівний 2 та headman починається з 'Ivan'
SELECT group_number, headman, course
FROM Groups
WHERE course = 2
  AND headman LIKE 'Ivan%'
ORDER BY group_number;


-- ====================================================
-- Завдання 5. Використання оператора LIKE для пошуку шаблонів
-- (5 запитів)
-- ====================================================

-- 1. Вибір груп, номер яких містить '01'
SELECT group_number, headman, course, specialty
FROM Groups
WHERE group_number LIKE '%01%'
ORDER BY group_number;

-- 2. Вибір викладачів, чиє повне ім'я починається на 'A'
SELECT full_name, department
FROM Teachers
WHERE full_name LIKE 'A%'
ORDER BY full_name;

-- 3. Вибір предметів, назва яких містить 'Math'
SELECT name
FROM Subjects
WHERE name LIKE '%Math%'
ORDER BY name;

-- 4. Вибір аудиторій, номер яких починається з '1'
SELECT room_number, type, building
FROM Auditoriums
WHERE CAST(room_number AS VARCHAR) LIKE '1%'
ORDER BY room_number;

-- 5. Вибір викладачів, у яких вид викладання містить 'Lecture'
SELECT full_name, teaching_types
FROM Teachers
WHERE teaching_types LIKE '%Lecture%'
ORDER BY full_name;


-- ====================================================
-- Завдання 6. Використання оператора JOIN для виконання багатотабличних запитів
-- (5 запитів)
-- ====================================================

-- 1. CROSS JOIN: Поєднання всіх викладачів і предметів, де предмет містить 'Programming'
SELECT T.full_name AS Teacher, S.name AS Subject
FROM Teachers T
CROSS JOIN Subjects S
WHERE S.name LIKE '%Programming%'
ORDER BY T.full_name;

-- 2. INNER JOIN: Вибір викладачів та груп, де кафедра викладача відповідає спеціальності групи
SELECT T.full_name, G.group_number, T.department, G.specialty
FROM Teachers T
INNER JOIN Groups G ON T.department = G.specialty
ORDER BY T.full_name;

-- 3. JOIN: Вибір викладачів і аудиторій, де аудиторія має тип 'Lecture'
SELECT T.full_name, A.room_number, A.type
FROM Teachers T
JOIN Auditoriums A ON A.type = 'Lecture'
ORDER BY T.full_name;

-- 4. JOIN: Вибір предметів і аудиторій, де аудиторія має тип 'Laboratory'
SELECT S.name AS Subject, A.room_number, A.type
FROM Subjects S
JOIN Auditoriums A ON A.type = 'Laboratory'
ORDER BY S.name;

-- 5. JOIN: Вибір викладачів та предметів через спільний фільтр (наприклад, кафедра викладача співпадає з частиною назви предмета)
SELECT T.full_name, S.name AS Subject
FROM Teachers T
JOIN Subjects S ON T.department LIKE '%' + S.name + '%'
ORDER BY T.full_name;


-- ====================================================
-- Завдання 7. Розширене використання оператора JOIN (LEFT, RIGHT, FULL)
-- (5 запитів)
-- ====================================================

-- 1. LEFT JOIN: Всі групи з відповідними викладачами (якщо є) за умовою збігу спеціальності групи і кафедри викладача
SELECT G.group_number, G.specialty, T.full_name AS Teacher
FROM Groups G
LEFT JOIN Teachers T ON T.department = G.specialty
ORDER BY G.group_number;

-- 2. RIGHT JOIN: Всі викладачі з відповідними групами (якщо є)
SELECT T.full_name, T.department, G.group_number, G.specialty
FROM Groups G
RIGHT JOIN Teachers T ON T.department = G.specialty
ORDER BY T.full_name;

-- 3. FULL JOIN: Об'єднання всіх груп і викладачів за умовою співпадіння спеціальності групи та кафедри викладача
SELECT G.group_number, T.full_name, G.specialty, T.department
FROM Groups G
FULL JOIN Teachers T ON T.department = G.specialty
ORDER BY G.group_number, T.full_name;

-- 4. LEFT JOIN: Виведення всіх груп з інформацією про викладачів, навіть якщо співпадіння немає (NULL для відсутніх викладачів)
SELECT G.group_number, G.specialty, T.full_name AS Teacher
FROM Groups G
LEFT JOIN Teachers T ON T.department = G.specialty
ORDER BY G.group_number;

-- 5. RIGHT JOIN: Виведення всіх викладачів з інформацією про групи, навіть якщо група не відповідає
SELECT T.full_name, T.department, G.group_number, G.specialty
FROM Teachers T
RIGHT JOIN Groups G ON T.department = G.specialty
ORDER BY T.full_name;


-- ====================================================
-- Завдання 8. Робота з вкладеними запитами (SUBQUERY)
-- (5 запитів)
-- ====================================================

-- 1. Вибір груп, спеціальність яких присутня серед кафедр викладачів зі ступенем 'PhD'
SELECT group_number, specialty
FROM Groups
WHERE specialty IN (
    SELECT DISTINCT department
    FROM Teachers
    WHERE academic_degree = 'PhD'
)
ORDER BY group_number;

-- 2. Вибір викладачів, які працюють у кафедрах, що зустрічаються в групах
SELECT full_name, department, academic_degree
FROM Teachers
WHERE department IN (
    SELECT DISTINCT specialty
    FROM Groups
)
ORDER BY full_name;

-- 3. Вибір груп, у яких курс більше середнього курсу (середнє значення курсів із таблиці Groups)
SELECT group_number, course, specialty
FROM Groups
WHERE course > (SELECT AVG(course) FROM Groups)
ORDER BY group_number;

-- 4. Вибір викладачів, у яких id міститься у підзапиті з Teachers (наприклад, вибрати тих, чий id менший за середнє значення)
SELECT full_name, department, academic_degree
FROM Teachers
WHERE id < (SELECT AVG(id) FROM Teachers)
ORDER BY full_name;

-- 5. Вибір предметів, id яких перевищує середнє значення id у таблиці Subjects
SELECT name
FROM Subjects
WHERE id > (SELECT AVG(id) FROM Subjects)
ORDER BY name;


-- ====================================================
-- Завдання 9. Застосування оператора GROUP BY та умови HAVING у поєднанні з JOIN
-- (5 запитів)
-- ====================================================

-- 1. Групування викладачів за кафедрою і підрахунок їх кількості (ті, що мають більше 1 викладача)
SELECT department, COUNT(*) AS TeacherCount
FROM Teachers
GROUP BY department
HAVING COUNT(*) > 1
ORDER BY TeacherCount DESC;

-- 2. Групування груп за спеціальністю і підрахунок кількості груп у кожній спеціальності (ті, де більше 1)
SELECT specialty, COUNT(*) AS GroupCount
FROM Groups
GROUP BY specialty
HAVING COUNT(*) > 1
ORDER BY GroupCount DESC;

-- 3. Групування викладачів за академічним ступенем з підрахунком
SELECT academic_degree, COUNT(*) AS CountDegree
FROM Teachers
GROUP BY academic_degree
HAVING COUNT(*) > 1
ORDER BY CountDegree DESC;

-- 4. Групування груп за курсом і спеціальністю та підрахунок кількості записів
SELECT course, specialty, COUNT(*) AS CountGroups
FROM Groups
GROUP BY course, specialty
HAVING COUNT(*) >= 1
ORDER BY course, specialty;

-- 5. Групування предметів за назвою з підрахунком (хоча зазвичай кожен предмет унікальний)
SELECT name, COUNT(*) AS Occurrences
FROM Subjects
GROUP BY name
HAVING COUNT(*) >= 1
ORDER BY Occurrences DESC;


-- ====================================================
-- Завдання 10. Формування складних багатотабличних запитів
-- (5 запитів)
-- ====================================================

-- 1. Для кожної групи підрахувати кількість викладачів, у яких кафедра відповідає спеціальності групи
SELECT G.group_number, G.specialty, COUNT(T.id) AS TeacherCount
FROM Groups G
LEFT JOIN Teachers T ON T.department = G.specialty
GROUP BY G.group_number, G.specialty
ORDER BY G.group_number;

-- 2. Об'єднати дані викладачів і груп, відсортувавши за викладачем, та вибрати лише ті записи, де група має курс 1
SELECT T.full_name, G.group_number, G.course
FROM Teachers T
JOIN Groups G ON T.department = G.specialty
WHERE G.course = 1
ORDER BY T.full_name;

-- 3. Об'єднати викладачів, групи та предмети, вибираючи записи, де викладач працює на кафедрі, яка відповідає спеціальності групи, і предмет містить 'Math'
SELECT T.full_name, G.group_number, S.name AS Subject
FROM Teachers T
JOIN Groups G ON T.department = G.specialty
JOIN Subjects S ON S.name LIKE '%Math%'
ORDER BY T.full_name;

-- 4. Об'єднати дані груп і аудиторій, щоб вивести групи, які мають аудиторії з типом 'Laboratory'
SELECT G.group_number, A.room_number, A.type
FROM Groups G
JOIN Auditoriums A ON A.type = 'Laboratory'
ORDER BY G.group_number;

-- 5. Об'єднати викладачів і предмети, щоб вивести викладачів, які читають предмети, і відсортувати за назвою предмета
SELECT T.full_name, S.name AS Subject
FROM Teachers T
CROSS JOIN Subjects S
WHERE S.name IS NOT NULL
ORDER BY S.name;


-- ====================================================
-- Завдання 11. Поєднання умов WHERE із операторами JOIN
-- (5 запитів)
-- ====================================================

-- 1. Вибрати викладачів, які працюють у групах, де спеціальність групи відповідає кафедрі викладача, і викладач має ступінь 'PhD' для спеціальності 'Mathematics'
SELECT T.full_name, T.department, G.group_number, G.specialty, T.academic_degree
FROM Teachers T
JOIN Groups G ON T.department = G.specialty
WHERE T.academic_degree = 'PhD'
  AND G.specialty = 'Mathematics'
ORDER BY T.full_name;

-- 2. Вибрати викладачів та групи, де ім'я викладача містить 'ov'
SELECT T.full_name, G.group_number
FROM Teachers T
JOIN Groups G ON T.department = G.specialty
WHERE T.full_name LIKE '%ov%'
ORDER BY T.full_name;

-- 3. Вибрати викладачів та предмети, використовуючи CROSS JOIN, з умовою, що кафедра викладача 'Informatics' і назва предмета містить 'Programming'
SELECT T.full_name, S.name AS Subject
FROM Teachers T
CROSS JOIN Subjects S
WHERE T.department = 'Informatics'
  AND S.name LIKE '%Programming%'
ORDER BY T.full_name;

-- 4. Вибрати викладачів, групи та предмети, де група має курс 1, використовуючи JOIN
SELECT T.full_name, G.group_number, S.name AS Subject
FROM Teachers T
JOIN Groups G ON T.department = G.specialty
JOIN Subjects S ON S.id % 2 = 1
WHERE G.course = 1
ORDER BY T.full_name;

-- 5. Вибрати викладачів і групи, де викладач проводить лише лекції, а група має номер, що містить 'A'
SELECT T.full_name, G.group_number
FROM Teachers T
JOIN Groups G ON T.department = G.specialty
WHERE T.teaching_types LIKE '%Lecture%'
  AND G.group_number LIKE '%A%'
ORDER BY T.full_name;

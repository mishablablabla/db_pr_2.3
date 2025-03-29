

-- Змінити фамілію старости групи
UPDATE Groups SET headman = 'Gustav Beadon' WHERE group_number = 'GROUP-05D';

-- Оновити посаду викладача
UPDATE Teachers SET position = 'Professor' WHERE full_name = 'Kozlov V.V.';

-- Видалити пару з розкладу
DELETE FROM Schedule WHERE day_of_week = 'Вторник' AND pair_number = 2;

-- Змінити аудиторію пари
UPDATE Schedule SET auditorium_id = 1 WHERE day_of_week = 'Понедельник' AND pair_number = 1;

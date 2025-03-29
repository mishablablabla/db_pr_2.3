

-- Створення таблиць
CREATE TABLE Groups (
    id INT IDENTITY PRIMARY KEY,
    group_number VARCHAR(10) UNIQUE NOT NULL,
    headman VARCHAR(50),
    course INT CHECK (course > 0),
    specialty VARCHAR(100) NOT NULL
);

CREATE TABLE Auditoriums (
    id INT IDENTITY PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL,
    type VARCHAR(50) NOT NULL,
    building VARCHAR(50) NOT NULL
);

CREATE TABLE Teachers (
    id INT IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    position VARCHAR(50),
    academic_degree VARCHAR(50),
    teaching_types VARCHAR(255) -- Наприклад, "Лекція,Практика"
);

CREATE TABLE Subjects (
    id INT IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Schedule (
    id INT IDENTITY PRIMARY KEY,
    day_of_week VARCHAR(15) CHECK (day_of_week IN (N'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота')),
    pair_number INT CHECK (pair_number BETWEEN 1 AND 6),
    teacher_id INT FOREIGN KEY REFERENCES Teachers(id) ON DELETE CASCADE,
    group_id INT FOREIGN KEY REFERENCES Groups(id) ON DELETE CASCADE,
    subject_id INT FOREIGN KEY REFERENCES Subjects(id) ON DELETE CASCADE,
    auditorium_id INT FOREIGN KEY REFERENCES Auditoriums(id) ON DELETE CASCADE
);

ALTER TABLE Schedule
ALTER COLUMN day_of_week NVARCHAR(15);


-- Зміна структури (наприклад, додавання нового стовпця)
ALTER TABLE Teachers ADD phone_number VARCHAR(20) NULL;

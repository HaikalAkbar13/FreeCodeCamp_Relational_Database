-- Create a new database named students.
CREATE DATABASE 'students';

/* 
The CSV files have a bunch of students with info about them, and some courses and majors. 
there will be four tables. 
One for the students and their info, one for each major, another for each course, 
and a  one for showing what courses are included in each major. 
*/

CREATE TABLE course();
CREATE TABLE major();
CREATE TABLE major_courses(); -- will be a junction table for the majors and courses
CREATE TABLE students();

-- Add column to students table
ALTER TABLE students ADD COLUMN student_id SERIAL PRIMARY KEY; -- SERIAL for PostgreSQL, and AUTO_INCREMENT for MySQL
ALTER TABLE students ADD COLUMN first_name VARCHAR(50) NOT NULL;
ALTER TABLE students ADD COLUMN last_name VARCHAR(50) NOT NULL;
ALTER TABLE students ADD COLUMN major_id INT; -- Foreign key reference to MAJOR table
ALTER TABLE students ADD COLUMN gpa NUMERIC(2,1); -- Decimals with a length of 2 and 1 number is to the right of the decimal.

-- Add column to majors table
ALTER TABLE majors ADD COLUMN major_id SERIAL PRIMARY KEY; -- SERIAL for PostgreSQL, and AUTO_INCREMENT for MySQL
ALTER TABLE majors ADD COLUMN major VARCHAR(50) NOT NULL;

-- Set the foreign key in the students table
ALTER TABLE students ADD FOREIGN KEY(major_id) REFERENCES majors(major_id); -- Set the major_id colum as Fkey ref to major_id in majors table

-- Next, Add colum to courses table
ALTER TABLE courses ADD COLUMN course_id SERIAL PRIMARY KEY; -- Again SERIAL for PostgreSQL, and AUTO_INCREMENT for MySQL
ALTER TABLE courses ADD COLUMN course VARCHAR(100) NOT NULL;

-- Last is the majors_courses table
ALTER TABLE majors_courses ADD COLUMN major_id INT;
ALTER TABLE majors_courses ADD FOREIGN KEY(major_id) REFERENCES majors(major_id); -- Set the fkey that references to majors table
ALTER TABLE majors_courses ADD COLUMN course_id INT;
ALTER TABLE majors_courses ADD FOREIGN KEY(course_id) REFERENCES courses(course_id); -- Set the fkey that references to courses table
ALTER TABLE majors_courses ADD PRIMARY KEY(major_id, course_id); -- Make a COMPOSITE KEY

/*
COMPOSITE KEY : 
The data from courses.csv will go in this table. A single major will be in it multiple times, 
and same with a course. So neither of them can be a primary key. 
But there will never be a row with the same two values as another row. 
So the two columns together, are unique. 
You can create a composite primary key that uses more than one column as a unique pair
*/








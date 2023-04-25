create database Test2;
use Test2;
create table Students(
StudentId int(4) auto_increment primary key,
StudentName nvarchar(50),
Age int(4),
Email varchar(100)
);
create table Subjects(
SubjectId int(4) auto_increment primary key,
SubjectName nvarchar(50)
);
create table Classes(
ClassId int(4) auto_increment primary key,
ClassName nvarchar(50)
);
create table ClassStudent(
StudentId int(4),
foreign key (StudentId) references Students(StudentId),
ClassId int(4),
foreign key (ClassID) references Classes(ClassId)
);
create table Marks(
Mark int,
SubjectId int(4),
foreign key (SubjectId) references Subjects(SubjectId),
StudentId int(4),
foreign key (StudentId) references Students(StudentId)
);

insert into Students(StudentId,StudentName,Age,Email) values
(1,"Nguyen Quang An",18,"an@yahoo.com"),
(2,"Nguyen Cong Vinh",20,"vinh@gmail.com"),
(3,"Nguyen Van Quyen",19,"quyen"),
(4,"Pham Thanh Binh",25,"binh@com"),
(5,"Nguyen Van Tai Em",30,"taiem@sport.vn");

insert into Classes(ClassId,ClassName) values
(1,"C0706L"),(2,"C0708G");

insert into ClassStudent(StudentId,ClassId) values
(1,1),(2,1),(3,2),(4,2),(5,2);

insert into Subjects(SubjectId,SubjectName) values
(1,"SQL"),
(2,"Java"),
(3,"C"),
(4,"Visual Basic");	

insert into Marks(Mark,SubjectId,StudentId) values
(8,1,1),
(4,2,1),
(9,1,1),
(7,1,3),
(3,1,4),
(5,2,5),
(8,3,3),
(1,3,5),
(3,2,4);

-- Hien thi danh sach tat ca cac hoc vien 
select * from students;
-- Hien thi danh sach tat ca cac mon hoc
select * from Subjects;
-- Tinh diem trung binh 
select s.studentName,  avg(m.Mark) from Students s join Marks m on s.StudentId = m.StudentId group by s.studentId;
-- Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
select s.subjectName, m.mark from subjects s join marks m on s.subjectId = m.subjectId where m.mark = (select max(mark) from marks);
-- Danh so thu tu cua diem theo chieu giam
select @stt:=@stt+1 as stt, m.Mark from (select @stt:=0) as stt, Marks m order by m.mark desc;
-- Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
alter table Subjects modify subjectName nvarchar(255);
-- Cap nhat them dong chu « Day la mon hoc « vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
update Subjects
set subjectName = concat("Day la mon hoc ",subjectName); 
-- Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
alter table Students
modify Age int check(Age > 15 and Age < 50);
-- Loai bo tat ca quan he giua cac bang
alter table ClassStudent
drop foreign key classstudent_ibfk_1,
drop foreign key classstudent_ibfk_2;
alter table Marks
drop foreign key marks_ibfk_1,
drop foreign key marks_ibfk_2;
-- Xoa hoc vien co StudentID la 1
delete from Students where studentId = 1; -- nếu gặp lỗi 1451 thì chạy dòng này (SET foreign_key_checks = 0);
-- Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
alter table Students 
add column `status` bit default 1;
-- Cap nhap gia tri Status trong bang Student thanh 0
update Students
set `status`= 0;
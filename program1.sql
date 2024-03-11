create database prgrm1;
use prgrm1;
create table publisher(name varchar(20) primary key, address varchar(20), phone varchar(10));
create table book(book_id integer primary key, title varchar(20), publisher_name varchar(20) references publisher(name) on delete cascade, pub_year int(4));
create table book_authors(book_id integer references book(book_id) on delete cascade, author_name varchar(20), primary key(book_id));
create table library_branch(branch_id integer primary key, branch_name varchar(20), address varchar(15));
create table book_copies(book_id integer references book(book_id) on delete cascade, branch_id integer references library_branch(branch_id) on delete cascade, no_of_copies integer, primary key(book_id,branch_id));
create table book_lending(book_id integer references book(book_id) on delete cascade, branch_id integer references library_branch(branch_id) on delete cascade, card_no integer, date_out date, due_date date, primary key(book_id, branch_id, card_no));
insert into publisher values('person', 'bangalore', '1234567878'),('Anshu', 'bantwal', '1234565478'),('jocky', 'iraan', '9876543212'),('Rakshan', 'koila', '2356873466'),('Makwin', 'modankap', '8523697412');
insert into book values(1111,'sermon', 'person', 2005);
insert into book values(2222,'dbms', 'Anshu', 2006);
insert into book values(3333, 'anatomy' ,'jocky', 2010);
insert into book values(4444, 'encyclopedia' ,'Rakshan', 2012);
insert into book values(5555, 'mankuthimma' ,'Makwin', 2015);
insert into book_authors values(1111, 'somayaiji'),(2222,'Navarathna');
insert into book_authors values(3333, 'Henry Gray'),(4444,'Thomas'),(5555,'Sushma');
insert into library_branch values(1111,'central technical', 'mg road');
insert into library_branch values(2222,'medical', 'bc road'),(3333,'children','ss rural');
insert into library_branch values(4444,'Secretary', 'hubballi'),(5555, 'sports', 'mumbai');
insert into library_branch values(66,'President', 'Mangalore');
insert into book_copies values(1111,11,5);
insert into book_copies values(3333,22,6),(4444,33,10),(2222,11,12),(5555,55,5);
insert into book_lending values(2222,11,1,'2017-01-10','2017-08-20'),(4444,55,1,'2017-04-09','2017-08-19');
insert into book_lending values(3333,22,1,'2017-07-10','2017-07-15'),(1111,11,1,'2017-05-12','2017-06-10');

select lb.branch_name, b.book_id,title,publisher_name, author_name,no_of_copies
FROM book b, book_authors ba, book_copies bc, library_branch lb
WHERE b.book_id = ba.book_id and 
ba.book_id = bc.book_id and
bc.branch_id = lb.branch_id
group by lb.branch_name, b.book_id, title, publisher_name, author_name, no_of_copies;

select card_no
from book_lending
where date_out between '2017-01-01' and '2017-08-30'
group by card_no
having count(*)>3;

delete from book
where book_id='3333';
select * from book;

select book_id, title, publisher_name,pub_year
from book
group by pub_year,book_id,title,publisher_name;

create view books_available as
select b.book_id, b.title, c.no_of_copies
from library_branch l, book b, book_copies c
where b.book_id = c.book_id and
l.branch_id = c.branch_id;
select * from books_available;
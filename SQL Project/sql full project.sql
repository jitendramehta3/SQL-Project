drop table if exists Books;
create table if not exists Books
(
Book_ID serial primary key,
Title varchar(100),
Author varchar(100),
Genre varchar(50),
Published_Year int,
Price numeric(10,2),
Stock int
);

drop table if exists Customers;
create table if not exists Customers
(
Customer_ID serial primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(15),
City varchar(50),
Country varchar(150)
);


drop table if exists Orders;
create table if not exists Orders
(
Order_ID serial primary key,
Customer_ID int references Customers(customer_ID),
Book_ID int references Books(book_ID),
Order_Date date,
Quantity int,
Total_Amount numeric(10,2)
);

select * from Books;
select * from Customers;
select * from Orders;


--Basic Questions(11)

--01--Retrieve all books in the 'Fiction' genre:

select * from Books
where genre = 'Fiction';


--02--Find books published after the year 1950:

select * from Books
where published_year>'1950';


--03--List all the customers from the Canada:

select * from Customers where country = 'Canada';


--04--Show orders placed in November 2023:

select * from Orders where order_date between '2023-11-01' and '2023-11-30';


--05--Retrieve the total stock of books available:

select sum(stock) as Total_stocks from Books;


--06--Find the details of the most Expensive Books:

select * from Books order by price desc limit 1;


--07--Show all customers who ordered more than 1 quantity of a book:

select * from Orders where quantity>1;


--08--Retrieve all orders where total amount exceeds $20:

select * from Orders where total_amount>20.00;


--09--List all genre available in the book table:

select distinct genre from Books;


--10--Find the book with the lowest stock:

select * from Books order by stock desc limit 1;

--11--Calculate the total revenue generated from all orders:

select sum(total_amount) as total_revenue from Orders;



--ADVANCE QUESTIONS--(9)

select * from Books;
select * from Customers;
select * from Orders;

--01--Retrieve the total number of books sold for each genre:

select Books.genre, sum(Orders.quantity) as total_book_sold
from Books
join Orders
on Books.book_ID = Orders.book_ID
group by Books.genre;


--02--Find the average price of books in the 'Fantasy' genre:

select avg(price) from Books where genre = 'Fantasy';

--03--List customers who have placed at least 2 orders:

select customer_ID,count(order_ID) as order_count from Orders
group by customer_ID
having count(order_ID)>=2;

--04--find the most frequently ordered book:

select Orders.book_id,Books.title, count(order_id) as Order_count
from Orders
join Books on Orders.book_id = Books.book_id
group by Orders.Book_id,Books.title
order by Order_count desc limit 1;


--05--Show the top 3 most expensive books of 'Fantasy' genre:

select * from Books where genre = 'Fantasy'
order by price desc limit 3;

--06--Retrieve the total quantity of books sold by each author:

select Books.author,sum(quantity) as book_sold
from Orders
join Books
on Books.book_id = Orders.book_id
group by Books.author;


--07--List the cities where customers spent over $30 are located:

select distinct city,total_amount from Customers
join Orders
on Customers.customer_id=Orders.customer_id
where total_amount>30.00	
order by total_amount asc;


--08--Find the customers who spent the most on orders:

select customers.name,sum(total_amount) as total_spent
from Orders
join customers
on customers.customer_id = orders.customer_id
group by customers.name
order by total_spent desc limit 1;
 
--09--Calculate the stock remaining after fulfilling all orders:

select books.book_id ,books.title,books.stock,coalesce(sum(orders.quantity),0) as order_quantity,
books.stock - coalesce(sum(orders.quantity),0) as remaining_quantity
from books
left join orders on books.book_id = orders.book_id
group by books.book_id order by books.book_id;





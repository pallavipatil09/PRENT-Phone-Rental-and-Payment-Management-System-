create table users(
user_id int auto_increment primary key,
full_name varchar(150) not null,
email varchar(255) unique,
phone varchar(20) unique,
address text,
created_at timestamp default current_timestamp,
status enum('active','suspended','deleted') default 'active'
);

create table models(
model_id int auto_increment primary key,
brand varchar(100) not null,
model_name varchar(150) not null,
storage varchar(20),
color varchar(50),
price decimal(10,2) not null,
available_quantity int default 0,
created_at timestamp default current_timestamp
);

create table plans(
plan_id int auto_increment primary key,
plan_name varchar(100) not null,
tenure_months int not null,
monthly_rent decimal(10,2) not null,
deposit_amount decimal(10,2) default 0.00,
created_at timestamp default current_timestamp
);

create table rent_details(
rent_id int auto_increment primary key,
user_id int not null,
model_id int not null,
plan_id int not null,
start_date date not null,
end_date date null,
next_payment_date date null,
status enum('active','paused','completed','cancelled','pending_payment') default 'active',
deposit_amount decimal(10,2) default 0.00,
outstanding_due decimal(10,2) default 0.00,
created_at timestamp default current_timestamp,
foreign key (user_id) references users(user_id),
foreign key (model_id) references models(model_id),
foreign key (plan_id) references plans(plan_id)
);

create table promos(
promo_id int auto_increment primary key,
promo_code varchar(50) unique not null,
discount_amount decimal(10,2) not null,
start_date date not null,
end_date date not null
);

create table orders(
order_id int auto_increment primary key,
user_id int not null,
rent_id int not null,
order_date timestamp default current_timestamp,
total_amount decimal(10,2) not null,
status enum('pending','confirmed','shipped','delivered','cancelled') default 'pending',
payment_status enum('pending','paid','failed','refunded') default 'pending',
promo_id INT NULL,
discounted_amount DECIMAL(10,2) DEFAULT 0.00,
final_amount DECIMAL(10,2) NOT NULL,
foreign key (promo_id) references promos(promo_id),
foreign key (user_id) references users(user_id),
foreign key (rent_id) references rent_details(rent_id)
);

create table emi_details(
emi_id int auto_increment primary key,
rent_id int not null,
due_date date not null,
amount decimal(10,2) not null,
status enum('pending','paid','failed') default 'pending',
paid_date date null,
foreign key (rent_id) references rent_details(rent_id)
);

create table payments(
payment_id int auto_increment primary key,
rent_id int,
emi_id int null,
amount decimal(10,2) not null,
payment_method enum('gpay','phonepe','paytm','upi','debit_card','credit_card','net_banking') not null ,
status enum('successful','failed','refunded') default 'successful',
created_at datetime default current_timestamp,
foreign key (rent_id) references rent_details(rent_id),
foreign key (emi_id) references emi_details(emi_id)
);

create table complains(
complain_id int auto_increment primary key,
user_id int not null,
rent_id int null,
complain_text text not null,
status enum('pending','resolved','rejected') default 'pending',
created_at timestamp default current_timestamp,
foreign key (user_id) references users(user_id),
foreign key (rent_id) references rent_details(rent_id)
);

create table feedback(
feedback_id int auto_increment primary key,
user_id int not null,
rent_id int null,
rating int check (rating between 1 and 5),
feedback_text text,
created_at timestamp default current_timestamp,
foreign key (user_id) references users(user_id),
foreign key (rent_id) references rent_details(rent_id)
);

create table audit_log(
audit_id int auto_increment primary key,
entity_type enum('user','model','plan','rent','order','emi','payment','complains','feedback','promo') not null,
entity_id int not null,
action varchar(50) not null,
remarks varchar(255),
created_at timestamp default current_timestamp
);
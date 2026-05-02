-- data insertion

insert into users(full_name,email,phone,address) values
('Sanika Patil','sanika@gmail.com','9045675498','Alibaug'),
('Tanvi Patil','tanvi@gmail.com','9345298652','Rasayani'),
('Sakshi Patil','sakshi@gmail.com','9296349123','Khopoli'),
('Anjali Sankpal','anjali@gmail.com','9560936272','Mohopada'),
('Rachana Thombare','rachana@gmail.com','8014274859','Washivali'),
('Riddhi Waghe','riddhi@gmail.com','5467390134','Rasayani'),
('Mitali Sawant','mitali@gmail.com','9298674329','Pen'),
('Monika Rajpurohit','monika@gmail.com','7650923457','Karjat'),
('Isha Solanki','isha@gmail.com','9039495967','Gujarat'),
('Vibha Dhole','vibha@gmail.com','9209796310','Kopar');

insert into models(brand,model_name,storage,color,price,available_quantity)values
('Apple','iPhone 17','256GB','Black',95000,10),
('Apple','iPhone 17 Pro','512GB','Deep Blue',115000,8),
('Apple','iPhone 17 Pro Max','1TB','Silver',130000,5),
('Samsung','Galaxy Z Fold 7','512GB','Cosmic Black',180000,4),
('Samsung','Galaxy Z Flip 7','256GB','Coral Red',140000,6),
('Samsung','Galaxy A26 5G','128GB','Mint',30000,10),
('OnePlus','OnePlus 15','256GB','Black',80000,7),
('OnePlus','OnePlus 15R','512GB','Grey',50000,9),
('Xiaomi','Xiaomi 17 Ultra','512GB','White',90000,5),
('Oppo','Oppo Find X9 Pro','512GB','Blue',85000,6),
('Realme','Realme P3 Ultra','256GB','Black',35000,8),
('Vivo','Vivo X300 Pro','512GB','Silver',88000,5);

insert into plans(plan_name,tenure_months,monthly_rent,deposit_amount)values
('Basic 3 Months',3,3000,3000),
('Basic 6 Months',6,2500,5000),
('Standard 9 Months',9,2300,7000),
('Standard 12 Months',12,2200,8000),
('Premium 15 Months',15,2100,9000),
('Premium 18 Months',18,2000,10000),
('Student Plan',6,2000,4000),
('Family Plan',12,2400,8500),
('Corporate Plan',24,1800,12000),
('Festive Plan',6,1900,4500);

insert into rent_details(user_id,model_id,plan_id,start_date,deposit_amount,outstanding_due)values
(1,1,4,'2024-01-01',8000,26400),
(2,2,2,'2024-01-10',5000,15000),
(3,3,3,'2024-02-01',7000,20700),
(4,4,1,'2024-02-15',3000,9000),
(5,5,6,'2024-03-01',10000,36000),
(6,6,5,'2024-03-10',9000,31500),
(7,7,7,'2024-04-01',4000,12000),
(8,8,8,'2024-04-10',8500,28800),
(9,9,9,'2024-05-01',12000,43200),
(10,10,10,'2024-05-10',4500,11400);

insert into promos(promo_code,discount_amount,start_date,end_date)values
('NEW500',500,'2025-12-01','2026-01-31'),
('SAVE1000',1000,'2025-12-01','2026-03-31'),
('FEST2000',2000,'2025-12-01','2026-03-31'),
('WELCOME300',300,'2025-12-01','2026-12-31'),
('OFFER750',750,'2025-12-01','2026-01-15'),
('DIWALI1500',1500,'2025-12-01','2026-01-30'),
('STUDENT400',400,'2025-12-01','2026-06-30'),
('CORP2500',2500,'2025-12-01','2026-12-31'),
('LOYAL600',600,'2025-12-01','2026-01-31'),
('FLASH900',900,'2025-12-01','2026-01-31');

insert into orders(user_id,rent_id,total_amount,promo_id,final_amount)values
(1,1,26400,1,26400),
(2,2,15000,2,15000),
(3,3,20700,3,20700),
(4,4,9000,4,9000),
(5,5,36000,5,36000),
(6,6,31500,6,31500),
(7,7,12000,7,12000),
(8,8,28800,8,28800),
(9,9,43200,9,43200),
(10,10,11400,10,11400);

insert into emi_details(rent_id,due_date,amount)values
(1,'2024-02-01',2200),
(2,'2024-03-01',2200),
(3,'2024-02-10',2500),
(4,'2024-03-01',2300),
(5,'2024-03-15',3000),
(6,'2024-04-01',2000),
(7,'2024-04-10',2100),
(8,'2024-05-01',2000),
(9,'2024-05-10',2400),
(10,'2024-06-01',1800);

insert into payments(rent_id,emi_id,amount,payment_method,status)values
(1,1,2200,'upi','successful'),
(2,2,2200,'gpay','successful'),
(3,3,2500,'phonepe','successful'),
(4,4,2300,'upi','successful'),
(5,5,3000,'debit_card','successful'),
(6,6,2000,'credit_card','successful'),
(7,7,2100,'upi','successful'),
(8,8,2000,'paytm','successful'),
(9,9,2400,'upi','successful'),
(10,10,1800,'net_banking','successful');

insert into complains(user_id,rent_id,complain_text)values
(1,1,'Battery issue'),
(2,2,'Screen flicker'),
(3,3,'Speaker not clear'),
(4,4,'Camera issue'),
(5,5,'Heating problem'),
(6,6,'Slow performance'),
(7,7,'Charging issue'),
(8,8,'Touch not working'),
(9,9,'Network problem'),
(10,10,'Volume button issue');

insert into feedback(user_id,rent_id,rating,feedback_text)values
(1,1,5,'Excellent service'),
(2,2,4,'Good experience'),
(3,3,5,'Very satisfied'),
(4,4,3,'Average'),
(5,5,4,'Nice phone'),
(6,6,5,'Fast service'),
(7,7,4,'Value for money'),
(8,8,5,'Highly recommend'),
(9,9,4,'Good support'),
(10,10,5,'Happy with service');

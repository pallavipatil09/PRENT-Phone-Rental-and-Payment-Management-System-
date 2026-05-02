-- STORED PROCEDURES

-- creates order safely
delimiter //
create procedure place_order(
in p_user_id int,
in p_rent_id int,
in p_total_amount decimal(10,2),
in p_promo_id int
)
begin
start transaction;
insert into orders(user_id,rent_id,promo_id,total_amount,final_amount)values(p_user_id,p_rent_id,p_promo_id,p_total_amount,p_total_amount);
commit;
end //
delimiter ;

-- to Confirm order
delimiter //
create procedure confirm_order(
in p_order_id int)
begin
update orders set status = 'confirmed'where order_id = p_order_id and status = 'pending';
end //
delimiter ;

-- Insert payment
delimiter //
create procedure make_payment(
in p_rent_id int,
in p_emi_id int,
in p_amount decimal(10,2),
in p_method varchar(50))
begin
insert into payments(rent_id,emi_id,amount,payment_method)values(p_rent_id,p_emi_id,p_amount,p_method);
end //
delimiter ;

-- to close rent
delimiter //
create procedure close_rent(
in p_rent_id int)
begin
update rent_details set status = 'completed',end_date = curdate() where rent_id = p_rent_id;
end //
delimiter ;

-- to fetch all user details
delimiter //
create procedure get_user_full_details(
in p_user_id int)
begin
select u.user_id,u.full_name,u.email,u.phone,u.address,u.status as user_status,u.created_at as user_created_at,r.rent_id,r.start_date,r.end_date,r.status as rent_status,r.outstanding_due,
o.order_id,o.status as order_status,o.payment_status,o.final_amount,count(e.emi_id) as total_emis,
sum(case when e.status = 'paid' then e.amount else 0 end) as total_emi_paid,
sum(p.amount) as total_paid_amount from users u
left join rent_details r on u.user_id = r.user_id
left join orders o on r.rent_id = o.rent_id
left join emi_details e on r.rent_id = e.rent_id
left join payments p on r.rent_id = p.rent_id where u.user_id = p_user_id group by u.user_id,r.rent_id,o.order_id;
end //
delimiter ;

-- Updates EMI + payments + outstanding due
delimiter //
create procedure pay_emi(
in p_emi_id int,
in p_amount decimal(10,2))
begin
update emi_details set status = 'paid',paid_date = curdate() where emi_id = p_emi_id;
insert into payments (emi_id, amount, status) values (p_emi_id, p_amount, 'successful');
end //
delimiter ;

-- Get All Active Rentals
delimiter //
create procedure get_active_rentals()
begin
select * from rent_details where status='active';
end //
delimiter ;

-- Get Pending EMIs
delimiter //
create procedure get_pending_emis()
begin
select * from emi_details where status='pending'order by due_date;
end //
delimiter ;

-- User Payment Summary
delimiter //
create procedure sp_user_payment_summary(
in p_user_id int)
begin
select u.full_name,sum(p.amount) as total_paid from users u
join rent_details r on u.user_id = r.user_id
join payments p on r.rent_id = p.rent_id where u.user_id = p_user_id group by u.user_id;
end //
delimiter ;

-- to get monthly revenue
delimiter //
create procedure monthly_revenue()
begin
select month(created_at) as month, sum(amount) as revenue from payments where status = 'successful' group by month(created_at);
end //
delimiter ;

-- to find low stock models
delimiter //
create procedure low_stock_models()
begin 
select * from models where available_quantity < 5;
end //
delimiter ;
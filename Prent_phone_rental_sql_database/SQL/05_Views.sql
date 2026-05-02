-- VIEWS

-- Shows user details along with their rented phone and plan information in one place.
create view user_overview as
select u.user_id,u.full_name,u.email,u.phone,u.status as user_status,
r.rent_id,r.status as rent_status,r.outstanding_due,
m.brand,m.model_name,m.storage,m.color,
p.plan_name,p.tenure_months,p.monthly_rent from users u
left join rent_details r on u.user_id = r.user_id
left join models m on r.model_id = m.model_id
left join plans p on r.plan_id=p.plan_id;

-- Shows all users who currently have an active phone rental.
create view active_rentals as
select r.rent_id,u.full_name,m.brand,m.model_name,r.start_date,r.next_payment_date,r.outstanding_due from rent_details r
join users u on r.user_id = u.user_id
join models m on r.model_id = m.model_id where r.status='active';

-- Shows EMI due dates and payment status for each user.
create view emi_status as
select e.emi_id,u.full_name,e.due_date,e.amount,e.status,e.paid_date from emi_details e
join rent_details r on e.rent_id = r.rent_id
join users u on r.user_id = u.user_id;

-- Shows all payments made by users for easy tracking
create view payment_history as
select p.payment_id,u.full_name,p.amount,p.payment_method,p.status,p.created_at from payments p
left join rent_details r on p.rent_id = r.rent_id
left join users u on r.user_id = u.user_id;
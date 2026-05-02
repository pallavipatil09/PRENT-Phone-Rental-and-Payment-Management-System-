-- TRIGGERS

-- trigger name : audit log
delimiter //
create trigger aft_ins_users
after insert on users
for each row
begin
insert into audit_log(entity_type, entity_id, action, remarks) values ('USER', new.user_id, 'CREATED', 'User registered successfully');
end //
delimiter ;

-- trigger name : Block deletion if user has active rentals
delimiter //
create trigger bef_del_users
before delete on users
for each row
begin
declare active_count int;
select count(*) into active_count from rent_details where user_id = old.user_id and status in ('active','paused','pending_payment');
if active_count > 0 then signal sqlstate '45000'
set message_text = 'Cannot delete user with active rentals';
end if;
end //
delimiter ;

-- trigger : To track sensitive data changes
delimiter //
create trigger address_change_log
after update on users
for each row
begin
if old.address <> new.address then
insert into audit_log(entity_type, entity_id, action, remarks) values ('USER', new.user_id, 'ADDRESS_UPDATED', 'User address changed');
end if;
end //
delimiter ;

-- trigger : Log Price Change
delimiter //
create trigger models_price_change
after update on models
for each row
begin
if old.price <> new.price then
insert into audit_log(entity_type, entity_id, action, description) values('model',new.model_id,'price_updated',concat('price changed from ₹', old.price, ' to ₹', new.price));
end if;
end //
delimiter ;

-- trigger : to update stock
delimiter //
create trigger stock_updation
after update on models
for each row
begin
if old.available_quantity <> new.available_quantity then
insert into audit_log(entity_type, entity_id, action, remarks)values('model',new.model_id,'stock_updated',concat('stock changed from ',old.available_quantity,' to ',new.available_quantity));
end if;
end //
delimiter ;

-- trigger : to manage stock automatically
delimiter //
create trigger manage_stock
after update on orders
for each row
begin
declare v_model_id int;
declare v_stock int;
select model_id into v_model_id from rent_details where rent_id = new.rent_id;
if old.status <> 'confirmed' and new.status = 'confirmed' then select available_quantity into v_stock from models where model_id = v_model_id;
if v_stock <= 0 then signal sqlstate '45000'
set message_text = 'order cannot be confirmed. model out of stock';
end if;
update models set available_quantity = available_quantity - 1 where model_id = v_model_id;
insert into audit_log(entity_type, entity_id, action, remarks) values('model',v_model_id,'stock_reduced',concat('stock reduced due to order confirmation. order id: ', new.order_id));
elseif old.status = 'confirmed' and new.status = 'cancelled' then
update models set available_quantity = available_quantity + 1 where model_id = v_model_id;
insert into audit_log(entity_type, entity_id, action, remarks)values('model',v_model_id,'stock_restored',concat('stock restored due to order cancellation. order id: ', new.order_id));
end if;
end //
delimiter ;

-- trigger : Prevent negative stock 
delimiter //
create trigger prevent_negative_stock
before update on models
for each row
begin
if new.available_quantity < 0 then signal sqlstate '45000'
set message_text = 'Stock cannot be negative';
end if;
end //
delimiter ;

-- trigger : When all EMIs are paid rental should complete automatically
delimiter //
create trigger emi_paid_update_rent
after update on emi_details
for each row
begin
declare pending_emi int;
if old.status <> 'paid' and new.status = 'paid' then
select count(*) into pending_emi from emi_details where rent_id = new.rent_id and status <> 'paid';
if pending_emi = 0 then
update rent_details set status = 'completed' where rent_id = new.rent_id; 
end if;
end if;
end //
delimiter ;

-- trigger : if Payment Failed Mark EMI Failed
delimiter //
create trigger payment_failed_update_emi
after insert on payments
for each row
begin
if new.status = 'failed' and new.emi_id is not null then
update emi_details set status = 'failed'where emi_id = new.emi_id;
end if;
end //
delimiter ;

-- trigger : Auto-set next EMI date on rent creation
delimiter //
create trigger set_next_payment_date
after insert on rent_details
for each row
begin
update rent_details
set next_payment_date = date_add(new.start_date, interval 1 month) where rent_id = new.rent_id;
end //
delimiter ;
drop trigger if exists set_next_payment_date;

-- trigger : Log Plan Price or Tenure Changes
delimiter //
create trigger plans_audit_update
after update on plans
for each row
begin
if old.monthly_rent <> new.monthly_rent or old.deposit_amount <> new.deposit_amount or old.tenure_months <> new.tenure_months then
insert into audit_log(entity_type, entity_id, action, remarks)values('plan',new.plan_id,'plan_updated',concat('plan updated: rent ',old.monthly_rent, '→', new.monthly_rent,', deposit ',
old.deposit_amount, '→', new.deposit_amount,', tenure ',old.tenure_months, '→', new.tenure_months));
end if;
end //
delimiter ;

-- trigger : to validate promo codes, automatically calculate discounts, and ensure the final payable amount is always correct
delimiter //
create trigger apply_promo_on_order
before insert on orders
for each row
begin
declare v_discount decimal(10,2);
if new.promo_id is not null then
select discount_amount into v_discount from promos where promo_id = new.promo_id and curdate() between start_date and end_date;
if v_discount is null then signal sqlstate '45000'
set message_text = 'invalid or expired promo code';
end if;
set new.discounted_amount = v_discount;
set new.final_amount = new.total_amount - v_discount;
else
set new.discounted_amount = 0;
set new.final_amount = new.total_amount;
end if;
end //
delimiter ;
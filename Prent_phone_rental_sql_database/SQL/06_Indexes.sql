-- INDEXES 

-- on users table
create index idx_users_email on users(email);
create index idx_users_phone on users(phone);
create index idx_users_status on users(status);

-- on rent_details table
create index idx_rent_user on rent_details(user_id);
create index idx_rent_model on rent_details(model_id);
create index idx_rent_status on rent_details(status);
create index idx_rent_next_payment on rent_details(next_payment_date);

-- on orders table
create index idx_orders_user on orders(user_id);
create index idx_orders_status on orders(status);
create index idx_orders_payment_status on orders(payment_status);

-- on emi_details
create index idx_emi_rent on emi_details(rent_id);
create index idx_emi_status on emi_details(status);
create index idx_emi_due_date on emi_details(due_date);

-- on payments table
create index idx_payments_rent on payments(rent_id);
create index idx_payments_status on payments(status);
create index idx_payments_date on payments(created_at);

-- on audit_log
create index idx_audit_entity on audit_log(entity_type, entity_id);
create index idx_audit_date on audit_log(created_at);

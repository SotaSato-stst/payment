GRANT ALL ON DATABASE paymentdb TO payment_user;

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE partners (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    unpaid_balance_item_id UUID
);

INSERT INTO users (name, email)
VALUES
('佐藤創太', 'stst@gmail.com'),
('佐藤三郎', 'sabu@gmail.com');

INSERT INTO partners (name, unpaid_balance_item_id)
VALUES
('佐藤株式会社', 'f0cf3640-e10f-453f-9e67-286d4ed61aa2'),
('三郎Co.jp', '678a97fa-e985-4a59-adf6-e17c46507a31');
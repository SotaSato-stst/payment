GRANT ALL ON DATABASE balancedb TO balance_user;

CREATE TABLE accounts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID,
    type VARCHAR(255),
    amount INT
);

CREATE TABLE balance_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID REFERENCES accounts(id),
    amount INT,
    remaining INT
);

CREATE TABLE balance_item_snapshots (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    previous_id UUID REFERENCES balance_item_snapshots(id),
    balance_item_id UUID REFERENCES balance_items(id),
    remaining INT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE balance_item_logs (
    balance_item_id UUID REFERENCES balance_items(id),
    tx_id UUID,
    snapshot_id UUID REFERENCES balance_item_snapshots(id),
    changes INT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO accounts (id, user_id, type, amount)
VALUES
('191700c0-ea45-424e-b5dd-47c4c5d005a7', 'ff1f5428-f4fc-4873-9749-432592b87c7b', 'point', 1000);


INSERT INTO balance_items (account_id, amount, remaining)
VALUES
('191700c0-ea45-424e-b5dd-47c4c5d005a7', 1000, 400),
('191700c0-ea45-424e-b5dd-47c4c5d005a7', 600, 400);

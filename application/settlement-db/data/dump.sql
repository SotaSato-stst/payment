GRANT ALL ON DATABASE settlementdb TO settlement_user;

CREATE TABLE IF NOT EXISTS payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    payment_type VARCHAR(50) CHECK (payment_type IN ('earning', 'commission', 'refund', 'commision_refund')),
    from_partner_id UUID,
    to_partner_id UUID,
    amount INT,
    reconciled BOOLEAN DEFAULT false,
    created_time TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO payments (payment_type, from_partner_id, to_partner_id, amount)
VALUES
('earning', '3bb91da3-76ea-461a-9311-b3113eca543c', '3bb91da3-76ea-461a-9311-b3113eca543d', 200),
('earning', '3bb91da3-76ea-461a-9311-b3113eca543e', '3bb91da3-76ea-461a-9311-b3113eca543b', 200);
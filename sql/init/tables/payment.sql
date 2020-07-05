/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates table for keeping information about payments from participants.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS payment (
    id                      BIGSERIAL NOT NULL,
    participant_id          BIGINT NOT NULL REFERENCES participant,
    cruise_id               BIGINT NOT NULL REFERENCES cruise,
    full_amount             FLOAT NOT NULL,
    prepayment              FLOAT,
    second_rate             FLOAT,
    third_rate              FLOAT,
    compensation            FLOAT,
    CONSTRAINT payment_pk PRIMARY KEY (id)
);

COMMENT ON TABLE payment IS 'Table keeps information about all payments.';

COMMENT ON COLUMN payment.full_amount IS 'The full amount of duties to be paid for the cruise.';
COMMENT ON COLUMN payment.prepayment IS 'The first rate of the payment for reservation.';
COMMENT ON COLUMN payment.compensation IS 'Value to equalize the amount of full payment.';
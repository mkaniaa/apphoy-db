/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates table for keeping information about additional t-shirts to order.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS additional_tshirt (
    id                      BIGSERIAL NOT NULL,
    cruise_id               BIGINT NOT NULL REFERENCES cruise,
    participant_id          BIGINT REFERENCES participant,
    owner_name              TEXT,
    owner_surname           TEXT,
    owner_function          TEXT NOT NULL,
    tshirt_size             TEXT NOT NULL,
    tshirt_cut              TEXT NOT NULL,
    purchaser_full_name     TEXT NOT NULL,
    price                   FLOAT NOT NULL,
    CONSTRAINT additional_tshirt_pk PRIMARY KEY (id)
);

COMMENT ON TABLE additional_tshirt IS 'Table keeps information about additional t-shirts to order for specified cruise.';
COMMENT ON COLUMN additional_tshirt.owner_name IS 'Name of a person for who t-shirt is to be ordered.';
COMMENT ON COLUMN additional_tshirt.owner_surname IS 'Surname of a person for who t-shirt is to be ordered.';
COMMENT ON COLUMN additional_tshirt.tshirt_cut IS 'Cut of a tshirt for participant" M - men''s cut, W - women''s cut.';
COMMENT ON COLUMN additional_tshirt.purchaser_full_name IS 'Name and surname of a person who ordered t-shirt.';
COMMENT ON COLUMN additional_tshirt.price IS 'Price that orderer must pay for the t-shirt.';
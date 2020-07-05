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
    purchaser_name          TEXT,
    purchaser_surname       TEXT,
    tshirt_size             TEXT,
    tshirt_cut              TEXT,
    price                   FLOAT NOT NULL,
    CONSTRAINT additional_tshirt_pk PRIMARY KEY (id)
);

COMMENT ON TABLE additional_tshirt IS 'Table keeps information about additional t-shirts to order.';
COMMENT ON COLUMN additional_tshirt.purchaser_name IS 'Nname of a person who ordered t-shirt.';
COMMENT ON COLUMN additional_tshirt.purchaser_surname IS 'Surname of a person who ordered t-shirt.';
COMMENT ON COLUMN additional_tshirt.tshirt_cut IS 'Cut of a tshirt for participant" M - men''s cut, W - women''s cut.';
COMMENT ON COLUMN additional_tshirt.tshirt_cut IS 'Price that orderer must pay for the t-shirt.';
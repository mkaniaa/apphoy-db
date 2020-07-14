/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-14
** Description : Script creates table for keeping information about dates of all cruises.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS cruise_date (
    id                      BIGSERIAL NOT NULL,
    cruise_id               BIGSERIAL NOT NULL REFERENCES cruise,
    common_name             TEXT,
    start_date              DATE NOT NULL,
    end_date                DATE NOT NULL,
    start_address           TEXT,
    final_address           TEXT,
    CONSTRAINT cruise_date_pk PRIMARY KEY (id)
);

COMMENT ON TABLE cruise_date IS 'Table keeps information about dates of all cruises.';
COMMENT ON COLUMN cruise_date.start_address IS 'Address of a starting location of a cruise date.';
COMMENT ON COLUMN cruise_date.final_address IS 'Address of a final location of a cruise date.';
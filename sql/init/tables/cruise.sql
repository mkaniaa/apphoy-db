/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates table for keeping information about all cruises.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS cruise (
    id                      BIGSERIAL NOT NULL,
    common_name             TEXT NOT NULL,
    start_date              DATE NOT NULL,
    end_date                DATE NOT NULL,
    start_address           TEXT,
    final_address           TEXT,
    CONSTRAINT cruise_pk PRIMARY KEY (id)
);

COMMENT ON TABLE cruise IS 'Table keeps information about all cruises.';
COMMENT ON COLUMN cruise.start_address IS 'Address of a starting location of a cruise.';
COMMENT ON COLUMN cruise.start_address IS 'Address of a final location of a cruise.';
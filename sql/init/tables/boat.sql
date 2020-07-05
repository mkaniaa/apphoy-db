/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates table for keeping information about all boats.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS boat (
    id                      BIGSERIAL NOT NULL,
    common_name             TEXT NOT NULL,
    model                   TEXT,
    bunks_number            INTEGER NOT NULL,
    main_propulsion         TEXT,
    length                  FLOAT,
    sail_size               FLOAT,
    engine_power            TEXT,
    CONSTRAINT boat_pk PRIMARY KEY (id)
);

COMMENT ON TABLE boat IS 'Table keeps information about all boats.';
COMMENT ON COLUMN boat.bunks_number IS 'Number of sleeping places.';
COMMENT ON COLUMN boat.main_propulsion IS 'Main propulsion of the boat e.g. engine or sail.';
COMMENT ON COLUMN boat.length IS 'Length of the boat''s hulll.';
COMMENT ON COLUMN boat.sail_size IS 'Full size sailing surface of the yacht.';
COMMENT ON COLUMN boat.engine_power IS 'The size of engine power e.g. 10KM.';
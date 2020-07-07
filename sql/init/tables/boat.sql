/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates table for keeping information about all boats.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS boat (
    id                      BIGSERIAL NOT NULL,
    charter_company_id      BIGSERIAL REFERENCES charter_company,
    common_name             TEXT NOT NULL,
    model                   TEXT,
    bunks_number            INTEGER NOT NULL,
    construction_year       TEXT,
    main_propulsion         TEXT,
    length                  FLOAT,
    height_inside           FLOAT,
    sail_size               FLOAT,
    engine_power            TEXT,
    CONSTRAINT boat_pk PRIMARY KEY (id)
);

COMMENT ON TABLE boat IS 'Table keeps information about all boats.';
COMMENT ON COLUMN boat.bunks_number IS 'Number of sleeping places.';
COMMENT ON COLUMN boat.main_propulsion IS 'Main propulsion of the boat e.g. engine or sail.';
COMMENT ON COLUMN boat.length IS 'Length of the boat''s hulll [m].';
COMMENT ON COLUMN boat.height_inside IS 'Height inside the boat''s mess [cm].';
COMMENT ON COLUMN boat.sail_size IS 'Full size sailing surface of the yacht [m2].';
COMMENT ON COLUMN boat.engine_power IS 'The size of engine power [KM].';
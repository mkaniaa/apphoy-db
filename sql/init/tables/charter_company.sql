/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates table for keeping information about charter companies.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS charter_company (
    id                      BIGSERIAL NOT NULL,
    common_name             TEXT NOT NULL,
    port_address            TEXT,
    phone                   TEXT,
    email                   TEXT,
    boats_models            TEXT[],
    CONSTRAINT charter_company_pk PRIMARY KEY (id)
);

COMMENT ON TABLE charter_company IS 'Table keeps information about all boats.';
COMMENT ON COLUMN charter_company.boats_models IS 'Models of boats that a charter company dispose of.';
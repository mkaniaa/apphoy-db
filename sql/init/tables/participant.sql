/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates table for keeping information about all participants.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS participant (
    id                      BIGSERIAL NOT NULL,
    function                TEXT NOT NULL,
    name                    TEXT NOT NULL,
    surname                 TEXT,
    phone                   TEXT,
    email                   TEXT,
    birth_date              TEXT,
    pesel                   TEXT,
    city                    TEXT,
    tshirt_size             TEXT,
    tshirt_cut              TEXT,
    in_fb_goup              BOOLEAN,
    fb_nickname             TEXT,
    CONSTRAINT participant_pk PRIMARY KEY (id)
);

COMMENT ON TABLE participant IS 'Table keeps information about all participants.';

COMMENT ON COLUMN participant.function IS 'Function of a participant in the cruise e.g. crew or skipper.';
COMMENT ON COLUMN participant.tshirt_cut IS 'Cut of a tshirt for participant" M - men''s cut, W - women''s cut.';
/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates table for keeping information about crews from all cruises.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS crew (
    id                      BIGSERIAL NOT NULL,
    cruise_date_id          BIGINT NOT NULL REFERENCES cruise_date,
    boat_id                 BIGINT REFERENCES boat,
    participant_id          BIGINT NOT NULL REFERENCES participant,
    participant_function    TEXT NOT NULL,
    CONSTRAINT crew_pk PRIMARY KEY (id),
    CONSTRAINT crew_participant_id_cruise_date_id UNIQUE (participant_id, cruise_date_id)
);

CREATE UNIQUE INDEX ON crew (participant_function, boat_id, cruise_date_id)
WHERE participant_function = 'skipper';

COMMENT ON TABLE crew IS 'Table keeps information about crews from all cruises.';

COMMENT ON COLUMN crew.participant_function IS 'Function of a participant in the crew e.g. crew or skipper.';
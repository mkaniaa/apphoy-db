/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates table for keeping information about crews from all cruises.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS crew (
    id                      BIGSERIAL NOT NULL,
    participant_id          BIGINT NOT NULL REFERENCES participant,
    cruise_id               BIGINT NOT NULL REFERENCES cruise,
    boat_id                 BIGINT REFERENCES boat,
    CONSTRAINT crew_pk PRIMARY KEY (id),
    CONSTRAINT crew_participant_id_cruise_id UNIQUE (participant_id, cruise_id)
);

COMMENT ON TABLE crew IS 'Table keeps information about crews from all cruises.';
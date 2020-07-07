/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates table for keeping information about relations between participants.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS participants_relation (
    id                         BIGSERIAL NOT NULL,
    main_participant_id        BIGSERIAL NOT NULL REFERENCES participant,
    related_participant_id     BIGSERIAL NOT NULL REFERENCES participant,
    CONSTRAINT participants_relation_pk PRIMARY KEY (id)
);

COMMENT ON TABLE participants_relation IS 'Table keeps information information about relations between participants.';

COMMENT ON COLUMN participants_relation.main_participant_id IS 'Id of a participant that is the lider of the group.';
COMMENT ON COLUMN participants_relation.related_participant_id
IS 'Id of a participant that is related with the lider of the group.';
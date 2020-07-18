/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-18
** Description : Trigger before insert or update on additional_tshirt table
checks and fills data about owner and size according to participant_id.
*****************************************************************************/

SET search_path = :schema, public;

-- --------------------------------------------------------------------------

DROP TRIGGER IF EXISTS additional_tshirt__fill_owner_data__biu;
-- DROP FUNCTION IF EXISTS additional_tshirt__fill_owner_data__biu();

/*
    Description:
        Trigger function before insert or update on additional_tshirt table
    checks the participant_id value. If it's NOT NULL, function validate owner and size
    of the tshirt according to the specified participant and raise exception if given
    data are inconsistent with main participant table, or inserts correct values
    if they are NULL.
*/

-- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION additional_tshirt__fill_owner_data__biu()
    RETURNS TRIGGER LANGUAGE plpgsql
    SET search_path=:schema, public AS
    $BODY$
    DECLARE
        v_rec   RECORD;
    BEGIN

        IF NEW.participant_id IS NOT NULL THEN
            SELECT p.name, p.surname, p.tshirt_size, p.tshirt_cut INTO v_rec
            FROM participant p
            WHERE p.id = NEW.participant_id;

            IF NEW.owner_name IS NULL THEN
                 NEW.owner_name := v_rec.name;
            ELSIF NEW.owner_name != v_rec.name THEN
                RAISE EXCEPTION 'Due the table "participant" this owner should has name: %.',  v_rec.name;
            END IF;

            IF NEW.owner_surname IS NULL THEN
                 NEW.owner_surname := v_rec.surname;
            ELSIF NEW.owner_surname != v_rec.surname THEN
                RAISE EXCEPTION 'Due the table "participant" this owner should has surname: %.',  v_rec.surname;
            END IF;

            IF NEW.tshirt_size IS NULL THEN
                 NEW.tshirt_size := v_rec.tshirt_size;
            ELSIF NEW.tshirt_size != v_rec.tshirt_size THEN
                RAISE EXCEPTION 'Due the table "participant" this owner should has tshirt size: %.',  v_rec.tshirt_size;
            END IF;

            IF NEW.tshirt_cut IS NULL THEN
                 NEW.tshirt_cut := v_rec.tshirt_cut;
            ELSIF NEW.tshirt_cut != v_rec.tshirt_cut THEN
                RAISE EXCEPTION 'Due the table "participant" this owner should has tshirt cut: %.',  v_rec.tshirt_cut;
            END IF;
        END IF;

        RETURN NEW;

    END;
    $BODY$;

COMMENT ON FUNCTION additional_tshirt__fill_owner_data__biu()
IS 'Trigger before insert or update on additional_tshirt table checks and fills data about owner and size according to participant_id.';
ALTER FUNCTION additional_tshirt__fill_owner_data__biu() OWNER TO postgres;

-- --------------------------------------------------------------------------------

/*
 Description:
    Trigger before insert or update on additional_tshirt table checks the participant_id value.
    If it's NOT NULL, function validate owner and size of the tshirt according to the specified
    participant and raise exception if given data are inconsistent with main participant table,
    or inserts correct values if they are NULL.
*/
CREATE TRIGGER additional_tshirt__fill_owner_data__biu
  BEFORE INSERT OR UPDATE
  ON additional_tshirt
  FOR EACH ROW
  EXECUTE PROCEDURE additional_tshirt__fill_owner_data__biu();

-- --------------------------------------------------------------------------------

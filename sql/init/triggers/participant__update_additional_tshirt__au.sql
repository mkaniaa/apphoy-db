/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-19
** Description : Trigger after update of tshirt information for given participant.
Trigger performs function to update data in additional_tshirt table according 
to changes done in participant table.
*****************************************************************************/

SET search_path = :schema, public;

-- --------------------------------------------------------------------------

DROP TRIGGER IF EXISTS participant__update_additional_tshirt__au;
-- DROP FUNCTION IF EXISTS participant__update_additional_tshirt__au();

/*
    Description:
    Trigger after update of tshirt information for given participant.
    Trigger performs function to update data in additional_tshirt table for given
    participant according to changes done in participant table.
*/

-- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION participant__update_additional_tshirt__au()
    RETURNS TRIGGER LANGUAGE plpgsql
    SET search_path=:schema, public AS
$BODY$
BEGIN

    IF EXISTS (SELECT 1 FROM additional_tshirt WHERE participant_id = NEW.id) THEN
        PERFORM additional_tshirt__update_tshirt_info(NEW.id, NEW.tshirt_size, NEW.tshirt_cut);
    END IF;

    RETURN NEW;

END;
$BODY$;

COMMENT ON FUNCTION participant__update_additional_tshirt__au()
IS 'Trigger after update of tshirt information for given participant to update additional_tshirt table.';
ALTER FUNCTION participant__update_additional_tshirt__au() OWNER TO postgres;

-- --------------------------------------------------------------------------------

/*
 Description:
    Trigger after update of tshirt information for given participant.
    Trigger performs function to update data in additional_tshirt table for given
    participant according to changes done in participant table.
*/
CREATE TRIGGER participant__update_additional_tshirt__au
  AFTER UPDATE OF tshirt_cut, tshirt_size
  ON participant
  FOR EACH ROW
  EXECUTE PROCEDURE participant__update_additional_tshirt__au();

-- --------------------------------------------------------------------------------

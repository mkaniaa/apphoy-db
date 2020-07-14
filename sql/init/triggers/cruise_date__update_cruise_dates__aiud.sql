/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-14
** Description : Trigger after any insert, update or delete on table cruise_dates 
updates end and start date of cruise, that updated element refers to.
*****************************************************************************/

SET search_path = :schema, public;

-- --------------------------------------------------------------------------

DROP TRIGGER IF EXISTS cruise_date__update_cruise_dates__aiud;
-- DROP FUNCTION IF EXISTS cruise_date__update_cruise_dates__aiud();

/*
    Description: Trigger function after any insert, update or delete on table cruise_dates performs
    function cruise__update_cruise_dates(BIGINT), responsible for updating end and start
    date of cruise, that updated element refers to.
*/

-- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION cruise_date__update_cruise_dates__aiud()
    RETURNS TRIGGER LANGUAGE plpgsql
    SET search_path=:schema, public AS
    $BODY$

    BEGIN

        IF TG_OP = 'UPDATE' THEN
            PERFORM cruise__update_cruise_dates(NEW.cruise_id);
            PERFORM cruise__update_cruise_dates(OLD.cruise_id);
        ELSIF TG_OP = 'DELETE' THEN
            PERFORM cruise__update_cruise_dates(OLD.cruise_id);
        ELSE
            PERFORM cruise__update_cruise_dates(NEW.cruise_id);
        END IF;

        RETURN NEW;

    END;
    $BODY$;

COMMENT ON FUNCTION cruise_date__update_cruise_dates__aiud()
IS 'Trigger function for updating end and start date of cruise, that deleted, updated or inserted element refers to.';
ALTER FUNCTION cruise_date__update_cruise_dates__aiud() OWNER TO postgres;

-- --------------------------------------------------------------------------------

/*
 Description:
    Trigger after any insert, update or delete on table cruise_dates performs
    function cruise__update_cruise_dates(BIGINT), responsible for updating end and start
    date of cruise, that updated element refers to.
*/
CREATE TRIGGER cruise_date__update_cruise_dates__aiud
  AFTER DELETE OR UPDATE OR INSERT
  ON cruise_date
  FOR EACH ROW
  EXECUTE PROCEDURE cruise_date__update_cruise_dates__aiud();

-- --------------------------------------------------------------------------------

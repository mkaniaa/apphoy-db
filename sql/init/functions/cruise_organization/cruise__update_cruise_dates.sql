/****************************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-14
** Description : The function updates start and end date of a cruise with given id,
by calculating the earliest and latest date based on all cruise_date records related with this cruise.
*****************************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS cruise__update_cruise_dates(BIGINT);
/*
    Description: The function updates start and end date of a cruise with given id, by calculating 
    the earliest and latest date based on all cruise_date records related with this cruise.
        It updates:
           * start_date - earliest date among all cruise dates,
           * end_date - latest date among all cruise dates.

    Params:
        * p_cruise_id  - ID of the cruise which start and end dates should be updated.

    Returns: void
*/

CREATE OR REPLACE FUNCTION cruise__update_cruise_dates(p_cruise_id BIGINT)
    RETURNS void LANGUAGE plpgsql
    SET search_path TO :schema, public AS
$BODY$
DECLARE
    v_earliest_date DATE := (
        SELECT start_date
        FROM cruise_date
        WHERE cruise_id = p_cruise_id
        ORDER BY start_date FETCH FIRST ROW ONLY);
    v_latest_date DATE := (
        SELECT end_date
        FROM cruise_date
        WHERE cruise_id = p_cruise_id
        ORDER BY end_date DESC FETCH FIRST ROW ONLY);
BEGIN
    IF p_cruise_id IS NULL THEN
        RAISE EXCEPTION 'To update cruise dates, provide correct cruise id!';
    END IF;

    UPDATE cruise
    SET
        start_date = v_earliest_date,
        end_date = v_latest_date
    WHERE cruise.id = p_cruise_id;
END;
$BODY$;

COMMENT ON FUNCTION cruise__update_cruise_dates(BIGINT)
IS 'The function updates start and end date of a cruise with given id.';

ALTER FUNCTION cruise__update_cruise_dates(BIGINT) OWNER TO postgres;

-- ---------------------------------------------------------------------------------------
/****************************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-31
** Description : The function returns report containing details about crew on specified boat and cruise date.
*****************************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS tools_reports__get_boat_crew_report(BIGINT, BIGINT);
/*
    Description:
        The function returns report containing details about crew on specified boat and cruise date.

    Params:
        * p_boat_id - ID of the boat for which report is to be generated.
        * p_cruise_date_id  - ID of the cruise date to which given boat is assigned.

    Returns: table containing columns:
        * id - id of boat crew member,
        * member_function - function of the member in the crew,
        * member_full_name - full name of the crew member,
        * member_phone_number - phone of the member,
        * member_email - email of the member,
        * member_tshirt_cut - cut t-shirt of the member,
        * member_tshirt_size - size t-shirt of the member.
*/

CREATE OR REPLACE FUNCTION tools_reports__get_boat_crew_report(p_boat_id BIGINT, p_cruise_date_id BIGINT)
    RETURNS TABLE (
        id                  BIGINT,
        member_function     TEXT,
        member_full_name    TEXT,
        member_phone_number TEXT,
        member_email        TEXT,
        member_tshirt_cut   TEXT,
        member_tshirt_size  TEXT)
    LANGUAGE plpgsql
    SET search_path TO :schema, public AS
$BODY$
BEGIN
    IF p_boat_id IS NULL OR p_cruise_date_id IS NULL THEN
        RAISE EXCEPTION 'To generate boat crew report, boat id and cruise date id must be specified!';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM crew WHERE cruise_date_id = p_cruise_date_id AND boat_id = p_boat_id) THEN
        RAISE EXCEPTION 'The boat % is not assigned to the cruise date %', p_boat_id, p_cruise_date_id;
    END IF;

    RETURN QUERY
        SELECT
            ROW_NUMBER() OVER() AS id,
            x.member_function,
            x.member_full_name,
            x.member_phone_number,
            x.member_email,
            x.member_tshirt_cut,
            x.member_tshirt_size
        FROM (
            SELECT
                cw.participant_function AS member_function,
                p.name || ' ' || p.surname AS member_full_name,
                p.phone AS member_phone_number,
                p.email AS member_email,
                CASE
                    WHEN p.tshirt_cut = 'W' THEN 'Women'
                    WHEN p.tshirt_cut = 'M' THEN 'Man'
                    ELSE 'Undefined'
                END AS member_tshirt_cut,
                p.tshirt_size AS member_tshirt_size
            FROM crew cw
            JOIN participant p ON cw.participant_id = p.id
            WHERE cw.boat_id = p_boat_id AND cw.cruise_date_id = p_cruise_date_id
            ORDER BY cw.participant_function DESC, p.name) x;
END;
$BODY$;

COMMENT ON FUNCTION tools_reports__get_boat_crew_report(BIGINT, BIGINT)
IS 'The function returns report containing details about crew on specified boat and cruise date.';

ALTER FUNCTION tools_reports__get_boat_crew_report(BIGINT, BIGINT) OWNER TO postgres;

-- ---------------------------------------------------------------------------------------
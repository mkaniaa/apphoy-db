/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates view for details about all crews.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

-- TODO: zrobic kolumne ilosc_zalogi/max_ilosc_zalogi

DROP VIEW IF EXISTS vw_crew_details;

CREATE OR REPLACE VIEW vw_crew_details AS
    SELECT
        sk.cruise_common_name,
        b.boat_common_name,
        sk.skipper_full_name,
        p.name || ' ' || p.surname AS crew_member_full_name,
        DATE_PART('year', AGE(p.birth_date)) AS crew_member_age
    FROM crew cw
    JOIN boat b ON cw.boat_id = b.id
    JOIN participant p ON cw.participant_id = p.id
    JOIN vw_boat_skipper sk ON b.id = sk.boat_id;

COMMENT ON VIEW vw_boat_skipper IS 'Script creates view for details about all crews.';
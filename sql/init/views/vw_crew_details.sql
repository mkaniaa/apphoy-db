/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates view for details about all crews.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_crew_details CASCADE;

CREATE OR REPLACE VIEW vw_crew_details AS
    SELECT
        sk.cruise_common_name,
        sk.cruise_date_common_name,
        sk.boat_common_name,
        sk.skipper_full_name,
        p.id AS participant_id,
        p.name || ' ' || p.surname AS crew_member_full_name,
        DATE_PART('year', AGE(p.birth_date)) AS crew_member_age,
        ROW_NUMBER() OVER(
            PARTITION BY sk.cruise_date_id, sk.cruise_date_id, sk.boat_id
            ORDER BY sk.boat_id, sk.skipper_full_name, p.id)
        AS member_number,
        b.bunks_number AS boat_bunks_number
    FROM crew cw
    JOIN participant p ON cw.participant_id = p.id
    JOIN vw_boat_skipper sk ON cw.boat_id = sk.boat_id AND cw.cruise_date_id = sk.cruise_date_id
    JOIN boat b ON cw.boat_id = b.id
    ORDER BY sk.cruise_date_start, sk.boat_common_name, sk.skipper_full_name, member_number;

COMMENT ON VIEW vw_boat_skipper IS 'Script creates view for details about all crews.';
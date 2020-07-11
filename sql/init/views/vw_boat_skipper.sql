/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-10
** Description : Script creates view for details about all skippers.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_boat_skipper CASCADE;

CREATE OR REPLACE VIEW vw_boat_skipper AS
    SELECT
        cu.start_date AS cruise_start_date,
        cu.id AS cruise_id,
        cu.common_name AS cruise_common_name,
        b.id AS boat_id,
        b.common_name AS boat_common_name,
        p.name || ' ' || p.surname AS skipper_full_name,
        DATE_PART('year', AGE(p.birth_date)) AS skipper_age,
        p.phone AS skipper_phone,
        p.email AS skipper_email
    FROM crew cw
    JOIN participant p
    ON cw.participant_id = p.id
    JOIN cruise cu ON cw.cruise_id = cu.id
    JOIN boat b ON cw.boat_id = b.id
    WHERE p.function = 'skipper'
    ORDER BY cu.start_date, cu.id, b.id;

COMMENT ON VIEW vw_boat_skipper IS 'Script creates view for details about all skippers.';
/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-19
** Description : Script creates view for listing all t-shirts from all cruises.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

-- DROP VIEW IF EXISTS vw_cruise_tshirts CASCADE;

CREATE OR REPLACE VIEW vw_cruise_tshirts AS
    SELECT ROW_NUMBER() OVER() AS id, e.*
    FROM (
        SELECT
            c.id AS cruise_id,
            c.common_name AS cruise_common_name,
            CONCAT(p.name, ' ', p.surname) AS owner_common_name,
            cw.participant_function AS tshirt_function,
            p.tshirt_size,
            p.tshirt_cut
        FROM crew cw
        JOIN cruise_date cd ON cw.cruise_date_id = cd.id
        JOIN cruise c ON cd.cruise_id = c.id
        JOIN participant p ON cw.participant_id = p.id
        GROUP BY cw.participant_id, c.id, cw.participant_function, p.name, p.surname,  p.tshirt_size, p.tshirt_cut

        UNION ALL

        SELECT
            a.cruise_id,
            c.common_name AS cruise_common_name,
            COALESCE(a.owner_name || ' ' || a.owner_surname, a.purchaser_full_name) AS owner_common_name,
            a.owner_function AS tshirt_function,
            a.tshirt_size,
            a.tshirt_cut
        FROM additional_tshirt a
        JOIN cruise c ON a.cruise_id = c.id) e;

COMMENT ON VIEW vw_cruise_tshirts IS 'Script creates view for listing all t-shirts from all cruises.';
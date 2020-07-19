/****************************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-19
** Description : The function returns report containing number of t-shirts for given cruise,
sorted by function, model and size.
*****************************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS tools_reports__get_tshirt_report(BIGINT);
/*
    Description: 
        The function returns report containing number of t-shirts for given cruise,
        sorted by function, model and size.

    Params:
        * p_cruise_id  - ID of the cruise for which report is to be generated.

    Returns: table containing columns:
        * function - function of t-shirts owners (e.g. crew or skipper),
        * model - t-shirts cut (e.g. Man or Woman),
        * size - t-shirts size,
        * count - number of t-shirts with specified function, model and size.
*/

CREATE OR REPLACE FUNCTION tools_reports__get_tshirt_report(p_cruise_id BIGINT)
    RETURNS TABLE (
        "function" TEXT,
        model TEXT,
        size TEXT,
        count BIGINT)
    LANGUAGE plpgsql
    SET search_path TO :schema, public AS
$BODY$
BEGIN
    IF p_cruise_id IS NULL THEN
        RAISE EXCEPTION 'To generate t-shirt report, cruise id must be specified!';
    END IF;

    RETURN QUERY
        SELECT
            x.tshirt_function as "function",
            x.tshirt_cut as model,
            x.tshirt_size as "size",
            x."count"
        FROM (
            SELECT
                vct.tshirt_function,
                CASE
                    WHEN vct.tshirt_cut = 'W' THEN 'Women'
                    WHEN vct.tshirt_cut = 'M' THEN 'Man'
                    ELSE 'Undefined'
                END AS tshirt_cut,
                vct.tshirt_size,
                count(vct.id),
                CASE
                    WHEN vct.tshirt_size = 'S' THEN 1
                    WHEN vct.tshirt_size = 'M' THEN 2
                    WHEN vct.tshirt_size = 'L' THEN 3
                    WHEN vct.tshirt_size = 'XL' THEN 4
                    WHEN vct.tshirt_size = 'XXL' THEN 5
                    WHEN vct.tshirt_size = 'XXXL' THEN 6
                    WHEN vct.tshirt_size = 'XXXXL' THEN 7
                    ELSE 8
                END AS priori
            FROM vw_cruise_tshirts vct
            WHERE vct.cruise_id = p_cruise_id
            GROUP BY vct.tshirt_function, vct.tshirt_size, vct.tshirt_cut
            ORDER BY vct.tshirt_function DESC, vct.tshirt_cut desc, priori) x;
END;
$BODY$;

COMMENT ON FUNCTION tools_reports__get_tshirt_report(BIGINT)
IS 'The function returns report containing number of t-shirts for given cruise, sorted by function, model and size.';

ALTER FUNCTION tools_reports__get_tshirt_report(BIGINT) OWNER TO postgres;

-- ---------------------------------------------------------------------------------------
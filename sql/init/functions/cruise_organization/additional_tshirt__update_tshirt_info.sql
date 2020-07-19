/****************************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-19
** Description : The function updates information for all additional t-shirts of participant with given id.
*****************************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS additional_tshirt__update_tshirt_info(BIGINT, TEXT, TEXT);
/*
    Description: The function updates information for all additional t-shirts of participant with given id.
        It updates tshirt_size and tshirt_cut columns.

    Params:
        * p_participant_id  - ID of the participant of which tshirts are to be updated.
        * p_tshirt_size - new size for the tshirt.
        * p_tshirt_cut - new cut for the tshirt.

    Returns: void
*/

CREATE OR REPLACE FUNCTION additional_tshirt__update_tshirt_info(
    p_participant_id BIGINT,
    p_tshirt_size TEXT,
    p_tshirt_cut TEXT)
    RETURNS void LANGUAGE plpgsql
    SET search_path TO :schema, public AS
$BODY$
BEGIN
    IF p_participant_id IS NULL OR p_tshirt_size IS NULL OR p_tshirt_cut IS NULL THEN
        RAISE EXCEPTION 'To update additional tshirts information, all parameters must be specified: p_participant_id, p_tshirt_size, p_tshirt_cut!';
    END IF;

    UPDATE additional_tshirt
    SET
        tshirt_size = p_tshirt_size,
        tshirt_cut = p_tshirt_cut
    WHERE participant_id = p_participant_id;
END;
$BODY$;

COMMENT ON FUNCTION additional_tshirt__update_tshirt_info(BIGINT, TEXT, TEXT)
IS 'The function updates information for all additional t-shirts of participant with given id.';

ALTER FUNCTION additional_tshirt__update_tshirt_info(BIGINT, TEXT, TEXT) OWNER TO postgres;

-- ---------------------------------------------------------------------------------------
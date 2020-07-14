/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-07
** Description : Function used to set the numbering sequence of the table on
value above the maximum existing in numbered column.
*****************************************************************************/

SET search_path = public;

-- --------------------------------------------------------------------------

DROP FUNCTION IF EXISTS public__set_seq_above_max(TEXT, TEXT, TEXT, TEXT, INTEGER) CASCADE;

/*
 Description:
    Function used to set the numbering sequence of the table on value above the maximum existing in numbered column.
    To find the sequence name to change, use the sql queries:

        SELECT sequence_name
        FROM information_schema.sequences
        WHERE sequence_schema = 'schema_name'

        SELECT column_default
        FROM information_schema.columns
        WHERE table_name = 'table_name';

 Param:
    * p_schema_name - name of the schema in which the sequence is located (TEXT),
    * p_seq_name - name of the sequence to change (TEXT),
    * p_table_name - name of the table on which the sequence is set (TEXT),
    * p_column_name - name of the column on which the sequence is set (TEXT, default: id),
    * p_val_above - value by which the sequence is to be increased above the maximum existing (INTEGER, default: 1).

 Return:
    This function returns table, describing changes that had been done on the sequence.
*/

CREATE OR REPLACE FUNCTION public__set_seq_above_max(
    p_schema_name   TEXT,
    p_seq_name      TEXT,
    p_table_name    TEXT,
    p_column_name   TEXT DEFAULT 'id',
    p_val_above     INTEGER DEFAULT 1)
    RETURNS TABLE(
        schema_name     TEXT,
        sequence_name   TEXT,
        old_value       BIGINT,
        new_value       BIGINT)
    LANGUAGE plpgsql AS
$BODY$
DECLARE
    v_old_value         BIGINT;
    v_new_value         BIGINT;
    v_curr_val_sql_tl   TEXT := 'SELECT last_value::BIGINT FROM %1$I.%2$I';
    v_max_val_sql_tl    TEXT := 'SELECT MAX(%1$I)::BIGINT FROM %2$I.%3$I';
    v_alter_seq_sql_tl  TEXT := 'ALTER SEQUENCE %1$I.%2$I MINVALUE %3$s START %3$s RESTART %3$s';

BEGIN
    IF p_schema_name IS NULL
        OR p_seq_name IS NULL
        OR p_table_name IS NULL
        OR p_column_name IS NULL
        OR p_val_above IS NULL THEN

        RAISE EXCEPTION
            'These parameters cannot be NULL: p_schema_name, p_seq_name, p_table_name, p_column_name, p_val_above!';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.sequences s
        WHERE s.sequence_schema = p_schema_name AND s.sequence_name = p_seq_name) THEN

        RAISE EXCEPTION 'Sequence % does not exist in the schema: %!', p_seq_name, p_schema_name;
    END IF;

    EXECUTE FORMAT(v_curr_val_sql_tl, p_schema_name, p_seq_name) INTO v_old_value;
    EXECUTE FORMAT(v_max_val_sql_tl, p_column_name, p_schema_name, p_table_name) INTO v_new_value;
    v_new_value := COALESCE(v_new_value + p_val_above, 1);
    EXECUTE FORMAT(v_alter_seq_sql_tl, p_schema_name, p_seq_name, v_new_value);

    RETURN QUERY
        SELECT
            p_schema_name,
            p_seq_name,
            v_old_value,
            v_new_value;
END;
$BODY$;

COMMENT ON FUNCTION public__set_seq_above_max(TEXT, TEXT, TEXT, TEXT, INTEGER)
IS 'Function used to set the numberign sequence of the table on value above the maximum existing in numbered column.';

ALTER FUNCTION public__set_seq_above_max(TEXT, TEXT, TEXT, TEXT, INTEGER) OWNER TO postgres;
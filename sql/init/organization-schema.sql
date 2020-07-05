/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script creates main schema for alkorejs-db database.
*****************************************************************************/

-- Executig in public schema.
CREATE EXTENSION IF NOT EXISTS postgis SCHEMA public;
CREATE EXTENSION IF NOT EXISTS postgis_sfcgal SCHEMA public;

CREATE SCHEMA IF NOT EXISTS :schema AUTHORIZATION postgres;

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------
/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-11
** Description : Script installs all views for cruise_organization schema.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

\ir vw_boat_skipper.sql
\ir vw_crew_details.sql
\ir vw_cruise_tshirts.sql
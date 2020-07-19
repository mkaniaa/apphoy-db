/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-14
** Description : Script installs all functions for cruise_organization schema.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

\ir cruise_date__update_cruise_dates__aiud.sql
\ir additional_tshirt__fill_owner_data__biu.sql
\ir participant__update_additional_tshirt__au.sql
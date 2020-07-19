/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-07
** Description : Script installs all functions for cruise_organization schema.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

-- public
\ir public/public__set_seq_above_max.sql

-- cruise_organization
\ir cruise_organization/cruise__update_cruise_dates.sql
\ir cruise_organization/additional_tshirt__update_tshirt_info.sql
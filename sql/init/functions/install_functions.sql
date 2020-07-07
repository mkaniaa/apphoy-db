/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-07
** Description : Script installs all functions for cruise_organization schema.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

-- public
\ir public/public__set_seq_above_max.sql
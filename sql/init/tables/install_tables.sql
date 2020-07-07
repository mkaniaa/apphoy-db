/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-07
** Description : Script installs all tables for cruise_organization schema.
*****************************************************************************/

SET search_path = :schema, public;

-- ---------------------------------------------------------------------------

\ir boat.sql
\ir cruise.sql
\ir participant.sql
\ir payment.sql
\ir crew.sql
\ir participants_relation.sql
\ir charter_company.sql
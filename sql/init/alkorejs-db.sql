/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script installs all database objects for alkorejs-db database.
*****************************************************************************/

-- main schema
\ir organization-schema.sql;

-- tables
\ir tables/boat.sql
\ir tables/cruise.sql
\ir tables/participant.sql
\ir tables/payment.sql
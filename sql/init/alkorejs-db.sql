/*****************************************************************************
** Author      : Marek Kania
** Create Date : 2020-07-05
** Description : Script installs all database objects for alkorejs-db database.
*****************************************************************************/

-- main schema
\ir organization-schema.sql;

-- tables
\ir tables/install_tables.sql

-- views
\ir views/install_views.sql

-- functions
\ir functions/install_functions.sql
# alkorejs-db
Postgres database DDL for trip Alkorejs.

# Example install run on windows:
psql -h localhost -p 5432 -d "alkorejs_db" -U "postgres" -1 ^
    -v ON_ERROR_STOP=1 ^
    -v schema=cruise_organization ^
    -f E:\Projekty\Programowanie\Alkorejs\alkorejs-db\sql\init\alkorejs-db.sql


-- Revert ofact:sales from pg

BEGIN;

-- XXX Add DDLs here.
drop function sales_by_date;

COMMIT;

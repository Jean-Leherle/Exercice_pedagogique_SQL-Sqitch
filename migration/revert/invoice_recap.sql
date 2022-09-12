-- Revert ofact:invoice_recap from pg

BEGIN;

-- XXX Add DDLs here.
DROP view invoice_recap;

COMMIT;

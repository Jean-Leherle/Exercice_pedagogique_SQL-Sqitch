-- Verify ofact:invoice_recap on pg

BEGIN;

-- XXX Add verifications here.
SELECT * FROM invoice_recap;

ROLLBACK;

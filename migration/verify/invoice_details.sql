-- Verify ofact:invoice_details on pg

BEGIN;

-- XXX Add verifications here.
SELECT * FROM invoice_details;

ROLLBACK;

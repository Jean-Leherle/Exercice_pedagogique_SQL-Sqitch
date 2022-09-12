-- Active: 1661837537944@@127.0.0.1@5432@ofact@public
-- Revert ofact:invoice_details from pg

BEGIN;

-- XXX Add DDLs here.
DROP view invoice_details;

COMMIT;

BEGIN;

DROP INDEX IF EXISTS visitor_index, product_index, invoice_index, invoice_line_index;

DROP TABLE IF EXISTS visitor, product, invoice, invoice_line;
DROP DOMAIN IF EXISTS zip, mail;
commit;

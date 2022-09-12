-- Revert ofact:cruf_function from pg

BEGIN;

-- XXX Add DDLs here.
drop function insert_visitor;

drop function update_invoice_line;

drop function update_invoice;

COMMIT;

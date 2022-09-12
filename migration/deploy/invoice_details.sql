-- Deploy ofact:invoice_details to pg

BEGIN;

-- XXX Add DDLs here.

CREATE or replace view invoice_details AS
SELECT visitor.name, visitor.city, 
invoice.id invoice_ref, invoice.issued_at, invoice.paid_at, 
invoice_line.quantity,
product.label, product.price, product.tva, (get_priceTaxed(product.id)*invoice_line.quantity) total_line

FROM visitor
JOIN invoice ON invoice.visitor_id = visitor.id
JOIN invoice_line ON invoice_line.invoice_id= invoice.id
JOIN product ON product.id = invoice_line.product_id;


COMMIT;

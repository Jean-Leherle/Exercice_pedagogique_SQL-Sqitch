-- Deploy ofact:invoice_recap to pg

BEGIN;

-- XXX Add DDLs here.

CREATE OR REPLACE VIEW invoice_recap AS
SELECT I.id, I.issued_at, I.paid_at,  visitor.name visitor, I.total 
FROM visitor, (SELECT 
  invoice.id, invoice.issued_at, invoice.paid_at, invoice.visitor_id, D.total
  FROM invoice,  (SELECT 
    invoice_ref, sum(total_line) total
    FROM invoice_details
    GROUP BY invoice_ref) D
  WHERE invoice.id= D.invoice_ref) I
where I.visitor_id = visitor.id;

COMMIT;

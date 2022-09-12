-- Deploy ofact:cruf_function to pg

BEGIN;

--insert d'un nouvel utilisateur
CREATE OR REPLACE FUNCTION insert_visitor (visitor_values json) 
returns TABLE(id int, "email" mail, "password" text, "name" text,"address" text, "zip_cope" zip, "city" text  ) 
AS $$

BEGIN

--raise notice 'email : %', (visitor_values->>'email');
INSERT INTO visitor(email, password, name, address, zip_code, city) VALUES
(visitor_values->>'email',
visitor_values->>'password',
visitor_values->>'name', 
visitor_values->>'address', 
visitor_values->>'zip_code', 
visitor_values->>'city' 
);

return QUERY SELECT * FROM visitor where visitor."email" = (visitor_values->>'email');

END;
$$ LANGUAGE plpgsql;

--update des ligne de facture

CREATE OR REPLACE FUNCTION update_invoice_line (inv_li_values json) 
returns TABLE(id integer, "quantity" integer, "invoice_id" integer, "product_id" integer)
AS $$


BEGIN
update invoice_line
SET 
quantity = (inv_li_values->>'quantity')::int,
invoice_id = (inv_li_values->>'invoice_id')::int,
product_id = (inv_li_values->>'product_id')::int 
where invoice_line.id = (inv_li_values->>'id')::int;

return QUERY SELECT * FROM invoice_line where invoice_line.id = (inv_li_values->>'id')::int;

END;
$$ LANGUAGE plpgsql;

--update de la facture avec ou sans date
CREATE OR REPLACE FUNCTION update_invoice (invoice_values json) 
returns TABLE(id integer,"visitor_id" integer, "issued_at" timestamptz, "paid_at" timestamptz)
AS $$

BEGIN
update invoice
SET 
visitor_id = (invoice_values ->> 'visitor_id')::int,
paid_at = coalesce ((invoice_values ->> 'paid_at')::timestamptz, now());

return QUERY SELECT * FROM invoice where invoice.id = (invoice_values->>'id')::int;

END;
$$ LANGUAGE plpgsql;
COMMIT;

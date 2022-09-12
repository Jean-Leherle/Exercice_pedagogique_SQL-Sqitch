-- Revert ofact:3fn from pg

BEGIN;

 CREATE OR REPLACE FUNCTION get_price_taxe(product_id INT)
RETURNS decimal AS $$
  SELECT product.price*(1+product.tva)  FROM product WHERE product.id=product_id;
$$ LANGUAGE sql; 

 ALTER TABLE product 
ADD COLUMN price_with_taxes decimal;

UPDATE product 
SET tva = get_price_taxe(id);

ALTER TABLE product 
DROP COLUMN tva;

COMMIT;


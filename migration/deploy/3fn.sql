-- Deploy ofact:3fn to pg

BEGIN;

CREATE OR REPLACE FUNCTION get_taxe(product_id INT)
RETURNS decimal(8) AS $$
  SELECT (product.price_with_taxes-product.price)/product.price FROM product WHERE product.id=product_id;
$$ LANGUAGE sql;

 

 ALTER TABLE product 
ADD COLUMN tva decimal;

UPDATE product 
SET tva = get_taxe(id);

ALTER TABLE product
DROP COLUMN price_with_taxes;

CREATE OR REPLACE FUNCTION get_priceTaxed(product_id INT)
RETURNS decimal AS $$
  SELECT product.price*(1+product.tva)  FROM product WHERE product.id=product_id;
$$ LANGUAGE sql; 



COMMIT;
  
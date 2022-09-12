-- Active: 1661837537944@@127.0.0.1@5432@ofact@public
BEGIN;

create domain mail AS text 
check(
  value ~ '^[a-zA-Z0-9\_\-\.]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$'
);

create domain zip AS TEXT 
check(
  value ~ '^[0-9]{5}$'
);



CREATE table "visitor" (
  "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "email" mail UNIQUE,
  "password" text NOT NULL,
  "name" text NOT NULL,
  "address" text NOT NULL,
  "zip_code" zip NOT NULL,
  "city" TEXT NOT NULL
);

CREATE TABLE "product" (
  "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "label" text NOT NULL,
  "price" DECIMAL(8,2) NOT NULL check (price >0),
  "price_with_taxes" DECIMAL(8,2) NOT NULL check (price >0) 
);

CREATE TABLE "invoice" (
  "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "visitor_id" int REFERENCES visitor(id),
  "issued_at" TIMESTAMPTZ DEFAULT NOW(), 
  "paid_at" TIMESTAMPTZ DEFAULT NULL
);

CREATE TABLE "invoice_line" (
  "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "quantity" INTEGER,
  "invoice_id" INTEGER REFERENCES "invoice" (id),
  "product_id"INTEGER REFERENCES "product" (id)
);

--visitor email dispose déjà d'un index en raison de la contrainte : unique
CREATE INDEX visitor_index ON visitor (id, name);
CREATE INDEX product_index ON product (id, label);
CREATE INDEX invoice_index ON invoice (id);
CREATE INDEX invoice_line_index ON invoice_line (invoice_id, product_id);


COMMIT;

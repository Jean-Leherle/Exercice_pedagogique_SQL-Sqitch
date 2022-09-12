-- Deploy ofact:sales to pg

BEGIN;

-- XXX Add DDLs here.
CREATE OR REPLACE FUNCTION sales_by_date ("start" timestamptz, "end" timestamptz)
returns SETOF (date date, nb_invoices INT, total numeric )

--générer une table quotidienne avec generate series couvrant de la date de debut à la date de fin
--avec un group by date faire le count des facture et la sommes des totaux de invoice_recap 
--avec comme condition d'etre dans la journée
--mettre en forme et renvoyer.
COMMIT;

SELECT * FROM  generate_series('2022-08-28'::timestamptz, '2022-08-30', '24 hours"' );

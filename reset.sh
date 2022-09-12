cd ~/Bureau/html/Flamel/data/atelier/Data-ofact-jean-leherle/migration;
sqitch revert -y;
sqitch deploy 01-init;
cd ../data ;
psql -U spedata -d ofact -f seeding_v1.sql;
cd ../migration;
sqitch deploy invoice_recap;

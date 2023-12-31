#!/bin/sh

mysql --host=127.0.0.1 --port=3306 --user=root --password=MjU0NjAtcG9sb2Nr -e \
"USE sales; SELECT * FROM sales_data WHERE timestamp >= NOW() - INTERVAL 4 HOUR"\
 --batch --raw > /home/project/sales.csv

echo "Data dumped from MySQL.."

psql --username=postgres --host=localhost --dbname=sales_new -c \
"\COPY sales_data(rowid,product_id,customer_id,price,quantity,timestamp) 
\FROM '/home/project/sales.csv' DELIMITER E'\t' CSV HEADER;"

echo "Data copied to PostgreSQL..."

rm -f /home/project/sales.csv

echo "sales.csv deleted.."

psql --username=postgres --host=localhost --dbname=sales_new -c \
"INSERT INTO dimdate SELECT dateid, EXTRACT(DAY FROM timestamp) AS day, EXTRACT(MONTH FROM timestamp)\
 AS month, EXTRACT(YEAR FROM timestamp) AS year FROM sales_data;"

echo "DimDate load done.."

psql --username=postgres --host=localhost --dbname=sales_new -c \
"INSERT INTO factsales SELECT rowid, product_id, customer_id, price, \
quantity * price AS total_price FROM sales_data;"

echo "factsales load done.."

psql --username=postgres --host=localhost --dbname=sales_new -c\
 "\COPY DimDate TO '/home/project/dimdate.csv' WITH CSV HEADER;"

echo "DimDate CSV dump done.."

psql --username=postgres --host=localhost --dbname=sales_new -c \
"\COPY factsales TO '/home/project/factsales.csv' WITH CSV HEADER;"

echo "factsales CSV dump done.."

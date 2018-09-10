-- Create a new postgres user named `indexed_cars_user`
CREATE user indexed_cars_user

-- Create a new database named `indexed_cars` owned by `indexed_cars_user`
CREATE DATABASE indexed_cars
-- WITH OWNER = indexed_cars_user

-- Run the provided `scripts/car_models.sql` script on the `indexed_cars` database
-- in dbeaver File>Open File then highlight all and execute

-- Run the provided `scripts/car_model_data.sql` script on the `indexed_cars` database **10 times**  
  --  _there should be **223380** rows in `car_models`_
-- same as above but execute 10 times

-- Run a query to get a list of all `make_title` values from the `car_models` table where the `make_code` is `'LAM'`, without any duplicate rows, and note the time somewhere. (should have 1 result)
SELECT DISTINCT make_title FROM car_models WHERE make_code = 'LAM'
-- 30ms 1row Lamborghini

-- Run a query to list all `model_title` values where the `make_code` is `'NISSAN'`, and the `model_code` is `'GT-R'` without any duplicate rows, and note the time somewhere. (should have 1 result) 
SELECT DISTINCT model_title FROM car_models WHERE make_code = 'NISSAN' AND model_code = 'GT-R'
-- 27ms 1row GT-R

-- Run a query to list all `make_code`, `model_code`, `model_title`, and year from `car_models` where the `make_code` is `'LAM'`, and note the time somewhere. (should have 1360 rows) 
SELECT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM' 
-- 28ms(+1ms) 1360rows 

-- Run a query to list all fields from all `car_models` in years between `2010` and `2015`, and note the time somewhere (should have 78840 rows) 
SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015
-- 102ms(+35ms) 78840rows 

-- Run a query to list all fields from all `car_models` in the year of `2010`, and note the time somewhere (should have 13140 rows)
SELECT * FROM car_models WHERE year = 2010
-- 40ms(+6ms) 13140rows 


-- INDEXING

-- Create a query to get a list of all `make_title` values from the `car_models` table where the `make_code` is `'LAM'`, without any duplicate rows, and note the time somewhere. (should have 1 result)
CREATE INDEX listMakeTitle
ON car_models (make_code) WHERE make_code = 'LAM'

SELECT DISTINCT make_title FROM car_models WHERE make_code = 'LAM'
-- 2ms 1row
-- -28ms diff

-- Create a query to list all `model_title` values where the `make_code` is `'NISSAN'`, and the `model_code` is `'GT-R'` without any duplicate rows, and note the time somewhere. (should have 1 result)
CREATE INDEX listModeltitle
ON car_models (make_code) WHERE make_code = 'NISSAN' AND model_code = 'GT-R'
-- 88ms 1row

SELECT DISTINCT model_title FROM car_models WHERE make_code = 'NISSAN' AND model_code = 'GT-R'
-- 1ms 1row
-- -26ms diff

-- Create a query to list all `make_code`, `model_code`, `model_title`, and year from `car_models` where the `make_code` is `'LAM'`, and note the time somewhere. (should have 1360 rows)
CREATE INDEX listMakeCodeModelCodeModelTitleYear
ON car_models (make_code, model_code, model_title, year) WHERE make_code = 'LAM'
-- 89ms 1row

SELECT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM'
-- 2ms 1360rows
-- -26ms diff

-- Create a query to list all fields from all `car_models` in years between `2010` and `2015`, and note the time somewhere (should have 78840 rows)
CREATE INDEX listAllBetween2010And2015
ON car_models (year) WHERE year BETWEEN 2010 AND 2015
-- 225ms 1row

SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015
-- 97ms(+37ms) 78840rows
-- -5ms(+2ms) diff

-- Create a query to list all fields from all `car_models` in the year of `2010`, and note the time somewhere (should have 13140 rows)
CREATE INDEX listAll2010 
ON car_models (year) WHERE year = 2010
-- 92ms 1row

SELECT * FROM car_models WHERE year = 2010
-- 20ms(+10ms) 13140rows
-- -20ms(+4ms) diff

-- Delete the `car_models` table
DROP TABLE car_models
-- 45ms 1row

-- Run the provided `scripts/car_models.sql` script on the `indexed_cars` database
-- in dbeaver File>Open File then highlight and execute
-- 278ms 1row

-- Run the provided `scripts/car_model_data.sql` script on the `indexed_cars` database **10 times**  
  --  _there should be **223380** rows in `car_models`_
-- same as above but execute 10 times
-- 1.67s  1row 22338rows
-- 1.251s 1row 22338rows 48ms(+24ms)   44676rows
-- 1.501s 1row 22338rows 91ms(+44ms)   67014rows
-- 1.190s 1row 22338rows 97ms(+32ms)   89352rows
-- 1.681s 1row 22338rows 110ms(+61ms) 111690rows
-- 1.86s  1row 22338rows 161ms(+85ms) 134028rows
-- 1.609s 1row 22338rows 171ms(+66ms) 156366rows
-- 1.50s  1row 22338rows 174ms(+102ms)178704rows
-- 1.56s  1row 22338rows 230ms(+66ms) 201042rows
-- 1.49s  1row 22338rows 433ms(+71ms) 223380rows

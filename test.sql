-- 1. Creating the tables 
-- 1A Brokers table
CREATE TABLE brokers (id SERIAL PRIMARY KEY, name VARCHAR(50));
-- 1B Customers table
CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  amount INTEGER,
  broker_id INTEGER REFERENCES brokers(id)
);

-- 2. Inserting the data
-- 2A Brokers data
INSERT INTO brokers (name) 
VALUES 
 ('Ted'),
 ('Mark'),
 ('Aaron'),
 ('Luke');
--  2B Customers data
INSERT INTO customers (name, amount, broker_id)
VALUES
  ('sam', 3000, 4),
  ('john', 4000, 2),
  ('mam', 5000, 2),
  ('test', 3000, 3),
  ('june', 2000, 3),
  ('mike', 4000, 1),
  ('annie', 4000, 2),
  ('michael', 2000, 1),
  ('tom', 2000, 4),
  ('jason', 6000, 4);

-- 3 Querying the data for:
-- brokers sorted by high-low customers
-- tie breaker broker name alphebatised
-- Returning as brokername, broker_count
 SELECT
 brokers.name,
 COUNT (broker_id) as broker_occurrence
 FROM customers 
 INNER JOIN
 brokers on brokers.id = customers.broker_id
 GROUP BY broker_id, brokers.name
 ORDER BY 
 broker_occurrence DESC, 
 brokers.name

-- Схема під CSV з dataset/. Кодування файлів — UTF-8, поля в лапках.
-- У Workbench: Server → Data Import, або LOAD DATA після створення таблиць.
-- Якщо LOCAL заборонений: SET GLOBAL local_infile = 1; і клієнт з --local-infile.

CREATE DATABASE IF NOT EXISTS goit_rdb_hw_03
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE goit_rdb_hw_03;

DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS shippers;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
  id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(255) NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE customers (
  id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  contact VARCHAR(100) NULL,
  address VARCHAR(255) NULL,
  city VARCHAR(100) NULL,
  postal_code VARCHAR(20) NULL,
  country VARCHAR(100) NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE employees (
  employee_id INT NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  birthdate DATE NULL,
  photo VARCHAR(100) NULL,
  notes TEXT NULL,
  PRIMARY KEY (employee_id)
) ENGINE=InnoDB;

CREATE TABLE shippers (
  id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(50) NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE suppliers (
  id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  contact VARCHAR(100) NULL,
  address VARCHAR(255) NULL,
  city VARCHAR(100) NULL,
  postal_code VARCHAR(20) NULL,
  country VARCHAR(100) NULL,
  phone VARCHAR(50) NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE products (
  id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  supplier_id INT NULL,
  category_id INT NULL,
  unit VARCHAR(100) NULL,
  price DECIMAL(10, 2) NULL,
  PRIMARY KEY (id),
  KEY idx_products_supplier (supplier_id),
  KEY idx_products_category (category_id),
  CONSTRAINT fk_products_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers (id),
  CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories (id)
) ENGINE=InnoDB;

CREATE TABLE orders (
  id INT NOT NULL,
  customer_id INT NULL,
  employee_id INT NULL,
  date DATETIME NULL,
  shipper_id INT NULL,
  PRIMARY KEY (id),
  KEY idx_orders_customer (customer_id),
  KEY idx_orders_employee (employee_id),
  KEY idx_orders_shipper (shipper_id),
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers (id),
  CONSTRAINT fk_orders_employee FOREIGN KEY (employee_id) REFERENCES employees (employee_id),
  CONSTRAINT fk_orders_shipper FOREIGN KEY (shipper_id) REFERENCES shippers (id)
) ENGINE=InnoDB;

CREATE TABLE order_details (
  id INT NOT NULL,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (id),
  KEY idx_order_details_order (order_id),
  KEY idx_order_details_product (product_id),
  CONSTRAINT fk_order_details_order FOREIGN KEY (order_id) REFERENCES orders (id),
  CONSTRAINT fk_order_details_product FOREIGN KEY (product_id) REFERENCES products (id)
) ENGINE=InnoDB;

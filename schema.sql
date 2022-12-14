CREATE DATABASE taskForce DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
USE taskForce;
CREATE TABLE categories(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name CHAR(64) NOT NULL
    icon VARCHAR (32)
);
CREATE TABLE cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    latitude DECIMAL(11, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL
);
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name CHAR(64) NOT NULL,
    password CHAR(64) NOT NULL,
    email VARCHAR(128) NOT NULL UNIQUE,
    role enum('executor', 'customer') NOT NULL,
    date_registration TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    avatar CHAR(255) NOT NULL,
    birthday DATE,
    phone_number VARCHAR(32),
    telegram VARCHAR(255),
    city_id INT NOT NULL,
    vk VARCHAR(255) UNIQUE
);
CREATE TABLE user_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    category_id INT NOT NULL
);
CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(128) NOT NULL,
    description TEXT DEFAULT NULL,
    file VARCHAR(320) DEFAULT NULL,
    lat FLOAT,
    long FLOAT,
    city_id INT,
    price INT NOT NULL,
    customer_id INT NOT NULL,
    executor_id INT NOT NULL,
    status ENUM (
        'new',
        'cancelled',
        'at_work',
        'done',
        'failed'
    ),
    category_id INT NOT NULL,
    deadline TIMESTAMP,
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content TEXT NOT NULL,
    user_id INT NOT NULL,
    grade INT,
    task_id INT NOT NULL
);
CREATE TABLE responses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    task_id INT NOT NULL,
    executor_id INT NOT NULL,
    content TEXT NOT NULL,
    price INT
);

ALTER TABLE users
ADD FOREIGN KEY (city_id) REFERENCES city (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE user_categories
ADD FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tasks
ADD FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD FOREIGN KEY (executor_id) REFERENCES users (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD FOREIGN KEY (customer_id) REFERENCES users (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD FOREIGN KEY (city_id) REFERENCES city (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE reviews
ADD FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE responses
ADD FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD FOREIGN KEY (executor_id) REFERENCES users (id) ON DELETE RESTRICT ON UPDATE RESTRICT;
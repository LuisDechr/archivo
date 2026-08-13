

CREATE DATABASE IF NOT EXISTS questionBD;

USE questionBD;


DROP TABLE IF EXISTS vote;
DROP TABLE IF EXISTS answer;
DROP TABLE IF EXISTS question;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    lastname VARCHAR(50),
    username VARCHAR(50),
    email VARCHAR(100),
    password VARCHAR(255),
    image VARCHAR(255),
    is_active BOOLEAN,
    is_admin BOOLEAN,
    created_at DATETIME
);


CREATE TABLE category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

CREATE TABLE question (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    description TEXT,
    tags VARCHAR(100),
    user_id INT,
    category_id INT,
    is_solved BOOLEAN,
    created_at DATETIME,

    CONSTRAINT fk_question_user
        FOREIGN KEY (user_id)
        REFERENCES `user`(id),

    CONSTRAINT fk_question_category
        FOREIGN KEY (category_id)
        REFERENCES category(id)
);


CREATE TABLE answer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    description TEXT,
    user_id INT,
    question_id INT,
    is_correct BOOLEAN,
    created_at DATETIME,

    CONSTRAINT fk_answer_user
        FOREIGN KEY (user_id)
        REFERENCES `user`(id),

    CONSTRAINT fk_answer_question
        FOREIGN KEY (question_id)
        REFERENCES question(id)
);

CREATE TABLE vote (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kind_id INT,
    ref_id INT,
    val INT,
    created_at DATETIME,
    user_id INT,

    CONSTRAINT fk_vote_user
        FOREIGN KEY (user_id)
        REFERENCES `user`(id)
);


SHOW TABLES;


DESCRIBE `user`;
DESCRIBE category;
DESCRIBE question;
DESCRIBE answer;
DESCRIBE vote;

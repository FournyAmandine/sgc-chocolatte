drop table if exists menus;
drop table if exists menus_links;
drop table if exists sections;
drop table if exists pages;
drop table if exists employees;
drop table if exists products;
drop table if exists product_categories;
drop table if exists reviews;
drop table if exists messages;


create table menus
(
    id       int auto_increment
        primary key,
    location varchar(15) not null
);

create table menus_links
(
    id    int auto_increment
        primary key,
    links varchar(40) null
);
create table sections
(
    id      int auto_increment
        primary key,
    content json not null
);

create table pages
(
    id int auto_increment
        primary key
);

create table employees
(
    id         int auto_increment
        primary key,
    lastname   varchar(20)  not null,
    firstname  varchar(20)  not null,
    decription varchar(200) not null
        unique,
    image      varchar(20)  null,
    job        varchar(20)  not null
);

create table products
(
    id          int auto_increment
        primary key,
    name        varchar(15)  not null
        unique,
    price       int          not null,
    description varchar(100) not null
        unique,
    promotion   int          null,
    tag         varchar(15)  null
);

create table product_categories
(
    id       int auto_increment
        primary key,
    name     varchar(15) not null,
    products int         null
);

create table reviews
(
    id      int auto_increment
        primary key,
    name    varchar(30) not null,
    content tinytext    not null,
    note    int         not null
);

create table messages
(
    id         int auto_increment
        primary key,
    name       varchar(30)  not null,
    email      varchar(20)  not null,
    message varchar(200) not null
);
































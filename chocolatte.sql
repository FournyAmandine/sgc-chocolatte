drop table if exists menu_page;
drop table if exists sections;
drop table if exists menus;
drop table if exists pages;
DROP TABLE IF EXISTS `employees`;
DROP TABLE IF EXISTS `messages`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `reviews`;
DROP TABLE IF EXISTS `product_categories`;



create table pages
(
    id         int unsigned auto_increment
        primary key,
    template   varchar(255)                        not null,
    slug       varchar(255)                        not null
        unique,
    updated_at timestamp default current_timestamp not null,
    created_at timestamp default current_timestamp not null
);



create table menus
(
    id         int unsigned auto_increment
        primary key,
    location   varchar(255)                        not null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    updated_at timestamp default CURRENT_TIMESTAMP not null,
    title varchar(255) null
);


create table sections
(
    id         int unsigned auto_increment
        primary key,
    page_id    int unsigned                        not null,
    template   varchar(255)                        null,
    content    json                                not null,
    `order`    int unsigned                        not null,
    created_at timestamp default current_timestamp not null,
    updated_at timestamp default current_timestamp not null,
    constraint sections_page_id_pages_id_fk
        foreign key (page_id) references pages (id)
            on delete cascade
);

create table menu_page
(
    id         int auto_increment
        primary key,
    page_id    int unsigned                        not null,
    menu_id    int unsigned                        not null,
    section_id int unsigned                         null,
    label      varchar(255)                        not null,
    title      varchar(255)                        null,
    target     tinyint                             null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    updated_at timestamp default CURRENT_TIMESTAMP not null,
    constraint menu_page_menu_id_menus_id_fk
        foreign key (menu_id) references menus (id)
            on delete cascade,
    constraint menu_page_page_id_pages_id
        foreign key (page_id) references pages (id)
            on delete cascade,
    constraint menu_page_section_id_sections_id
        foreign key (section_id) references sections (id)
            on delete cascade,
    `order` int unsigned not null
);


CREATE TABLE `employees` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `job` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `img` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

CREATE TABLE `product_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int unsigned DEFAULT NULL,
  `order` int unsigned NOT NULL,
  `pre` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_categories_parent_id_product_categories_id` (`parent_id`),
  CONSTRAINT `product_categories_parent_id_product_categories_id` FOREIGN KEY (`parent_id`) REFERENCES `product_categories` (`id`) ON DELETE SET NULL
);

CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_category_id` int unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tag` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `price` int unsigned NOT NULL,
  `discount` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_product_category_id_product_categories_id` (`product_category_id`),
  CONSTRAINT `products_product_category_id_product_categories_id` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`) ON DELETE RESTRICT
);

CREATE TABLE `reviews` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `customer` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `cover_img` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar_img` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_general_ci NOT NULL,
  `rating` int NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `messages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `content` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);



insert into employees (name, job, description, img, created_at)
values ('Victoria', 'Boss', 'Jeune fille motivée avec le sourire', 'victoria.jpeg', sysdate()),
       ('Edyta', 'Manager', 'Personne très serviable et dirigée vers le besoin des gens', 'edyta.jpeg', sysdate()),
       ('Loïc', 'Barista', 'Très compétent, il vous fera de très bon café', 'loic.jpeg',sysdate()),
       ('Charline', 'server', 'Elle vous apportera votre commande avec un grand sourire', 'charline.jpeg', sysdate());

delete from employees;


insert into product_categories(parent_id, `order`, pre, title, created_at)
values (1, 1, 'Délicieux Menu', 'Petit-déjeuner', sysdate()),
       (2, 2, 'Menu préféré', 'Café', sysdate()),
       (3, 3, 'Menu savouré', 'Petit snack', sysdate()),
       (4, 4, 'Menu réconfortant', 'Chocolat Chaud', sysdate());

delete from product_categories;

insert into products(product_category_id, name, description, tag, price, discount, created_at)
values (1, 'Pancakes', 'Délicieux pancakes avec son sirop d‘érable', 'favoris', 12, 0, sysdate()),
       (2, 'Latte Macchiato', 'café avec sa mousse de lait et son sirop au choix', 'recommandé', 5.8, 1.5, sysdate()),
       (3, 'Croque Monsieur', 'Croque monsieur jambon-fromage avec sauce au choix', 'très apprécié', 8, 0, sysdate()),
       (4, 'Chocolat Blanc', 'chocolat chaud avec du chocolat blanc et sa chantilly', 'délicieux', 4.5, 0, sysdate());

delete from products;

insert into reviews(customer, cover_img, avatar_img, content, rating, verified)
values ('Anne-Catherine', 'famille.jpeg', 'moi.jpeg', 'Bar à café très sympa et personnel accueillant', 4, 1),
       ('Laurent', 'hello.jpeg', 'laurent.jpeg', 'Mauvaise ambiance, le bar n‘était pas propre et le café froid', 1, 0),
       ('Louis', 'tracteur.jpeg', 'katia.jpeg', 'On a pris un petit-déjeuner avec ma copine et c‘était bon, seulement le café était trop sucré', 3, 1),
       ('Charly', 'chien.jpeg', 'frimousse.jpeg', 'Endroit sympa, assez spacieux et très bon, les panckes sont exceptionnels', 5, 1);

delete from reviews;

insert into messages(name, email, content)
values ('Samantha', 'samantha.hey@gmail.com', 'J‘ai vécu un bon moment dans votre café et je voulais vous remercier'),
       ('Martin', 'martinbourguignon@gmail.com', 'Je vous envoies ce message pour vous donner ma candidature si jamais vous recrutez'),
       ('Gaspard', 'gaspardbg@hotmail.com', 'J‘aimerais collaborer avec vous pour vos café, c‘est vraiment quelque chose qui me passionne'),
       ('Geneviève', 'bourguijacqu@live.be', 'Vous avez un très beau café, votre personnel est très bien et c‘est très bon, Bravo!');

delete from messages;


INSERT INTO `employees` (`id`, `name`, `job`, `description`, `img`, `created_at`, `updated_at`)
VALUES
	(1,'Victoria','Boss','Elle veille au bon fonctionnement du café.','http://chocolatte.test/images/team/smiley-business-woman-working-cashier.jpg','2024-11-23 11:15:57','2024-11-23 11:15:57'),
	(2,'Edyta','Manager','Elle gère à l\'organisation du café.','http://chocolatte.test/images/team/cute-korean-barista-girl-pouring-coffee-prepare-filter-batch-brew-pour-working-cafe.jpg','2024-11-23 11:18:53','2024-11-23 11:18:53'),
	(3,'Charline','Serveur','Accueillir les clients, prendre les commandes et assurer un service rapide et courtois.','http://chocolatte.test/images/team/small-business-owner-drinking-coffee.jpg','2024-11-23 11:20:05','2024-11-23 11:20:05'),
	(4,'Loïc','Barista','Préparer et servir des cafés, thés et boissons spécialisées avec une présentation soignée.','http://chocolatte.test/images/team/portrait-elegant-old-man-wearing-suit.jpg','2024-11-23 11:20:49','2024-11-23 11:20:49');

INSERT INTO `menus` (`id`, `location`, `created_at`, `updated_at`)
VALUES
	(1,'header','2024-11-23 12:01:33','2024-11-23 12:01:33');


INSERT INTO `messages` (`id`, `name`, `email`, `content`, `created_at`, `updated_at`)
VALUES
	(1,'Jean','Jeanroyen@gmail.com','Bonjour, c\'était pour savoir quand était ouvert le café.','2024-11-23 11:25:24','2024-11-23 11:25:24'),
	(2,'Pierre','Pierreduriz@gmail.com','Bonsoir, j\'aimerais organisé une reunion dans votre café, serait-il possible de m\'envoyer vos tarifs ?','2024-11-23 11:26:33','2024-11-23 11:26:33'),
	(3,'Laura','Lauratoire@gmail.com','J\'ai oublié mon sac, l\'auriez-vous retrouver','2024-11-23 11:27:41','2024-11-23 11:27:41');

INSERT INTO `product_categories` (`id`, `parent_id`, `order`, `pre`, `title`, `created_at`, `updated_at`)
VALUES
	(1,NULL,1,'Menu delicieux','Déjeuner','2024-11-23 11:31:03','2024-11-23 11:31:03'),
	(2,NULL,2,'Menu favori','Boissons','2024-11-23 11:32:23','2024-11-23 11:32:23'),
	(3,1,0,'Commençons par quelques','Toasts','2024-11-29 09:11:54','2024-11-29 09:11:54'),
	(4,1,1,'Et pourquoi pas des','Oeufs','2024-11-29 09:12:14','2024-11-29 09:12:14'),
	(5,1,2,'Gourmandise !','Desserts','2024-11-29 09:12:36','2024-11-29 09:12:36'),
	(6,2,0,'Bien commencer la journée','Café','2024-11-29 09:13:25','2024-11-29 09:13:25'),
	(7,2,1,'Les incontournables','Thés & Tisanes','2024-11-29 09:14:07','2024-11-29 09:14:07'),
	(8,2,2,'Du chocolat!','Chocolats chauds','2024-11-29 09:14:29','2024-11-29 09:14:29');



INSERT INTO `products` (`id`, `product_category_id`, `name`, `description`, `tag`, `price`, `discount`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,5,'Pancake nature','Un pancake est une crêpe épaisse et moelleuse.',NULL,1250,NULL,'2024-11-23 11:35:28','2024-11-23 11:35:28',NULL),
	(2,5,'Gaufre grillée','C\'est une gaufre croustillante à l\'extérieur, moelleuse à l\'intérieur,',NULL,1200,1650,'2024-11-23 11:37:26','2024-11-23 11:37:26',NULL),
	(3,5,'Gateau au chocolat','Dessert moelleux et riche.','Recommander',1800,NULL,'2024-11-23 11:39:10','2024-11-23 11:39:10',NULL),
	(4,5,'Mousse au chocolat','Dessert léger et aérien',NULL,1400,1700,'2024-11-23 11:40:25','2024-11-23 11:40:25',NULL),
	(5,5,'Cake nature','Dessert moelleux',NULL,1400,NULL,'2024-11-23 11:41:09','2024-11-23 11:41:09',NULL),
	(6,6,'Latte','Café fraîchement préparé avec du lait vapeur.','Recommander',1250,NULL,'2024-11-23 11:42:30','2024-11-23 11:42:30',NULL),
	(7,6,'Café blanc','Café infusé et lait vapeur.',NULL,590,NULL,'2024-11-23 11:44:08','2024-11-23 11:44:08',NULL),
	(8,8,'Chocolat chaud classique','Boisson crémeuse et réconfortante.',NULL,550,NULL,'2024-11-23 11:45:23','2024-11-23 11:45:23',NULL),
	(9,7,'Thé vert','Infusion légère et délicate.',NULL,750,NULL,'2024-11-23 11:46:18','2024-11-23 11:46:18',NULL),
	(10,8,'Cappuccino','Mélange d\'espresso, de lait chaud et de mousse de lait.',NULL,650,NULL,'2024-11-23 11:47:51','2024-11-23 11:47:51',NULL);


INSERT INTO `reviews` (`id`, `customer`, `cover_img`, `avatar_img`, `content`, `rating`,`verified`, `created_at`, `updated_at`)
VALUES
	(1,'Sandra','https://img.freepik.com/photos-premium/tasse-cafe-table-fond-marron_192217-787.jpg','http://chocolatte.test/images/reviews/young-woman-with-round-glasses-yellow-sweater.jpg','\"Excellente boisson gourmande !\"\nSi vous aimez le chocolat et le café, vous allez adorer cette boisson. Le goût est riche, la texture est parfaite, et ça vous donne un bon boost.',40,1,'2024-11-23 11:50:29','2024-11-23 11:50:29'),
	(2,'Don','https://img.freepik.com/photos-premium/tasse-cafe-table-fond-marron_192217-787.jpg','http://chocolatte.test/images/reviews/senior-man-white-sweater-eyeglasses.jpg','\"Parfait pour les après-midis\"\nIdéal pour une pause-café, ce chococafé combine bien l\'amertume du café avec la douceur du chocolat, une véritable invitation à la relaxation.',45,0,'2024-11-23 11:50:29','2024-11-23 11:50:29'),
	(3,'Olivia','https://img.freepik.com/photos-premium/tasse-cafe-table-fond-marron_192217-787.jpg','http://chocolatte.test/images/reviews/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair.jpg','\"Trop léger pour un chococafé\"\nJe m\'attendais à quelque chose de plus corsé, mais le goût est un peu trop doux à mon goût. Ce n\'est pas assez caféiné pour moi.',30,1,'2024-11-23 11:50:29','2024-11-23 11:50:29');




select name, job, description, img
from employees
order by name ASC
limit 4;
CREATE DATABASE dating_site_database;

USE dating_site_database;

-- Таблица собирает данные при регистрации пользователя
CREATE TABLE login_details(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id созданного пользователя
	mail varchar(255) NOT NULL, -- e-mail пользователя 
	passwords varchar(255) NOT NULL, -- пароль  пользователя
	name VARCHAR(255) NOT NULL, -- имя пользователя
	date_of_birth DATE NOT NULL, -- дата рождения пользователя
	date_of_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- дата создания пользователя
	date_of_update DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- дата обновления пользователя
	UNIQUE INDEX login_details_mail_ind(mail),
	INDEX login_details_name_ind(name)
);

INSERT INTO login_details (mail, passwords, name, date_of_birth) VALUES ('lexlar@mail.ru', 'lexa1111', 'Алексей', STR_TO_DATE('1993-04-16', '%Y-%m-%d')),
	('fedor98@ya.ru', 'b4df761f3', 'Федор', STR_TO_DATE('1988-08-15', '%Y-%m-%d')),
	('german1114@rambler.ru', '04f4153b2', 'Герман', STR_TO_DATE('1984-06-06', '%Y-%m-%d')),
	('aleksey7693@ya.ru', '603c0cd96', 'Алексей', STR_TO_DATE('1976-01-09', '%Y-%m-%d')),
	('kira1984@gmail.com', 'e0442e709', 'Кира', STR_TO_DATE('1984-06-16', '%Y-%m-%d')),
	('semen1971@outlook.com', '94e1efcee', 'Семен', STR_TO_DATE('1971-06-25', '%Y-%m-%d')),
	('mark1967@yandex.ru', '8c6772d02', 'Марк', STR_TO_DATE('1967-11-04', '%Y-%m-%d')),
	('yakov07021968@rambler.ru', '0c71e366c', 'Яков', STR_TO_DATE('1968-02-07', '%Y-%m-%d')),
	('filipp40@outlook.com', '6325179ca', 'Филипп', STR_TO_DATE('1972-11-09', '%Y-%m-%d')),
	('nastasya9170@rambler.ru', 'e4558a8ef', 'Настасья', STR_TO_DATE('1987-12-03', '%Y-%m-%d')),
	('viktor75@hotmail.com', '0a786d149', 'Виктор', STR_TO_DATE('1980-06-14', '%Y-%m-%d')),
	('marfa28@rambler.ru', '99081b804', 'Марфа', STR_TO_DATE('1995-12-28', '%Y-%m-%d')),
	('danila26@outlook.com', '8fece1407', 'Данила', STR_TO_DATE('1983-08-14', '%Y-%m-%d')),
	('grigoriy93@gmail.com', '85d436782', 'Григорий', STR_TO_DATE('1980-06-26', '%Y-%m-%d')),
	('evgeniy24@mail.ru', 'e62edfd93', 'Евгений', STR_TO_DATE('1994-07-05', '%Y-%m-%d'))
;

SELECT * FROM login_details;

-- Таблица сохранаят загруженные изображения
CREATE TABLE picture(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id изображения мема
	name_picture VARCHAR(255) NOT NULL, -- название картинки
	image_format ENUM('JPEG', 'GIF', 'EPS', 'PNG', 'SVG') NOT NULL -- формат картинки
);

INSERT INTO picture (name_picture, image_format) VALUES ('Удалить из друзей, заблокировать', 'JPEG'),
	('Бильбо Бэггинс с кольцом', 'JPEG'),
	('Кролик Ральф', 'JPEG'),
	('Секции косяка', 'JPEG'),
	('Веселый и грустный Дин Норрис', 'JPEG'),
	('Понасенков гуляет по парку', 'JPEG'),
	('Обезьяны за столом', 'JPEG'),
	('Кокичи 2020', 'JPEG'),
	('Повезло повезло', 'PNG'),
	('We Live In a Society (Мы живем в обществе)', 'JPEG')
;

SELECT * FROM picture;

CREATE TABLE photos(
	id_photo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id фотографии
	name_photo VARCHAR(255) NOT NULL, -- название фото 
	who_posted INT UNSIGNED NOT NULL, -- кто выложил фото 
	image_format ENUM('JPEG', 'EPS', 'PNG', 'SVG') NOT NULL, -- формат фото 
	date_of_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- когда была загружена
	CONSTRAINT fr_photos_who_posted_login_details FOREIGN KEY (who_posted) REFERENCES login_details (id)
);

INSERT INTO photos (name_photo, who_posted, image_format) VALUES ('IMG_20210416_002451.png', 1, 'PNG'),
	('IMG_20201110_123456.png', 3, 'PNG'),
	('IMG_20210101_573085.png', 5, 'PNG'),
	('IMG_20191209_764018.png', 9, 'PNG'),
	('IMG_20181209_679251.png', 10, 'PNG'),
	('IMG_20200827_726201.png', 11, 'PNG'),
	('IMG_20210311_928715.png', 12, 'PNG'),
	('IMG_20200709_894391.png', 13, 'PNG'),
	('IMG_20190401_978421.png', 14, 'PNG'),
	('IMG_20210501_548915.png', 15, 'PNG')
;

SELECT * FROM photos;

-- Таблица сохраняет данные профиля пользователей
CREATE TABLE profiles(
	user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id созданного пользователя 
	surname VARCHAR(255) NULL, -- фамилия пользователя
	patronymic VARCHAR(255) NULL, -- отчество пользователя
	gender ENUM('m', 'f', 't') NULL, -- пол пользователя
	city VARCHAR(255) NULL, -- город пользователя
	country VARCHAR(255) NULL, -- страна пользователя
	photo_id INT UNSIGNED NULL, -- фотография пользователя на главной странице.
	INDEX login_details_surname_ind(surname),
	INDEX login_details_patronymic_ind(patronymic),
	CONSTRAINT fk_profiles_login_details FOREIGN KEY (user_id) REFERENCES login_details (id),
	CONSTRAINT fk_profiles_picture FOREIGN KEY (photo_id) REFERENCES photos (id_photo)
	);

INSERT INTO profiles (surname, patronymic, gender, city, country, photo_id) VALUES ('Ларьков', 'Александрович', 'm', 'Самара', 'Россия', 1);
INSERT INTO profiles (surname, patronymic, gender, city, country) VALUES ('Чадов', 'Лукьевич', 'm', 'Копейск', 'Россия');
INSERT INTO profiles (surname, gender, photo_id) VALUES ('Аспидов', 'm', 2);
INSERT INTO profiles (surname) VALUES ('Петрищев');
INSERT INTO profiles (surname, patronymic, gender, city, country, photo_id) VALUES ('Драчёва', 'Марковна', 'f', 'Новый Уренгой,', 'Россия', 3);
INSERT INTO profiles (surname, patronymic, gender, city, country) VALUES ('Водянов', 'Ираклиевич', 'm', 'Миасс', 'Россия');
INSERT INTO profiles (surname, patronymic, gender) VALUES ('Климушин', 'Трофимович', 'm');
INSERT INTO profiles (surname, patronymic) VALUES ('Родионов', 'Александрович');
INSERT INTO profiles (surname, patronymic, gender, city, country, photo_id) VALUES ('Яндарбиев', 'Юрьевич', 'm', 'Нефтекамск', 'Россия', 4);
INSERT INTO profiles (surname, patronymic, gender, city, country, photo_id) VALUES ('Преображенская', 'Филипповна', 'f', 'Сочи', 'Россия', 5);
INSERT INTO profiles (surname, gender, city, country, photo_id) VALUES ('Гольдин', 'm', 'Волгоград', 'Россия', 6); -- !!!!!!!!!!!
INSERT INTO profiles (surname, patronymic, gender, city, country, photo_id) VALUES ('Гершковича', 'Аркадьевна', 'f', 'Тамбов', 'Россия', 7);
INSERT INTO profiles (surname, patronymic, gender, city, country, photo_id) VALUES ('Родиков', 'Тимофеевич', 'm', 'Домодедово', 'Россия', 8);
INSERT INTO profiles (surname, patronymic, gender, city, country, photo_id) VALUES ('Фоменков', 'Юлианович', 'm', 'Санкт-Петербург', 'Россия', 9);
INSERT INTO profiles (gender, photo_id) VALUES ('t', 10);

SELECT * FROM profiles;

-- Таблица сохраняет данные мемов
CREATE TABLE memes(
	id_memes INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id мема
	id_picture INT UNSIGNED NOT NULL, -- id изображения из какого сделан мем
	type_meme ENUM('абстрактные', 'с животными', 'исторические', 'демотиваторы', 'классические', 'мертвые', 'современные', 'эпичные фразы', 'фотожаба', 'локальные', 'музыкальные') NOT NULL, -- тип мема
	meme_structure ENUM('двусоставной ', 'персонажный', 'синтаксический ', 'ситуативный ', 'компаративный ') NOT NULL, -- структура мема
	CONSTRAINT fk_memes_picture FOREIGN KEY (id_picture) REFERENCES picture (id)
);

INSERT INTO memes (id_picture, type_meme, meme_structure) VALUES (1, 'абстрактные', 'персонажный'),
	(10, 'мертвые', 'компаративный'),
	(2, 'демотиваторы', 'персонажный'),
	(5, 'современные', 'двусоставной'),
	(2, 'эпичные фразы', 'компаративный'),
	(1, 'музыкальные', 'двусоставной'),
	(3, 'исторические', 'ситуативный'),
	(9, 'классические', 'компаративный'),
	(10, 'локальные', 'ситуативный'),
	(8, 'эпичные фразы', 'персонажный'),
	(2, 'с животными', 'синтаксический'),
	(1, 'фотожаба', 'ситуативный'),
	(8, 'с животными', 'компаративный'),
	(2, 'абстрактные', 'компаративный'),
	(5, 'музыкальные', 'компаративный'),
	(6, 'современные', 'компаративный'),
	(5, 'локальные', 'ситуативный'),
	(4, 'абстрактные', 'компаративный'),
	(8, 'локальные', 'персонажный'),
	(4, 'мертвые', 'синтаксический');
	
SELECT * FROM memes;

-- Таблица сохраняет оценки мемов пользователей
CREATE TABLE rating_memes (
	user_id INT UNSIGNED NOT NULL, -- id пользователя
	id_memes INT UNSIGNED NOT NULL, -- id мема
	ratings_meme ENUM('понравился', 'не понравился', 'жалоба') NOT NULL,
	evaluation_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (user_id, id_memes, ratings_meme), -- делаем связь 1 ко много
	CONSTRAINT fk_rating_memes_login_details FOREIGN KEY (user_id) REFERENCES login_details (id),
	CONSTRAINT fk_rating_memes_memes FOREIGN KEY (id_memes) REFERENCES memes (id_memes)  
);

INSERT INTO rating_memes (user_id, id_memes, ratings_meme) VALUES (12, 18, 'не понравился'),	(9, 1, 'жалоба'),	(6, 13, 'понравился'),	(12, 17, 'понравился'),	(6, 11, 'жалоба'),	
	(1, 10, 'не понравился'),	(12, 19, 'жалоба'), (15, 10, 'понравился'),	(12, 14, 'не понравился'), (11, 16, 'не понравился'),	(10, 5, 'не понравился'),	(4, 18, 'жалоба'),	
	(13, 17, 'понравился'),	(6, 4, 'понравился'),	(6, 3, 'не понравился'),	(2, 12, 'жалоба'),	(5, 7, 'понравился'),	(5, 16, 'понравился'),	(10, 18, 'не понравился'),	
	(3, 10, 'не понравился'),	(15, 19, 'не понравился'),	(4, 10, 'жалоба'),	(9, 16, 'не понравился'),	(10, 10, 'жалоба'),	(2, 9, 'не понравился'),	(9, 18, 'жалоба'),	
	(10, 12, 'не понравился'),	(4, 13, 'понравился'),	(13, 20, 'не понравился'),	(1, 1, 'не понравился'),	(2, 13, 'жалоба'),	(1, 7, 'понравился'),	(3, 3, 'не понравился'),	
	(8, 13, 'не понравился'),	(14, 13, 'жалоба'),	(2, 20, 'не понравился'),	(7, 5, 'не понравился'),	(9, 14, 'не понравился'),	(3, 5, 'жалоба'),	(11, 6, 'жалоба'),	
	(13, 12, 'понравился'),	(15, 1, 'понравился'),	(7, 7, 'жалоба'),	(5, 8, 'понравился'),	(5, 12, 'не понравился'),	(13, 4, 'не понравился'),	(11, 13, 'жалоба'),	
	(13, 1, 'понравился'),	(5, 2, 'понравился'),	(11, 4, 'понравился'),	(8, 16, 'понравился'),	(10, 17, 'жалоба'),	(3, 11, 'не понравился'),	(2, 14, 'жалоба'),	
	(13, 10, 'не понравился'),	(4, 1, 'не понравился'),	(15, 17, 'жалоба'),	(7, 17, 'понравился'),	(3, 19, 'жалоба'),	(8, 20, 'жалоба'),	(13, 8, 'не понравился'),	
	(11, 11, 'понравился'),	(2, 17, 'жалоба');

SELECT * FROM rating_memes;

CALL dating_site_database.identifying_users_with_the_same_ratings(1); -- создал процедуру которая определяет схожие какие пользователи дали схожие оценки мемам и их колличество
/*
DROP PROCEDURE IF EXISTS dating_site_database.identifying_users_with_the_same_ratings;

DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `dating_site_database`.`identifying_users_with_the_same_ratings`(number_user INT)
BEGIN
	SELECT rm3.user_id AS 'Пользователи с аналогичной оценкой', count(*)
	FROM rating_memes rm1
		JOIN rating_memes rm2 ON rm1.id_memes = rm2.id_memes AND rm1.ratings_meme = rm2.ratings_meme AND rm1.user_id = rm2.user_id  AND rm1.user_id = number_user
		JOIN rating_memes rm3 ON rm3.id_memes = rm1.id_memes AND rm3.ratings_meme  = rm1.ratings_meme AND rm3.user_id != number_user
	GROUP BY rm3.user_id
END$$
DELIMITER ;
*/

-- Таблица сохраняет результаты какие пользователи были предложены друг другу.
CREATE TABLE results_offers(
	from_offered INT UNSIGNED NOT NULL, -- кому предложен
	to_offered INT UNSIGNED NOT NULL, -- кто предложен
	offer_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (from_offered, to_offered), 
	CONSTRAINT fk_results_offers_from_offered FOREIGN KEY (from_offered) REFERENCES login_details (id),
	CONSTRAINT fk_results_offers_to_offered FOREIGN KEY (to_offered) REFERENCES login_details (id)
);  

INSERT INTO results_offers(from_offered, to_offered) VALUES (1, 4), (2, 11), (3, 6), (4, 1), (5, 1), (6, 3), (7, 10), (8, 5), (9, 11), (10, 12), (11, 14), (12, 3), (13, 2), (14, 11), 
(15, 10); -- Так получилось что каждый пользователь если имеет несколько пользователей с одинаковой оценкой то этих оценок всего по одной. Поэтому случайно добавляем любого пользователя.


SELECT * FROM results_offers;

-- Таблица сохраняет сообщения пользователей
CREATE TABLE messages(
	id_messeg INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id сообщений
	from_user INT UNSIGNED NOT NULL, -- кто отправил
	txt Text NOT NULL, -- текст сообщений
	message_created DATETIME NOT NULL DEFAULT current_timestamp, -- когда было отправлено
	to_user INT UNSIGNED NOT NULL, -- кому было отправлено
	is_delivered boolean DEFAULT FALSE, -- прочитано или нет
	INDEX login_details_from_user_ind(from_user),
	INDEX login_details_to_user_ind(to_user),
	CONSTRAINT fk_messages_from_user FOREIGN KEY (from_user) REFERENCES login_details (id),
	CONSTRAINT fk_messages_to_user FOREIGN KEY (to_user) REFERENCES login_details (id)
);

INSERT INTO messages (from_user, txt, to_user, is_delivered) VALUES 
	(1, 'привет !!', 4, True), (1, 'как дела ??', 4, False), (2, 'Здарова. Для чего ты тут ??', 11, False), (3, 'Привет', 6, False), (4, 'Все ок у тебя ???', 1, False),
	(1, 'Привет', 5, True), (5, 'Привет', 1, True), (6, 'Привет', 5, True), (7, 'Привет', 10, True), (10, 'Привет', 7, True), (8, 'Привет!! Как дела ? чем в жизни занимаешься?', 7, True),
	(9, 'Привет', 7, True), (1, 'То же норм. Как тебе мемы тут ?', 4, True), (10, 'привет !!', 12, True), (11, 'Привет срочно заходи на сайт и выигрывай призы http:c1tyh.com', 14, True),
	(11, 'Привет срочно заходи на сайт и выигрывай призы http:c1tyh.com', 2, True), (12, 'Добрый вечер', 3, True), (12, 'Добрый вечер', 10, True), (3, 'САЛАМ', 12, True), (13, 'Здарова', 2, True),
	(14, 'Добрый вечер', 11, True), (15, 'Заходи на сайт Joycasino.com и вводи промокод SLOTY30 !!!', 10, True), (10, 'надеюсь ты не бот а то тут меня уже в казино зовут играть', 7, True);
	
SELECT * FROM messages;

-- Делаю запрос на создание таблицы в котором будет показываться полное ФИО и id.
SELECT ld1.id AS ID, 
	IF(CONCAT(ld1.name, ' ', pr1.surname, ' ', pr1.patronymic), ld1.name, CONCAT(ld1.name, ' ', pr1.surname, ' ', pr1.patronymic)) AS full_name -- не получается сделать так что если значение concat null то значение имени выдается если не null то полное ФИО
FROM login_details ld1
	JOIN profiles pr1 ON ld1.id = pr1.user_id 
GROUP BY ID;

-- Делаем представление на определение посетителя кто больше всех оценил мемов.
CREATE VIEW most_of_all_we_will_rate_memes as
SELECT user_id, count(*) 
FROM rating_memes rm 
GROUP BY user_id
ORDER BY count(*) DESC
LIMIT 1;

-- Представление какие типы мемов нравяться тому или иному пользователю
CREATE VIEW representation_of_meme_types_by_user AS 
SELECT ld1.name , me1.type_meme , me1.meme_structure, rm1.ratings_meme
FROM rating_memes rm1
	JOIN memes me1 ON rm1.id_memes = me1.id_memes
	JOIN login_details ld1 ON rm1.user_id = ld1.id 
ORDER BY rm1.user_id;

SELECT * FROM representation_of_meme_types_by_user;
SELECT * FROM most_of_all_we_will_rate_memes;

SELECT * FROM rating_memes;

-- Процедура определяет какой мем больше понравился не понравился или жалоб 
/*
-- SET @numbers = 1; Почемуто limit не принимает переменную
DROP PROCEDURE IF EXISTS dating_site_database.meme_statistics;

DELIMITER $$
$$
CREATE PROCEDURE dating_site_database.meme_statistics(name_rating varchar(255))
BEGIN
	SELECT id_memes, ratings_meme, count(*) 
	FROM rating_memes rm1 WHERE ratings_meme = name_rating
	GROUP BY id_memes 
	ORDER BY count(*) DESC 
	LIMIT 1
END$$
DELIMITER ;
;
*/
CALL meme_statistics('жалоба') ;

DELIMITER $$
$$
CREATE TRIGGER age_verification BEFORE INSERT ON login_details -- Тригер проверяет возраст при регистрации.
FOR EACH ROW 
BEGIN 
	IF (TIMESTAMPDIFF(YEAR, NEW.date_of_birth, NOW()) < 16) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Возраст не подходит для регистрации';
	END IF;
END $$
DELIMITER ;

-- Тригер проверяет можноли написать другому пользователю

SELECT * FROM results_offers;

DELIMITER $$
$$
CREATE TRIGGER age_verification BEFORE INSERT ON messages
FOR EACH ROW 
BEGIN 
	IF (NEW.to_offered != (SELECT to_offered FROM results_offers WHERE from_offered = NEW.from_offered;) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Вы не можете писать этому пользователю.';
	END IF;
END $$
DELIMITER ;

-- Соотвественно через DBeaver почемуто отдельно триггеры нельзя создать к этой бд и так у меня не создается















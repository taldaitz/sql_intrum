/*Requetes initiales */

CREATE DATABASE formationSql; 

SHOW DATABASES;

USE formationSql;

SHOW TABLES;


/* Création de tables */

CREATE TABLE Produit (
	ref_prod int auto_increment unique,
    nom_prod varchar(255) NOT NULL,
    prix_prod double NOT NULL DEFAULT 0,
    categ_prod varchar(255) NOT NULL,
    stock_prod smallint NOT NULL,
    desc_prod text,
    PRIMARY KEY(ref_prod)
);

DESCRIBE Produit;

CREATE table Categorie (
	ref_categ int auto_increment,
    libelle_categ varchar(100),
    primary key(ref_categ)
);


CREATE table Client (
	ref_client int auto_increment,
    nom_client varchar(100) NOT NULL,
    prenom_client varchar(100) NOT NULL,
    tel_client varchar(25) NOT NULL,
    email_client varchar(255) NOT NULL UNIQUE,
    entreprise_client varchar(255),
    primary key(ref_client)
);


CREATE table Entreprise (
	ref_ent int auto_increment,
    nom_ent varchar(100) NOT NULL,
    adresse1_ent varchar(100) NOT NULL,
    adresse2_ent varchar(100) NOT NULL,
    cp_ent varchar(10) NOT NULL,
    ville_ent varchar(50) NOT NULL,
    primary key(ref_ent)
);

/*
Modification de tables
*/

ALTER TABLE Produit
	ADD COLUMN desc_prod text;
    
DESCRIBE Produit;

alter table Client
	modify tel_client varchar(25) NOT NULL;
    
DESCRIBE Client;

ALTER TABLE entreprise
	DROP COLUMN adresse3_ent;
    
DESCRIBE entreprise;


/*
Insertion de tables
*/

DESCRIBE Contact;

INSERT INTO Contact (email)
VALUES ('test@gmail.com');

INSERT INTO Contact (prenom, nom, email)
VALUES ('Thomas', 'Aldaitz', 'taldaitz@gmail.com');

INSERT INTO Contact (email, prenom)
VALUES ('Robert', 'robert@gmail.com');

INSERT INTO entreprise (nom_ent, adresse1_ent, adresse2_ent, cp_ent,ville_ent)
VALUES ('Dawan', '12 rue du test', '',  '69006', 'Lyon'), 
		('Intrum', '14 rue du test', '', '69800', 'Saint-Priest'),
        ('Apple', '15 rue du test', '',  '75002', 'Paris'), 
		('Google', '23 rue du test', '', '75013', 'Paris')
        ;
        
INSERT INTO categorie (libelle_categ)
Values 
('Vetements'),
('Chaussures'),
('Accessoires')
;


/*
Modification de lignes
*/


UPDATE Entreprise
SET adresse1_ent = '62 rue de Bonnel'
WHERE ref_ent = 1;

UPDATE Entreprise
SET CP_ent = '55456', ville_ent = 'Rouen'
WHERE nom_ent = 'Google';

UPDATE Produit
SET desc_prod = 'Pas de description';

UPDATE Produit
SET prix_prod = prix_prod * 2
WHERE categ_prod = "Chaussures";

/*
 Select
*/

USE FormationSql;

SHOW TABLES;

SELECT * FROM Client;

SELECT tel_client AS Téléphone, prenom_client AS Prénom, nom_client AS Nom
FROM Client;


SELECT * 
FROM Client
WHERE entreprise_client = 'Google';

SELECT tel_client
FROM Client
WHERE tel_client between 5 AND 90;



SELECT * 
FROM Client
ORDER BY nom_client, prenom_client;



SELECT * 
FROM Client
LIMIT 10;


SELECT *
FROM Client
WHERE nom_client LIKE 'A%';

SELECT * 
FROM Produit
ORDER BY prix_prod DESC
LIMIT 10;


SELECT entreprise_client, nom_client, prenom_client
FROM Client
ORDER BY entreprise_client, nom_client, prenom_client;


SELECT *, stock_prod * prix_prod AS Valorisation
FROM Produit
WHERE stock_prod >= 50
AND stock_prod <= 150
;


SELECT *, stock_prod * prix_prod AS Valorisation
FROM Produit
WHERE stock_prod >= 50
AND stock_prod <= 150
ORDER BY Valorisation DESC
LIMIT 3
;



SELECT *
FROM Client
WHERE (entreprise_client = 'Intrum'
	OR entreprise_client = 'Dawan' )
	AND email_client LIKE '%co.uk'
;

SELECT *
FROM Client
WHERE entreprise_client in ('Intrum', 'Dawan')
AND email_client LIKE '%co.uk'
;



SELECT count(*)
FROM Produit
WHERE prix_prod > 50;

SELECT count(*)
FROM Client
WHERE entreprise_client = 'Google';

SELECT entreprise_client, count(*)
FROM Client
GROUP BY entreprise_client;



SELECT categ_prod, SUM(prix_prod * stock_prod) AS Cumul_Valorisation
FROM Produit
GROUP BY categ_prod
;



SELECT avg(prix_prod), Count(*), SUM(prix_prod), Max(prix_prod)
FROM Produit
WHERE stock_prod < 80
;



SELECT categ_prod, count(prix_prod)
FROM Produit
WHERE prix_prod < 20
GROUP BY categ_prod
;



SELECT nom_client, count(*)
FROM Client
GROUP BY nom_client
HAVING count(*) > 1
ORDER BY nom_client
;


/*
Nouvelle Base avec Contraintes
*/



DROP TABLE Payment;
DROP TABLE Bill;
DROP TABLE Customer;


CREATE TABLE Customer (
        Id int auto_increment unique primary key,
    Lastname varchar(255) NOT NULL,
    Firstname varchar (255) NOT NULL,
    email varchar(255) NOT NULL,
    IsVip smallint NOT NULL
    )ENGINE =InnoDB
    ;
    
    
    
create table Bill(
id int auto_increment primary key,
ref varchar(50) not null unique,
date date,
total_amount double Not null,
customer_id int Not NULL
) ENGINE =InnoDB 
;
    

    create table Payment (
ID int auto_increment unique primary key ,
Date date not null,
Amount double not null,
Status varchar(50) not null,
bill_id int not null
)engine= InnoDB;


ALTER TABLE Bill
	ADD CONSTRAINT FK_Bill_Customer
    FOREIGN KEY Bill(customer_id)
    REFERENCES Customer(id);
    
ALTER TABLE Payment
ADD CONSTRAINT FK_Bill_Payment
FOREIGN KEY Payment(bill_id)
REFERENCES Bill(id);


INSERT INTO `customer` (`Lastname`,`Firstname`,`email`,`isVip`) VALUES ("Mcclure","Ignatius","Proin.non@sedconsequatauctor.ca",1),("Murray","Tanya","venenatis.vel@sedsem.net",0),("Levy","Guinevere","nascetur@Morbinonsapien.com",0),("Oneil","Charde","congue.a.aliquet@sociis.org",0),("Sawyer","Fitzgerald","arcu@arcueu.net",1),("Sanford","Axel","elementum.dui@eleifendnondapibus.com",0),("Valenzuela","Sade","eleifend.nec.malesuada@Etiamgravidamolestie.edu",1),("Bentley","Isadora","lectus@ametultricies.org",0),("Boone","Judith","orci.lobortis.augue@diam.co.uk",1),("Thompson","Plato","Phasellus.at@Cumsociisnatoque.ca",1);
INSERT INTO `customer` (`Lastname`,`Firstname`,`email`,`isVip`) VALUES ("Lawson","Barrett","lorem.fringilla.ornare@euismodestarcu.org",0),("Mendez","Finn","porta@sempertellusid.org",0),("Crosby","Minerva","lorem@Donec.org",1),("Kirkland","Blake","Nunc@vitae.com",0),("Wallace","Gisela","aliquam.enim.nec@convallis.ca",0),("Alford","Graiden","commodo.tincidunt.nibh@hendrerit.co.uk",1),("Monroe","Sarah","Class.aptent.taciti@aliquetdiam.org",0),("Salas","Gabriel","semper@necante.com",1),("Hale","Sybill","Vivamus@Classaptenttaciti.ca",1),("Blevins","Ferdinand","vitae@lobortisquam.co.uk",1);
INSERT INTO `customer` (`Lastname`,`Firstname`,`email`,`isVip`) VALUES ("Foreman","Eve","vehicula.Pellentesque@miacmattis.co.uk",0),("Wyatt","Rashad","a.purus.Duis@vulputateullamcorpermagna.com",1),("Workman","George","id.sapien.Cras@Suspendissetristique.net",0),("Bryant","Rosalyn","sociis@Vivamusrhoncus.ca",1),("Burnett","Hunter","sit@eunullaat.co.uk",0),("Dennis","Kaye","mauris@Cumsociis.org",1),("Cardenas","Cole","Etiam.bibendum.fermentum@Etiamimperdiet.co.uk",0),("Gamble","Shaeleigh","est.ac.mattis@etmagna.co.uk",0),("Douglas","Dennis","iaculis.aliquet@Suspendisse.org",0),("Daniel","Lunea","facilisis.magna@metus.co.uk",1);
INSERT INTO `customer` (`Lastname`,`Firstname`,`email`,`isVip`) VALUES ("Kennedy","Hyacinth","malesuada.ut.sem@posuereenimnisl.org",1),("Diaz","Tyrone","sed.pede@dolordapibus.org",1),("Howard","Hayfa","nascetur.ridiculus.mus@placeratvelit.net",1),("Bryan","Matthew","pede.ultrices@Nuncmauris.ca",0),("Wyatt","Blaine","quis.lectus@leoMorbi.org",0),("Atkins","Aretha","sociis@augue.ca",1),("Evans","Vanna","iaculis.aliquet.diam@ad.co.uk",0),("Kirby","Carissa","dolor.vitae@penatibusetmagnis.edu",1),("Oliver","Kenyon","consequat.nec.mollis@scelerisque.org",1),("Thompson","Meredith","habitant.morbi.tristique@tempus.co.uk",1);
INSERT INTO `customer` (`Lastname`,`Firstname`,`email`,`isVip`) VALUES ("Ferguson","Alexis","tellus@aptenttaciti.co.uk",1),("Ochoa","Ferdinand","cursus.et@Etiambibendum.edu",0),("Harding","Katell","montes.nascetur@pharetrased.net",0),("Baird","Merritt","ligula@luctus.co.uk",1),("Mcmillan","Hasad","dis@inhendrerit.org",0),("Lynch","Lewis","dolor.Quisque.tincidunt@etmagnisdis.org",1),("Yates","Hermione","blandit@In.com",1),("Alvarado","Harding","orci.quis@at.co.uk",0),("Deleon","Nigel","at@DuisgravidaPraesent.net",0),("Moran","Latifah","tincidunt.pede.ac@consectetuer.org",0);
INSERT INTO `customer` (`Lastname`,`Firstname`,`email`,`isVip`) VALUES ("Blake","Ifeoma","Nam.consequat@tellusSuspendisse.com",1),("Cotton","Rajah","Fusce@tellussemmollis.edu",0),("Gallegos","Silas","Sed@imperdieterat.ca",0),("Nguyen","April","ac.mattis.ornare@interdumligulaeu.net",0),("Armstrong","Jacob","egestas@utnullaCras.com",0),("Lee","Patricia","gravida.mauris.ut@enimgravida.ca",0),("Lawson","Daniel","molestie.Sed@Nunc.net",1),("Craft","Maxine","ac.facilisis@Fuscealiquamenim.ca",1),("Rowe","Cailin","taciti.sociosqu@leoVivamusnibh.com",0),("Kirk","Tanek","Suspendisse@lacus.org",0);
INSERT INTO `customer` (`Lastname`,`Firstname`,`email`,`isVip`) VALUES ("Fry","Rose","Cras.eget@commodohendreritDonec.com",1),("Mcdowell","Jolene","ut@vestibulum.net",0),("Flynn","Tad","tellus@rutrummagnaCras.com",0),("Ratliff","Francis","purus.in.molestie@Praesentluctus.ca",1),("Dunlap","Samantha","orci.quis.lectus@ornare.ca",1),("Finch","Darryl","lectus.ante.dictum@dolornonummyac.ca",1),("Colon","Pearl","sed.hendrerit.a@ipsumnonarcu.net",0),("Fleming","Bernard","egestas.nunc@metus.net",1),("Ramos","Brennan","ipsum.primis@nibh.net",0),("Wolfe","Lev","consectetuer.euismod.est@euodioPhasellus.co.uk",1);
INSERT INTO `customer` (`Lastname`,`Firstname`,`email`,`isVip`) VALUES ("Mcclain","Veronica","sem.semper@Quisque.co.uk",0),("Collins","Vivien","enim.sit@metus.com",1),("Caldwell","Hyatt","ultricies.adipiscing.enim@turpis.co.uk",1),("Kerr","Sonya","in@Maurisvel.org",1),("Reid","Larissa","eu.sem@pedeultrices.co.uk",1),("Gaines","Isabelle","nonummy@hendreritid.com",0),("Lott","Anthony","Sed.diam@congue.com",1),("Armstrong","Sade","Nam@Aliquamrutrumlorem.com",1),("Pruitt","Karen","vel.vulputate.eu@Integersemelit.ca",1),("Mcintosh","Sydney","nunc.ullamcorper.eu@Nam.org",0);
INSERT INTO `customer` (`Lastname`,`Firstname`,`email`,`isVip`) VALUES ("Wilkinson","Troy","rutrum.non@rutrumloremac.net",1),("Blankenship","Brady","ut@ametconsectetuer.com",1),("Becker","Ishmael","sollicitudin.a@mauris.net",1),("Mclaughlin","Carissa","Integer.vulputate.risus@ullamcorpervelitin.ca",0),("Marks","Jescie","orci.tincidunt.adipiscing@pede.net",1),("Gallagher","Dawn","consequat.enim.diam@Nam.com",0),("Chaney","Ali","augue.ac.ipsum@elitEtiamlaoreet.ca",1),("Carson","Amery","lectus@risusvarius.co.uk",1),("Berger","Aiko","tristique.ac@ut.com",1),("Watts","Uta","viverra.Maecenas@enimsit.org",1);
INSERT INTO `customer` (`Lastname`,`Firstname`,`email`,`isVip`) VALUES ("Tate","Hu","a@Suspendissetristique.edu",0),("Myers","Hilary","Phasellus@ultrices.com",1),("Guy","Jelani","nec.euismod.in@liberoDonec.net",0),("Olsen","Maisie","at@Donec.co.uk",0),("Livingston","Duncan","ac@Aliquamfringilla.com",1),("Cooley","Jenette","libero.dui@MorbimetusVivamus.co.uk",1),("Fisher","Drake","neque.et.nunc@nonduinec.ca",0),("Delaney","Macaulay","ut@lobortisquama.ca",1),("Carpenter","Graham","quis@luctus.net",1),("Graves","Cairo","varius@Curabiturdictum.org",1);
INSERT INTO `Bill` (`ref`,`date`,`total_amount`,`customer_id`) VALUES ("81968872","2020-03-28 21:56:37",253,37),("92854813","2021-06-22 12:46:38",358,4),("40556177","2020-09-19 19:36:59",339,39),("99019405","2020-02-27 11:54:39",232,82),("26527626","2020-03-01 22:14:24",377,95),("25359935","2020-09-20 02:07:23",122,60),("87376818","2021-10-29 03:04:10",544,42),("44122729","2021-06-03 09:48:28",180,89),("84717081","2021-09-04 10:12:11",417,35),("79768507","2020-07-15 08:09:36",490,96);
INSERT INTO `Bill` (`ref`,`date`,`total_amount`,`customer_id`) VALUES ("50594287","2021-09-08 17:05:50",731,65),("82405709","2020-04-01 17:56:38",31,90),("05983541","2020-10-22 21:16:54",689,98),("70630379","2020-03-03 16:26:10",213,69),("40861336","2020-04-14 07:56:11",106,74),("82729732","2021-02-27 14:06:04",735,22),("35642250","2020-04-22 17:01:16",392,7),("49048528","2021-11-01 22:58:18",444,56),("93029752","2020-01-27 20:02:27",188,18),("85255488","2020-07-30 20:04:21",192,57);
INSERT INTO `Bill` (`ref`,`date`,`total_amount`,`customer_id`) VALUES ("69167819","2021-02-26 22:08:27",161,98),("08073754","2019-12-26 19:31:46",793,73),("03126459","2020-04-29 19:27:16",37,98),("08429476","2021-10-01 05:15:11",301,84),("18721835","2021-02-13 07:44:18",398,9),("63390791","2020-08-29 05:03:47",316,34),("45209956","2020-09-26 23:16:07",291,27),("97154404","2021-05-20 20:51:34",614,62),("47394516","2021-01-29 04:47:55",665,8),("68548877","2021-11-07 00:55:52",715,38);
INSERT INTO `Bill` (`ref`,`date`,`total_amount`,`customer_id`) VALUES ("11907058","2021-03-02 20:34:51",496,55),("64542690","2020-01-27 19:56:34",433,68),("86133419","2020-10-04 12:53:10",626,77),("91038327","2021-05-29 12:20:42",614,76),("11101853","2020-02-09 10:04:31",195,30),("57457261","2021-11-12 22:10:51",105,35),("21389537","2019-12-24 22:51:52",465,84),("28730476","2021-09-19 16:05:35",46,4),("85460342","2021-09-12 19:13:56",730,100),("91058744","2019-12-13 15:22:28",668,14);
INSERT INTO `Bill` (`ref`,`date`,`total_amount`,`customer_id`) VALUES ("97146220","2021-05-02 07:56:46",19,22),("29505147","2020-05-26 06:58:42",589,45),("92784815","2021-04-13 19:47:06",90,87),("60639709","2020-01-16 12:38:25",270,50),("31828448","2021-01-08 19:12:41",667,100),("41303720","2020-10-19 22:16:00",428,22),("45769435","2021-01-10 05:26:18",84,99),("16970055","2020-05-31 16:20:53",688,92),("21785923","2021-07-24 19:25:27",587,66),("58241525","2021-03-25 00:31:40",19,60);
INSERT INTO `Bill` (`ref`,`date`,`total_amount`,`customer_id`) VALUES ("13559257","2020-06-22 18:19:50",65,76),("71307631","2020-07-28 05:43:43",232,53),("40453057","2020-03-20 08:45:55",451,40),("24411881","2021-02-06 10:37:41",300,50),("88157057","2021-07-09 13:55:35",540,82),("80654905","2021-05-24 07:06:15",782,52),("01559028","2021-02-17 07:12:13",518,29),("45446498","2021-11-14 05:41:04",333,28),("04089014","2021-11-19 13:08:58",106,5),("21814187","2019-12-16 02:37:17",347,54);
INSERT INTO `Bill` (`ref`,`date`,`total_amount`,`customer_id`) VALUES ("67187801","2021-03-20 02:47:43",84,68),("36228372","2021-04-24 20:19:03",292,16),("49114578","2021-02-11 02:22:01",473,25),("32595219","2021-03-30 21:28:06",326,96),("85835408","2020-02-03 03:55:48",231,62),("18689419","2021-01-27 04:42:45",309,60),("35831621","2021-04-21 15:23:09",213,42),("54442988","2020-03-11 22:51:59",718,66),("07557469","2021-03-13 15:46:16",77,26),("20691143","2020-09-14 00:35:32",567,50);
INSERT INTO `Bill` (`ref`,`date`,`total_amount`,`customer_id`) VALUES ("04398037","2020-09-02 00:40:08",39,16),("57025763","2021-10-16 09:36:53",88,20),("63261314","2021-11-18 21:57:48",789,23),("38398399","2020-12-01 17:55:59",762,49),("04961944","2021-07-15 23:51:33",64,100),("44178346","2021-02-26 06:10:59",210,11),("87388400","2020-12-23 13:47:39",497,48),("12670631","2021-04-15 10:58:04",192,2),("13731421","2020-11-07 23:44:32",63,10),("20281631","2019-12-30 20:19:59",399,18);
INSERT INTO `Bill` (`ref`,`date`,`total_amount`,`customer_id`) VALUES ("46085400","2020-03-11 06:36:19",430,40),("54826461","2019-12-02 02:31:01",776,82),("51168821","2020-05-01 22:35:23",13,26),("12054934","2021-05-29 18:46:54",553,79),("31627856","2020-09-18 19:47:39",20,8),("06846917","2021-11-09 10:52:42",676,53),("25509031","2021-02-09 01:17:41",350,70),("84299058","2021-10-10 06:44:10",364,92),("20154306","2020-08-12 06:43:08",426,3),("80458905","2020-08-05 15:03:19",546,97);
INSERT INTO `Bill` (`ref`,`date`,`total_amount`,`customer_id`) VALUES ("49852673","2020-09-22 13:21:45",56,85),("08993899","2021-01-23 05:36:31",138,11),("72606340","2020-05-07 13:59:54",679,64),("98636592","2020-01-02 04:18:00",375,47),("03868325","2021-04-12 20:28:32",353,30),("19454884","2020-12-19 04:17:20",286,44),("32234713","2021-02-27 22:57:52",101,62),("89085418","2020-11-21 06:04:29",91,69),("45313404","2020-04-16 21:18:57",628,17),("06038525","2020-03-16 20:54:52",402,52);
INSERT INTO `payment` (`date`,`amount`,`status`,`bill_id`) VALUES ("2021-05-30 05:16:49",106,"ok",59),("2020-09-24 14:56:06",201,"ok",74),("2021-09-11 17:57:06",252,"ok",86),("2021-11-15 20:41:46",61,"ok",50),("2021-06-23 13:23:23",231,"ok",34),("2020-08-30 19:48:01",211,"ok",31),("2020-08-07 00:11:55",237,"ok",53),("2021-03-02 12:21:14",108,"ok",44),("2021-11-18 10:31:44",3,"ok",68),("2021-06-22 14:06:11",292,"ok",24);
INSERT INTO `payment` (`date`,`amount`,`status`,`bill_id`) VALUES ("2021-01-13 10:31:27",157,"ok",18),("2020-02-07 21:20:49",55,"ok",16),("2020-03-09 03:43:47",168,"ok",11),("2020-05-20 05:34:17",121,"ok",35),("2021-11-01 19:04:12",194,"ok",26),("2021-04-06 09:26:12",180,"ok",15),("2020-10-19 20:59:28",163,"ok",10),("2020-08-21 15:37:27",27,"ok",96),("2021-01-20 15:56:33",18,"ok",40),("2020-02-04 10:55:53",285,"ok",11);
INSERT INTO `payment` (`date`,`amount`,`status`,`bill_id`) VALUES ("2021-09-26 07:41:02",77,"ok",67),("2020-10-24 10:57:02",140,"ok",4),("2021-04-22 17:50:44",17,"ok",80),("2020-06-25 07:53:39",38,"ok",72),("2020-09-02 23:16:05",259,"ok",84),("2021-01-10 19:32:29",59,"ok",81),("2020-08-01 04:13:54",139,"ok",70),("2021-07-29 08:29:06",58,"ok",54),("2020-05-30 14:13:16",47,"ok",97),("2021-02-02 04:53:56",17,"ok",74);
INSERT INTO `payment` (`date`,`amount`,`status`,`bill_id`) VALUES ("2020-07-30 19:26:47",243,"ok",17),("2021-10-16 05:06:55",267,"ok",45),("2020-08-06 13:22:11",100,"ok",86),("2020-02-12 03:58:25",134,"ok",70),("2020-08-28 20:02:08",11,"ok",76),("2020-03-19 20:26:08",235,"ok",12),("2020-01-09 16:12:13",246,"ok",68),("2020-07-10 01:40:47",60,"ok",99),("2020-02-06 19:16:25",289,"ok",62),("2020-01-12 21:31:45",54,"ok",24);
INSERT INTO `payment` (`date`,`amount`,`status`,`bill_id`) VALUES ("2020-09-28 20:26:22",280,"ok",95),("2020-06-21 22:09:10",297,"ok",31),("2021-08-28 02:14:31",201,"ok",100),("2020-09-22 02:34:23",182,"ok",53),("2021-10-30 05:05:47",225,"ok",32),("2021-06-03 09:51:41",1,"ok",7),("2021-07-25 13:17:11",178,"ok",81),("2020-12-09 18:23:18",119,"ok",26),("2020-02-01 16:48:36",29,"ok",71),("2021-06-07 05:31:40",114,"ok",30);
INSERT INTO `payment` (`date`,`amount`,`status`,`bill_id`) VALUES ("2020-07-11 04:38:41",196,"ok",42),("2021-07-08 06:24:16",209,"ok",84),("2021-07-29 22:22:31",146,"ok",32),("2020-05-05 13:12:44",171,"ok",24),("2020-06-21 10:30:09",37,"ok",93),("2020-08-20 05:01:08",215,"ok",56),("2021-01-04 15:27:31",10,"ok",90),("2020-02-01 06:21:29",243,"ok",11),("2020-02-12 07:15:43",234,"ok",29),("2020-03-26 03:54:06",50,"ok",67);
INSERT INTO `payment` (`date`,`amount`,`status`,`bill_id`) VALUES ("2021-10-31 09:22:53",40,"ok",32),("2021-11-15 07:50:15",42,"ok",62),("2021-06-28 10:03:57",292,"ok",91),("2021-05-31 04:22:40",214,"ok",68),("2021-06-25 14:35:24",154,"ok",21),("2020-02-06 05:49:12",210,"ok",20),("2020-05-30 23:24:27",106,"ok",84),("2021-07-02 19:31:37",199,"ok",9),("2020-12-24 01:29:42",100,"ok",40),("2021-04-26 20:11:20",236,"ok",47);
INSERT INTO `payment` (`date`,`amount`,`status`,`bill_id`) VALUES ("2021-07-17 23:48:00",189,"ok",89),("2020-11-07 19:45:19",179,"ok",95),("2021-08-29 15:18:40",206,"ok",88),("2020-01-13 22:15:18",46,"ok",35),("2021-02-12 17:53:13",73,"ok",62),("2020-02-29 10:03:31",185,"ok",24),("2021-04-12 09:08:48",280,"ok",92),("2021-02-07 23:22:49",264,"ok",52),("2019-11-30 16:08:52",77,"ok",68),("2020-01-22 22:57:57",244,"ok",64);
INSERT INTO `payment` (`date`,`amount`,`status`,`bill_id`) VALUES ("2020-04-30 08:44:55",40,"ok",27),("2020-06-06 10:53:55",287,"ok",12),("2021-04-24 03:44:18",26,"ok",54),("2020-01-06 17:53:09",202,"ok",55),("2020-07-15 21:46:22",223,"ok",38),("2020-10-29 14:29:18",96,"ok",52),("2021-01-12 19:30:17",131,"ok",82),("2020-04-09 23:48:23",64,"ok",93),("2021-04-09 23:27:01",281,"ok",33),("2021-03-21 11:26:44",276,"ok",72);
INSERT INTO `payment` (`date`,`amount`,`status`,`bill_id`) VALUES ("2020-09-13 13:10:06",216,"ok",73),("2021-08-15 22:11:33",282,"ok",33),("2020-09-15 23:15:18",106,"ok",58),("2021-06-30 13:13:29",264,"ok",64),("2021-09-03 23:45:57",101,"ok",32),("2021-07-13 00:30:02",61,"ok",3),("2021-02-24 16:30:31",158,"ok",29),("2020-03-02 18:26:03",245,"ok",2),("2020-06-18 03:00:09",82,"ok",47),("2020-07-21 23:05:46",2,"ok",91);


SELECT * FROM Customer;
SELECT * FROM Bill;
SELECT * FROM Payment;


SELECT c.lastname, c.firstname, SUM(amount)
FROM customer c LEFT JOIN bill b ON b.customer_id = c.id
				LEFT JOIN payment p ON b.id = p.bill_id
group by c.id, 1, 2
order by c.lastname;


SELECT b.id, b.ref, b.date, b.total_amount, SUM(p.amount)
FROM Bill b JOIN payment p ON b.id = p.bill_id
GROUP BY b.id,  b.ref, b.date, b.total_amount
HAVING SUM(p.amount) > b.total_amount;


SELECT c.id, c.Firstname, c.Lastname, count(b.id), count(p.id)
FROM customer c LEFT JOIN bill b ON b.customer_id = c.id
				LEFT JOIN payment p ON b.id = p.bill_id
GROUP BY c.id, c.Firstname, c.Lastname
;



SELECT p.id, p.date, p.amount
FROM Payment p JOIN Bill b ON p.bill_id = b.id
WHERE p.date = b.date
;


SELECT p.id, p.date, p.amount
FROM Payment p JOIN Bill b ON (p.bill_id = b.id AND  p.date = b.date) 
;




SELECT c.id, c.lastname, c.firstname, b.ref, b.total_amount, SUM(p.amount)
FROM customer c JOIN bill b On c.id = b.customer_id
				LEFT JOIN Payment p ON b.id = p.bill_id
GROUP BY c.id, c.lastname, c.firstname, b.id, b.ref, b.total_amount
HAVING b.total_amount > SUM(p.amount)
ORDER BY c.lastname, c.firstname
;

WITH
	factures_souffrances AS (
		SELECT c.id AS cId, 
				c.lastname As cLastname, 
                c.firstname AS cFirstname, 
                b.ref AS bRef, 
                b.total_amount AS bTotal, 
                SUM(p.amount) AS totalPayment
		FROM customer c JOIN bill b On c.id = b.customer_id
						LEFT JOIN Payment p ON b.id = p.bill_id
		GROUP BY c.id, c.lastname, c.firstname, b.id, b.ref, b.total_amount
		HAVING b.total_amount > SUM(p.amount)
		ORDER BY c.lastname, c.firstname
    )
    
SELECT cLastname, cFirstname
FROM factures_souffrances
GROUP BY cLastname, cFirstname
;

SELECT * 
FROM factures_souffrances;


CREATE VIEW Facture_payees AS

SELECT b.ref, b.date, b.total_amount
FROM Bill b JOIN payment p ON b.id = p.bill_id
GROUP BY b.ref, b.date, b.total_amount
HAVING SUM(p.amount) >= b.total_amount;

SELECT id , ref , date
FROM Bill

union All

SELECT id, 'rien', date
FROM Payment;
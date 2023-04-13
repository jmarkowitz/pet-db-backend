CREATE DATABASE IF NOT EXISTS petdb;
USE petdb;


CREATE TABLE IF NOT EXISTS PetServiceProviders
(
    user_id INTEGER PRIMARY KEY,
    city    varchar(100),
    state   text,
    zip     INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS PetOwner
(
    first_name  varchar(50) NOT NULL,
    last_name   varchar(50) NOT NULL,
    age         int,
    city        varchar(50),
    state       varchar(50),
    zip         int,
    occupation  varchar(50),
    description text,
    user_id     int PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Experience
(
    psp_id        INTEGER NOT NULL,
    education     varchar(100),
    career        varchar(100),
    qualification text,
    city          varchar(100),
    state         varchar(50),
    zip           INTEGER NOT NULL,
    CONSTRAINT fk_pspID
        FOREIGN KEY (psp_id) REFERENCES PetServiceProviders (user_id)
            ON UPDATE CASCADE ON DELETE restrict
);
CREATE TABLE IF NOT EXISTS ProviderReview
(
    psp_id      INTEGER NOT NULL,
    cust_id     INTEGER NOT NULL,
    rating      varchar(100),
    CHECK ( rating BETWEEN 1 AND 5),
    description varchar(1000),
    CONSTRAINT fk_prvd_review
        FOREIGN KEY (psp_id) REFERENCES PetServiceProviders (user_id)
            ON UPDATE CASCADE ON DELETE restrict,
    CONSTRAINT fk_user_review
        FOREIGN KEY (cust_id) REFERENCES PetOwner (user_id)
            ON UPDATE CASCADE ON DELETE restrict
);

CREATE TABLE IF NOT EXISTS Service
(
    user_id        INTEGER      NOT NULL,
    service_id     INTEGER PRIMARY KEY,
    type           varchar(100) NOT NULL,
    duration_hours INTEGER      NOT NULL,
    service_date   datetime DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_userID
        FOREIGN KEY (user_id) REFERENCES PetServiceProviders (user_id)
            ON UPDATE CASCADE ON DELETE restrict
);


CREATE TABLE IF NOT EXISTS PetSpecies
(
    species_id   INTEGER PRIMARY KEY,
    species_name varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS PreferredPetSpecies
(
    service_id    INTEGER NOT NULL,
    species_id    INTEGER NOT NULL,
    vaccination   BOOLEAN NOT NULL,
    age           INTEGER NOT NULL,
    sterilization BOOLEAN,
    CONSTRAINT fk_serviceID
        FOREIGN KEY (service_id) REFERENCES Service (service_id)
            ON UPDATE CASCADE ON DELETE restrict,
    CONSTRAINT fk_prefspeciesID
        FOREIGN KEY (species_id) REFERENCES PetSpecies (species_id)
            ON UPDATE CASCADE ON DELETE restrict
);


CREATE TABLE IF NOT EXISTS Pet
(
    color                  varchar(50) NOT NULL,
    vaccination            boolean NOT NULL,
    sterilization          boolean NOT NULL,
    borrowing_availability boolean     NOT NULL,
    age                    int         NOT NULL,
    species_id             int         NOT NULL,
    personality            varchar(1000),
    pet_id                 int PRIMARY KEY,
    CONSTRAINT fk_pet_speciesID
        FOREIGN KEY (species_id) REFERENCES PetSpecies (species_id)
            ON UPDATE CASCADE ON DELETE restrict
);

CREATE TABLE IF NOT EXISTS PetBreed
(
    species_id INTEGER     NOT NULL,
    breed_id   INTEGER     NOT NULL,
    breed_name varchar(50) NOT NULL,
    CONSTRAINT fk_speciesID
        FOREIGN KEY (species_id) REFERENCES PetSpecies (species_id)
            ON UPDATE CASCADE ON DELETE restrict
);


CREATE TABLE IF NOT EXISTS OwnerFriends
(
    user_id        int            NOT NULL,
    friend_user_id int            NOT NULL,
    start_date     datetime DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_friend_userID
        FOREIGN KEY (user_id) REFERENCES PetOwner (user_id)
            ON UPDATE CASCADE ON DELETE restrict

);

CREATE TABLE IF NOT EXISTS OwnerPets
(
    user_id INTEGER NOT NULL,
    pet_num INTEGER NOT NULL,
    pet_id  INTEGER NOT NULL,
    CONSTRAINT fk_owner_userID
        FOREIGN KEY (user_id) REFERENCES PetOwner (user_id)
            ON UPDATE CASCADE ON DELETE restrict,
    CONSTRAINT fk_petID
        FOREIGN KEY (pet_id) REFERENCES Pet (pet_id)
            ON UPDATE CASCADE ON DELETE restrict
);

CREATE TABLE IF NOT EXISTS Event
(
    description text,
    event_date  date,
    city        varchar(50),
    state       varchar(50),
    zip         varchar(50),
    event_id    int PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS OwnerEvents
(
    user_id  int,
    event_id int,
    CONSTRAINT fk_eventID
        FOREIGN KEY (event_id) REFERENCES Event (event_id)
            ON UPDATE CASCADE ON DELETE restrict,
    CONSTRAINT fk_userID1
        FOREIGN KEY (user_id) REFERENCES PetOwner (user_id)
);

CREATE TABLE IF NOT EXISTS Borrower
(
    first_name   varchar(50) NOT NULL,
    last_name    varchar(50) NOT NULL,
    availability varchar(50),
    occupation   varchar(150),
    age          int,
    description  text,
    city         varchar(50),
    state        varchar(50),
    zip          int,
    borrower_id  int PRIMARY KEY,
    review_id   INTEGER
);


CREATE TABLE IF NOT EXISTS BorrowerReview
(
    review_text text,
    pet_id      int,
    borrower_id INTEGER,
    CONSTRAINT fk_review
        FOREIGN KEY (borrower_id) REFERENCES Borrower (borrower_id)
);

CREATE TABLE IF NOT EXISTS BorrowerPetPreferences
(
    species_id  int,
    type_id     int,
    habit_id    int,
    borrower_id int,
    PRIMARY KEY(habit_id, borrower_id),
    CONSTRAINT fk_borrowerid
        FOREIGN KEY (borrower_id) REFERENCES Borrower (borrower_id)
);





CREATE TABLE IF NOT EXISTS BorrowerBorrow
(
    borrower_id int,
    pet_id      int,
    PRIMARY KEY (borrower_id, pet_id),
    CONSTRAINT fk_borrowerID_1
        FOREIGN KEY (borrower_id) REFERENCES Borrower (borrower_id),
    CONSTRAINT fk_petid_2
        FOREIGN KEY (pet_id) REFERENCES Pet (pet_id)
);


INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Ursa','Oels',88,'Knoxville','Tennessee',37995,'vestibulum sit','In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.',1);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cordula','Cassedy',77,'Sacramento','California',95813,'curae nulla dapibus dolor vel','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',2);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Madonna','Davisson',26,'New Brunswick','New Jersey',08922,'duis mattis egestas metus','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.',3);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Clara','Fallon',32,'Anchorage','Alaska',99507,'in sapien iaculis','In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.',4);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cristen','Laurisch',34,'Portland','Oregon',97216,'donec odio','Sed ante. Vivamus tortor. Duis mattis egestas metus.',5);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Allyn','Rambaut',38,'Lexington','Kentucky',40524,'ultrices phasellus id sapien','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',6);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Earl','Impey',44,'Birmingham','Alabama',35231,'at turpis donec posuere','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.',7);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Marjie','Gavrielli',58,'Waco','Texas',76796,'dis parturient montes nascetur ridiculus','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.',8);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Allie','Schoular',36,'Davenport','Iowa',52809,'at lorem integer','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',9);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Ingeberg','Minger',82,'San Jose','California',95118,'placerat ante nulla justo','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',10);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Moria','Kurth',48,'Des Moines','Iowa',50335,'imperdiet sapien','Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.',11);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Aguste','Lashley',40,'Philadelphia','Pennsylvania',19151,'turpis sed ante vivamus','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',12);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Baxy','Petroff',27,'Phoenix','Arizona',85035,'donec posuere metus vitae','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',13);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cinderella','Vere',34,'Seattle','Washington',98127,'ligula in lacus curabitur','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',14);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Roderich','Adlam',23,'Grand Rapids','Michigan',49505,'morbi ut','Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.',15);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Lauren','Whitington',64,'Boise','Idaho',83722,'dui vel nisl duis ac','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.',16);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Kaylyn','Bursell',83,'Jamaica','New York',11480,'turpis enim blandit mi','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',17);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Nan','Platfoot',83,'Phoenix','Arizona',85010,'quisque erat eros','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',18);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Jakob','Pickworth',31,'San Antonio','Texas',78265,'nulla nisl nunc','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',19);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Oby','Beverley',67,'Sacramento','California',94280,'neque aenean auctor','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',20);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Rosabelle','Flippen',56,'Las Vegas','Nevada',89166,'massa quis','In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.',21);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Maddie','Theze',67,'Roanoke','Virginia',24048,'parturient montes nascetur','Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.',22);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Lexie','de Castelain',74,'El Paso','Texas',88574,'duis at velit eu','Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.',23);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Luciano','Gilleon',19,'Oklahoma City','Oklahoma',73119,'nisl venenatis','Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.',24);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Arty','Robbie',33,'Wichita','Kansas',67236,'congue eget semper rutrum nulla','Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.',25);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Ryon','Joscelin',40,'San Diego','California',92105,'id mauris','Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.',26);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Maison','Stell',81,'Saginaw','Michigan',48609,'sapien in','Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.',27);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Uriel','Widdison',87,'Denver','Colorado',80270,'scelerisque mauris sit amet eros','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',28);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Gayleen','Mowne',63,'Louisville','Kentucky',40225,'amet sem fusce','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',29);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Jobina','Bullivent',80,'Knoxville','Tennessee',37931,'laoreet ut','Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.',30);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Ferrel','Marcum',42,'Bellevue','Washington',98008,'nibh in lectus','Fusce consequat. Nulla nisl. Nunc nisl.',31);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Francisca','O''Shaughnessy',39,'Kansas City','Missouri',64160,'ultrices aliquet','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',32);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Violante','Atlee',73,'Wilmington','North Carolina',28410,'ut mauris','In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.',33);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Christos','Vidineev',71,'Austin','Texas',78769,'dolor sit amet consectetuer adipiscing','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',34);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Madlen','Berthouloume',70,'Colorado Springs','Colorado',80951,'ultricies eu','Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.',35);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Benjie','Gurry',25,'Tulsa','Oklahoma',74156,'habitasse platea dictumst etiam','Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.',36);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Melicent','Biss',44,'Manassas','Virginia',22111,'lectus aliquam sit amet','Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.',37);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Julie','Burn',38,'Saint Paul','Minnesota',55103,'in consequat ut nulla','Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.',38);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Aleen','Mawne',35,'Birmingham','Alabama',35285,'laoreet ut rhoncus aliquet','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.',39);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Kirstin','Audibert',17,'Springfield','Massachusetts',01105,'congue vivamus','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.',40);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Liz','Barnson',49,'Mobile','Alabama',36628,'suspendisse ornare consequat','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',41);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cybill','Smaridge',83,'Saint Petersburg','Florida',33731,'porta volutpat erat quisque','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',42);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cicely','Dinnington',77,'Kalamazoo','Michigan',49048,'mauris sit amet eros','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.',43);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Larissa','Westmerland',49,'Salt Lake City','Utah',84152,'nisl ut','Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.',44);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Sawyer','Bothram',56,'Fort Worth','Texas',76105,'nascetur ridiculus mus etiam vel','Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.',45);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Lewie','Lacrouts',70,'Homestead','Florida',33034,'id justo sit','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.',46);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Livvy','Oppy',85,'Austin','Texas',78764,'nulla suspendisse potenti cras in','Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.',47);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Leila','Tooher',56,'Littleton','Colorado',80126,'dolor vel est donec','Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.',48);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Lynelle','Walasik',44,'San Antonio','Texas',78291,'vestibulum ante ipsum','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',49);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Susana','Riddle',19,'Torrance','California',90510,'lorem vitae mattis nibh ligula','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.',50);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Everett','Rarity',89,'Baltimore','Maryland',21239,'vestibulum ante ipsum primis in','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.',51);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Billy','Biggadyke',16,'Roanoke','Virginia',24048,'platea dictumst','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',52);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Rodney','Klaes',44,'Salt Lake City','Utah',84140,'a libero','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.',53);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cornie','O''Gavin',51,'Boulder','Colorado',80310,'sem duis aliquam convallis nunc','Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.',54);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Caz','Durante',88,'New Orleans','Louisiana',70116,'parturient montes nascetur','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.',55);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Dolorita','Baskeyfied',18,'Oklahoma City','Oklahoma',73173,'mus etiam vel augue','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',56);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Kristos','Wall',52,'Raleigh','North Carolina',27690,'sapien in','Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.',57);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Laurie','McQuarter',48,'Hattiesburg','Mississippi',39404,'curae mauris viverra diam','Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.',58);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Portia','Zimmermeister',44,'Eugene','Oregon',97405,'congue eget semper','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.',59);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Norene','Thomassen',80,'Fort Wayne','Indiana',46805,'sem duis aliquam','Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.',60);



INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy','2022-10-25','Louisville','Kentucky',40280,1);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('mi pede malesuada in imperdiet et commodo vulputate justo in','2022-10-26','New Haven','Connecticut',06520,2);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed','2023-02-22','Honolulu','Hawaii',96825,3);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi','2023-02-25','Tampa','Florida',33610,4);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('ut erat id mauris vulputate elementum nullam varius nulla facilisi cras','2022-04-21','Phoenix','Arizona',85053,5);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus','2022-09-24','New York City','New York',10184,6);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id','2023-01-15','Pittsburgh','Pennsylvania',15210,7);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit','2022-04-26','Lakewood','Washington',98498,8);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula','2023-03-29','Bradenton','Florida',34210,9);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum','2022-08-18','Stockton','California',95205,10);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat','2022-10-24','San Francisco','California',94110,11);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui','2022-09-09','Akron','Ohio',44321,12);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi','2022-07-30','Cape Coral','Florida',33915,13);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in','2022-11-03','Toledo','Ohio',43699,14);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus','2022-09-10','Evansville','Indiana',47719,15);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non','2022-06-03','Lincoln','Nebraska',68583,16);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus','2022-05-29','Columbus','Ohio',43220,17);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt','2022-05-10','Portland','Oregon',97296,18);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet','2023-01-11','Fort Wayne','Indiana',46857,19);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue','2022-07-17','Charleston','South Carolina',29403,20);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie','2022-05-12','Greensboro','North Carolina',27409,21);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum','2022-07-06','Bronx','New York',10454,22);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec','2022-12-31','New York City','New York',10110,23);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam','2023-03-06','Aurora','Illinois',60505,24);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id','2022-11-25','Tucson','Arizona',85705,25);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum','2022-09-03','Washington','District of Columbia',20580,26);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros','2023-03-10','Dayton','Ohio',45419,27);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor','2022-08-03','Orlando','Florida',32891,28);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis','2023-03-08','Charleston','South Carolina',29424,29);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate','2022-04-29','Fredericksburg','Virginia',22405,30);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit','2022-11-06','Farmington','Michigan',48335,31);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id','2022-10-31','New York City','New York',10079,32);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante','2023-03-08','Omaha','Nebraska',68110,33);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis','2023-01-31','Kansas City','Missouri',64142,34);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis','2022-12-12','Houston','Texas',77234,35);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis','2022-12-25','Las Vegas','Nevada',89145,36);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu','2022-10-12','Austin','Texas',78710,37);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus','2022-05-11','Grand Forks','North Dakota',58207,38);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices','2022-11-13','Grand Rapids','Michigan',49518,39);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris','2022-12-10','Athens','Georgia',30610,40);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec','2023-01-02','Cleveland','Ohio',44125,41);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet','2023-01-30','Utica','New York',13505,42);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at','2022-10-19','Scottsdale','Arizona',85255,43);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam','2022-07-25','Lincoln','Nebraska',68583,44);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa','2022-12-31','Huntington','West Virginia',25716,45);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit','2023-01-16','Appleton','Wisconsin',54915,46);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt','2022-05-12','Akron','Ohio',44315,47);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat','2023-02-02','Baton Rouge','Louisiana',70805,48);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis','2022-10-18','Denver','Colorado',80209,49);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa','2022-08-31','Marietta','Georgia',30066,50);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget','2023-01-07','Miami','Florida',33233,51);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa','2023-01-04','Pittsburgh','Pennsylvania',15230,52);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est','2022-10-18','Farmington','Michigan',48335,53);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla','2022-12-02','Maple Plain','Minnesota',55572,54);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque','2023-03-08','El Paso','Texas',79968,55);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in','2023-03-20','New Haven','Connecticut',06538,56);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante','2022-10-10','Washington','District of Columbia',20062,57);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus','2022-10-29','Indianapolis','Indiana',46247,58);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend','2022-05-14','Saint Louis','Missouri',63150,59);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam','2023-01-20','Phoenix','Arizona',85015,60);



INSERT INTO OwnerEvents(user_id,event_id) VALUES (7,24);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (4,5);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (12,21);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (46,42);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (1,2);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (18,11);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (47,36);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (38,48);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (3,47);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (40,44);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (57,52);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (14,39);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (39,1);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (28,26);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (11,17);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (26,54);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (53,15);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (52,28);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (44,13);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (51,25);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (35,9);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (9,57);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (32,8);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (19,41);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (48,51);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (55,14);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (59,18);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (37,29);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (24,40);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (41,38);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (31,59);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (34,46);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (27,19);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (17,22);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (6,30);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (30,4);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (10,7);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (45,49);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (54,37);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (2,16);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (8,34);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (50,23);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (22,55);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (43,45);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (29,35);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (16,32);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (23,53);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (58,31);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (36,20);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (15,56);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (21,33);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (20,3);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (56,60);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (13,6);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (5,58);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (25,43);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (42,50);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (49,10);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (33,27);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (60,12);



INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (54,718,'2022-11-26');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (46,391,'2022-04-30');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (32,480,'2023-02-14');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (30,652,'2022-12-21');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (27,661,'2022-06-03');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (34,170,'2022-07-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (48,439,'2023-03-18');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (49,99,'2023-03-17');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (3,561,'2023-02-13');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (2,857,'2022-05-11');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (59,83,'2022-12-29');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (20,199,'2022-04-07');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (14,680,'2023-01-03');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (1,465,'2022-07-16');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (35,247,'2022-05-24');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (10,101,'2022-09-07');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (21,159,'2022-04-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (60,409,'2023-02-24');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (5,833,'2022-06-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (47,85,'2023-01-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (36,230,'2022-07-28');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (43,434,'2022-07-22');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (50,880,'2023-04-01');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (41,63,'2023-03-12');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (29,176,'2022-06-17');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (55,372,'2022-04-13');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (45,856,'2022-06-17');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (51,204,'2022-10-12');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (16,977,'2022-05-03');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (33,659,'2022-07-12');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (8,637,'2022-06-18');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (12,695,'2023-02-15');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (37,95,'2022-08-03');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (53,575,'2022-04-13');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (17,276,'2022-08-01');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (39,131,'2022-11-02');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (57,664,'2023-03-28');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (44,708,'2022-09-28');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (6,90,'2022-07-06');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (9,691,'2022-04-25');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (23,583,'2023-03-11');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (38,972,'2023-03-15');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (22,809,'2022-11-27');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (56,465,'2022-05-20');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (4,778,'2022-12-02');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (19,255,'2022-11-26');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (7,460,'2023-01-08');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (11,876,'2022-11-14');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (31,483,'2022-05-28');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (40,593,'2022-09-16');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (26,310,'2022-10-26');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (25,337,'2022-10-14');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (52,772,'2022-07-19');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (18,302,'2023-01-24');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (42,59,'2023-01-15');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (24,196,'2023-03-28');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (58,408,'2022-04-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (28,970,'2022-06-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (15,374,'2022-06-27');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (13,702,'2022-11-27');



INSERT INTO PetSpecies(species_id,species_name) VALUES (1,'Yellow-headed caracara');
INSERT INTO PetSpecies(species_id,species_name) VALUES (2,'Suricate');
INSERT INTO PetSpecies(species_id,species_name) VALUES (3,'Oribi');
INSERT INTO PetSpecies(species_id,species_name) VALUES (4,'Corella, long-billed');
INSERT INTO PetSpecies(species_id,species_name) VALUES (5,'Tern, royal');
INSERT INTO PetSpecies(species_id,species_name) VALUES (6,'Eagle, golden');
INSERT INTO PetSpecies(species_id,species_name) VALUES (7,'Crane, sarus');
INSERT INTO PetSpecies(species_id,species_name) VALUES (8,'Rat, arboral spiny');
INSERT INTO PetSpecies(species_id,species_name) VALUES (9,'Eagle, bateleur');
INSERT INTO PetSpecies(species_id,species_name) VALUES (10,'Southern lapwing');
INSERT INTO PetSpecies(species_id,species_name) VALUES (11,'Fox, savanna');
INSERT INTO PetSpecies(species_id,species_name) VALUES (12,'Long-crested hawk eagle');
INSERT INTO PetSpecies(species_id,species_name) VALUES (13,'European red squirrel');
INSERT INTO PetSpecies(species_id,species_name) VALUES (14,'Shrike, common boubou');
INSERT INTO PetSpecies(species_id,species_name) VALUES (15,'Tammar wallaby');
INSERT INTO PetSpecies(species_id,species_name) VALUES (16,'Coqui partridge');
INSERT INTO PetSpecies(species_id,species_name) VALUES (17,'American bighorn sheep');
INSERT INTO PetSpecies(species_id,species_name) VALUES (18,'Australian spiny anteater');
INSERT INTO PetSpecies(species_id,species_name) VALUES (19,'Jackal, asiatic');
INSERT INTO PetSpecies(species_id,species_name) VALUES (20,'Wallaby, tammar');
INSERT INTO PetSpecies(species_id,species_name) VALUES (21,'Wallaby, red-necked');
INSERT INTO PetSpecies(species_id,species_name) VALUES (22,'Stork, marabou');
INSERT INTO PetSpecies(species_id,species_name) VALUES (23,'Trumpeter swan');
INSERT INTO PetSpecies(species_id,species_name) VALUES (24,'Swan, trumpeter');
INSERT INTO PetSpecies(species_id,species_name) VALUES (25,'Snowy sheathbill');
INSERT INTO PetSpecies(species_id,species_name) VALUES (26,'Springbok');
INSERT INTO PetSpecies(species_id,species_name) VALUES (27,'Bear, american black');
INSERT INTO PetSpecies(species_id,species_name) VALUES (28,'Lemur, sportive');
INSERT INTO PetSpecies(species_id,species_name) VALUES (29,'Dragon, asian water');
INSERT INTO PetSpecies(species_id,species_name) VALUES (30,'Lemming, arctic');
INSERT INTO PetSpecies(species_id,species_name) VALUES (31,'Turkey, common');
INSERT INTO PetSpecies(species_id,species_name) VALUES (32,'Cobra, cape');
INSERT INTO PetSpecies(species_id,species_name) VALUES (33,'Thirteen-lined squirrel');
INSERT INTO PetSpecies(species_id,species_name) VALUES (34,'American beaver');
INSERT INTO PetSpecies(species_id,species_name) VALUES (35,'Finch, common melba');
INSERT INTO PetSpecies(species_id,species_name) VALUES (36,'Pronghorn');
INSERT INTO PetSpecies(species_id,species_name) VALUES (37,'Rat, arboral spiny');
INSERT INTO PetSpecies(species_id,species_name) VALUES (38,'Tortoise, desert');
INSERT INTO PetSpecies(species_id,species_name) VALUES (39,'Wolf spider');
INSERT INTO PetSpecies(species_id,species_name) VALUES (40,'Tarantula');
INSERT INTO PetSpecies(species_id,species_name) VALUES (41,'Black-capped capuchin');
INSERT INTO PetSpecies(species_id,species_name) VALUES (42,'Wallaby, red-necked');
INSERT INTO PetSpecies(species_id,species_name) VALUES (43,'Pigeon, wood');
INSERT INTO PetSpecies(species_id,species_name) VALUES (44,'Robin, white-throated');
INSERT INTO PetSpecies(species_id,species_name) VALUES (45,'Galapagos penguin');
INSERT INTO PetSpecies(species_id,species_name) VALUES (46,'Duiker, common');
INSERT INTO PetSpecies(species_id,species_name) VALUES (47,'Bandicoot, short-nosed');
INSERT INTO PetSpecies(species_id,species_name) VALUES (48,'South African hedgehog');
INSERT INTO PetSpecies(species_id,species_name) VALUES (49,'Quoll, spotted-tailed');
INSERT INTO PetSpecies(species_id,species_name) VALUES (50,'Eagle, bateleur');
INSERT INTO PetSpecies(species_id,species_name) VALUES (51,'Crane, sarus');
INSERT INTO PetSpecies(species_id,species_name) VALUES (52,'Owl, snowy');
INSERT INTO PetSpecies(species_id,species_name) VALUES (53,'Raven, cape');
INSERT INTO PetSpecies(species_id,species_name) VALUES (54,'Vulture, bengal');
INSERT INTO PetSpecies(species_id,species_name) VALUES (55,'Rufous-collared sparrow');
INSERT INTO PetSpecies(species_id,species_name) VALUES (56,'Currasow (unidentified)');
INSERT INTO PetSpecies(species_id,species_name) VALUES (57,'Bee-eater, nubian');
INSERT INTO PetSpecies(species_id,species_name) VALUES (58,'Fairy penguin');
INSERT INTO PetSpecies(species_id,species_name) VALUES (59,'White-tailed jackrabbit');
INSERT INTO PetSpecies(species_id,species_name) VALUES (60,'Goliath heron');



INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Violet','1','1','0',48,49,'diam in magna bibendum imperdiet nullam orci pede venenatis non sodales',1);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Turquoise','0','0','1',54,39,'lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat',2);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Green','1','0','1',27,26,'id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo',3);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Fuscia','1','1','0',85,47,'tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla',4);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Yellow','0','0','0',44,15,'accumsan tellus nisi eu orci mauris lacinia sapien quis libero',5);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Crimson','1','0','1',36,31,'justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam',6);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Teal','0','1','1',84,21,'at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis',7);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Yellow','0','1','0',62,18,'sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla',8);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Puce','1','1','1',22,20,'augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi',9);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Yellow','1','0','0',80,53,'nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet',10);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Puce','1','0','0',43,58,'ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus',11);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Indigo','1','1','0',67,38,'natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient',12);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Crimson','0','1','0',72,46,'curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue',13);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Violet','1','0','1',89,33,'pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti',14);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Purple','0','0','0',61,37,'eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo',15);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Orange','0','1','0',24,22,'dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl',16);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Blue','1','0','1',73,52,'eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio',17);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Aquamarine','0','1','1',51,51,'tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem',18);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Puce','1','1','0',51,54,'pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla',19);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Violet','0','1','0',49,35,'lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis',20);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Violet','0','0','1',70,13,'auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede',21);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Pink','1','0','1',74,12,'amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam',22);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Purple','1','0','1',68,19,'semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero',23);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Purple','1','1','0',77,4,'vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque',24);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Teal','0','0','0',39,14,'justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer',25);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Teal','0','0','1',75,57,'in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in',26);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Blue','1','0','1',82,8,'aliquet maecenas leo odio condimentum id luctus nec molestie sed',27);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Purple','0','0','0',16,41,'eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in',28);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Yellow','1','0','0',40,59,'imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi',29);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Teal','1','1','1',24,50,'dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis',30);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Orange','1','1','1',83,6,'posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis',31);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Maroon','1','0','0',71,16,'etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate',32);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Fuscia','1','0','1',87,55,'pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet',33);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Orange','1','0','0',40,34,'erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat',34);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Crimson','0','1','0',72,42,'vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat',35);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Aquamarine','0','1','0',84,27,'platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in',36);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Fuscia','1','0','0',66,32,'praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent',37);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Crimson','1','1','1',47,28,'tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit',38);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Maroon','0','1','1',18,24,'eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a',39);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Purple','0','1','1',88,43,'in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus',40);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Goldenrod','1','1','1',80,1,'sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu',41);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Crimson','0','0','1',81,30,'turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non',42);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Teal','1','1','1',67,29,'vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque',43);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Teal','1','0','1',64,60,'eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui',44);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Yellow','0','1','1',23,7,'nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac',45);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Fuscia','1','0','0',59,17,'parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut',46);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Pink','0','1','1',85,44,'nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi',47);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Aquamarine','1','1','0',51,56,'maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque',48);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Orange','1','1','1',18,9,'id nulla ultrices aliquet maecenas leo odio condimentum id luctus',49);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Blue','0','0','0',81,11,'at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum',50);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Puce','0','1','1',45,40,'eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam',51);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Pink','1','1','1',15,5,'elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus',52);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Orange','1','0','0',56,23,'iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget',53);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Aquamarine','0','0','0',35,48,'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam',54);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Blue','1','0','0',44,25,'in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices',55);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Green','1','1','0',53,10,'tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac',56);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Yellow','0','1','1',44,45,'cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere',57);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Purple','1','1','0',55,2,'blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac',58);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Maroon','1','1','0',81,3,'in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan',59);
INSERT INTO Pet(color,vaccination,sterilization,borrowing_availability,age,species_id,personality,pet_id) VALUES ('Yellow','0','1','1',86,36,'interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat',60);


INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (33,1,'tempus');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (6,2,'ultricies eu nibh');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (24,3,'ut erat id');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (49,4,'nulla nunc');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (60,5,'lacus purus aliquet');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (21,6,'lobortis est phasellus');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (56,7,'leo');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (48,8,'lorem ipsum dolor');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (57,9,'ut mauris eget');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (15,10,'tellus nulla ut');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (16,11,'sit amet');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (30,12,'fusce lacus purus');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (55,13,'convallis nulla neque');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (1,14,'volutpat erat');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (58,15,'sagittis nam');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (9,16,'nulla');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (18,17,'ac');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (51,18,'tristique');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (37,19,'aliquet pulvinar');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (20,20,'sapien');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (53,21,'cum sociis');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (52,22,'ultrices posuere');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (41,23,'leo pellentesque');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (26,24,'nunc');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (14,25,'eget tempus');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (17,26,'ligula sit amet');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (11,27,'duis consequat dui');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (8,28,'venenatis turpis enim');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (31,29,'dapibus nulla suscipit');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (4,30,'id mauris');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (43,31,'neque');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (25,32,'nulla nisl nunc');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (35,33,'velit');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (45,34,'sit amet nulla');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (12,35,'massa quis augue');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (29,36,'dui');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (34,37,'pede morbi');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (40,38,'turpis');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (13,39,'donec');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (2,40,'sapien cursus');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (5,41,'non mauris morbi');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (50,42,'curae mauris');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (42,43,'pede ac diam');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (47,44,'accumsan felis');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (22,45,'amet turpis elementum');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (38,46,'in congue etiam');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (39,47,'quis lectus suspendisse');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (59,48,'ridiculus mus vivamus');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (28,49,'at');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (10,50,'sapien cursus');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (46,51,'aliquet maecenas leo');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (32,52,'in quam');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (7,53,'iaculis diam erat');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (19,54,'proin');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (3,55,'sit');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (23,56,'fringilla rhoncus');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (44,57,'amet justo morbi');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (54,58,'ligula');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (27,59,'ante vel');
INSERT INTO PetBreed(species_id,breed_id,breed_name) VALUES (36,60,'ultricies');



INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Amery','Raggles','habitasse','nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa',2,'sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit','Richmond','Virginia',23293,1,1);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Kakalina','Wootton','eu','tortor id nulla ultrices aliquet maecenas leo odio condimentum id',1,'dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor','Stamford','Connecticut',06912,2,2);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Hardy','Airlie','at','amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu',3,'a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla','Tulsa','Oklahoma',74141,3,3);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Giusto','Simpole','odio','ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel',2,'pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus','Bridgeport','Connecticut',06606,4,4);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Carlina','Canadine','lectus','integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus',3,'feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse','Fort Smith','Arkansas',72905,5,5);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Jordana','Wishkar','sagittis','nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla',2,'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et','Laurel','Maryland',20709,6,6);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Micah','Phillips','est','nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae',1,'dolor vel est donec odio justo sollicitudin ut suscipit a feugiat','Fresno','California',93721,7,7);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Tremain','Egdell','suscipit','pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus',3,'felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis','Erie','Pennsylvania',16522,8,8);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Catie','Grieswood','faucibus','blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer',2,'amet cursus id turpis integer aliquet massa id lobortis convallis tortor','Memphis','Tennessee',38109,9,9);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Nell','Dobeson','ultrices','purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam',3,'luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis','Columbus','Ohio',43210,10,10);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Micaela','Insoll','congue','amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in',3,'pede ullamcorper augue a suscipit nulla elit ac nulla sed','Washington','District of Columbia',20268,11,11);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Diannne','Krout','ac','aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec',3,'faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis','New York City','New York',10019,12,12);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Anni','Jancik','vel','ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula',1,'tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas','Beaumont','Texas',77705,13,13);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Lammond','Hathway','nisi','ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat',3,'quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor','Wichita','Kansas',67220,14,14);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Hussein','Wozencroft','consequat','libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis',3,'morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque','Huntington','West Virginia',25721,15,15);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Minetta','Guare','magnis','fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies',3,'imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo','San Diego','California',92137,16,16);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Barclay','Cicero','vitae','ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est',3,'ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus','Pueblo','Colorado',81005,17,17);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Demetris','Odgers','nulla','nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam',3,'imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit','Akron','Ohio',44321,18,18);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Gherardo','Murfett','in','nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac',3,'in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut','Jeffersonville','Indiana',47134,19,19);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Adah','Harradine','arcu','mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem',1,'integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante','New Orleans','Louisiana',70183,20,20);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Seward','Spry','praesent','sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis',3,'quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus','Portsmouth','New Hampshire',00214,21,21);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Clemmy','Kilsby','aliquet','eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero',1,'sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh','El Paso','Texas',79945,22,22);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Fidelia','Adame','tortor','quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris',1,'suscipit nulla elit ac nulla sed vel enim sit amet','Racine','Wisconsin',53405,23,23);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Dominick','Maving','ornare','potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus',2,'sapien a libero nam dui proin leo odio porttitor id consequat in','Battle Creek','Michigan',49018,24,24);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Rayshell','Oolahan','condimentum','varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper',3,'elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas','Escondido','California',92030,25,25);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Ashla','Commuzzo','platea','felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut',2,'posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit','Cleveland','Ohio',44118,26,26);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Onfroi','Marre','eu','mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum',2,'primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio','Arlington','Virginia',22244,27,27);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Madlin','De Antoni','nulla','molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae',1,'nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec','Orange','California',92867,28,28);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Lyman','Postlethwaite','at','sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec',2,'ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus','Atlanta','Georgia',30306,29,29);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Diannne','Govey','primis','iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus',3,'volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum','San Francisco','California',94105,30,30);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Giraldo','Delacroux','suspendisse','parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes',1,'nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam','Washington','District of Columbia',20062,31,31);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Nanci','Timpany','consequat','eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien',3,'eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue','Trenton','New Jersey',08695,32,32);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Stacia','Churm','iaculis','quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis',2,'nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit','Seattle','Washington',98185,33,33);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Clerissa','Shurman','risus','ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras',3,'aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum','Colorado Springs','Colorado',80995,34,34);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Mirabel','McClarence','quisque','mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed',1,'a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel','Pensacola','Florida',32526,35,35);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Othilie','Fydo','blandit','ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus',3,'enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem','Norfolk','Virginia',23504,36,36);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Rosalyn','Connaughton','morbi','proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut',2,'sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in','Charleston','West Virginia',25321,37,37);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Eryn','Jesteco','nibh','in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis',1,'etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut','Detroit','Michigan',48258,38,38);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Gaby','Ness','ipsum','vehicula consequat morbi a ipsum integer a nibh in quis',3,'aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis','Baltimore','Maryland',21281,39,39);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Maddalena','Toke','mattis','vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non',1,'nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris','San Luis Obispo','California',93407,40,40);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Fina','Hyett','ultrices','sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel',1,'a libero nam dui proin leo odio porttitor id consequat in','Aurora','Illinois',60505,41,41);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Ethelyn','Engley','est','aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem',2,'parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient','Boise','Idaho',83716,42,42);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Willie','Gayle','habitasse','augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit',1,'id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam','Fresno','California',93778,43,43);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Traver','Bellchamber','vestibulum','ut suscipit a feugiat et eros vestibulum ac est lacinia',1,'lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis','Charlottesville','Virginia',22908,44,44);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Claire','Call','quam','gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo',3,'mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a','Mc Keesport','Pennsylvania',15134,45,45);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Legra','Arrigucci','magnis','nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit',3,'augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc','Salt Lake City','Utah',84152,46,46);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Catrina','Daveley','donec','dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper',1,'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non','Birmingham','Alabama',35236,47,47);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Nikolas','De Malchar','consequat','eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante',2,'a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices','San Diego','California',92170,48,48);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Julio','Shortin','nunc','sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum',1,'nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate','Amarillo','Texas',79118,49,49);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Anatola','Cappel','eu','ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac',1,'sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede','Springfield','Massachusetts',01129,50,50);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Lulu','Shute','semper','luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat',3,'id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget','Provo','Utah',84605,51,51);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Walsh','Seeley','congue','curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum',3,'est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum','Oklahoma City','Oklahoma',73147,52,52);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Henderson','Richie','nisl','euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem',2,'ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis','Corpus Christi','Texas',78415,53,53);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Brucie','Ferminger','massa','morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus',3,'rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin','Fairfield','Connecticut',06825,54,54);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Nisse','Sprake','volutpat','sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae',3,'eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien','Atlanta','Georgia',31165,55,55);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Berti','Craiker','erat','in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius',3,'hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget','Springfield','Massachusetts',01114,56,56);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Enos','Frood','consequat','in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing',3,'vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit','Las Vegas','Nevada',89155,57,57);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Pall','Reinbeck','neque','fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum',2,'donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue','Grand Forks','North Dakota',58207,58,58);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Clifford','Osmund','luctus','tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu',2,'iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla','Houston','Texas',77060,59,59);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Raff','Ponting','sapien','non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet',3,'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis','Albuquerque','New Mexico',87115,60,60);



INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (1,1,1,58);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (2,2,2,35);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (3,3,3,11);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (4,4,4,39);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (5,5,5,30);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (6,6,6,1);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (7,7,7,4);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (8,8,8,59);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (9,9,9,55);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (10,10,10,27);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (11,11,11,48);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (12,12,12,35);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (13,13,13,2);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (14,14,14,40);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (15,15,15,60);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (16,16,16,5);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (17,17,17,36);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (18,18,18,51);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (19,19,19,44);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (20,20,20,29);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (21,21,21,50);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (22,22,22,33);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (23,23,23,35);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (24,24,24,37);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (25,25,25,7);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (26,26,26,56);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (27,27,27,41);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (28,28,28,13);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (29,29,29,24);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (30,30,30,17);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (31,31,31,42);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (32,32,32,9);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (33,33,33,33);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (34,34,34,7);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (35,35,35,8);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (36,36,36,25);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (37,37,37,53);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (38,38,38,27);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (39,39,39,10);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (40,40,40,11);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (41,41,41,4);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (42,42,42,49);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (43,43,43,7);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (44,44,44,57);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (45,45,45,24);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (46,46,46,58);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (47,47,47,33);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (48,48,48,20);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (49,49,49,23);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (50,50,50,3);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (51,51,51,44);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (52,52,52,28);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (53,53,53,23);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (54,54,54,17);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (55,55,55,10);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (56,56,56,34);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (57,57,57,58);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (58,58,58,11);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (59,59,59,50);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (60,60,60,31);

INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl',1,59);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin',2,30);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus',3,44);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in',4,6);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh',5,41);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien',6,20);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo',7,18);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla',8,48);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in',9,28);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id',10,2);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at',11,27);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in',12,46);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis',13,52);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('imperdiet sapien urna pretium nisl ut volutpat sapien',14,18);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate',15,41);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('morbi',16,38);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum',17,1);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id',18,33);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('nec dui luctus rutrum',19,22);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor',20,11);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum',21,29);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris',22,21);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc',23,15);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo',24,36);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('suspendisse potenti cras in purus eu magna vulputate luctus cum sociis',25,43);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('condimentum curabitur in libero ut massa volutpat convallis morbi odio',26,42);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('imperdiet et commodo',27,22);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur',28,46);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti',29,28);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum',30,36);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea',31,5);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis',32,58);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis',33,39);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec',34,29);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('interdum mauris',35,9);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius',36,55);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque',37,33);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec',38,28);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis',39,39);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget',40,9);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('pede justo eu massa donec dapibus duis at velit eu est congue elementum in',41,6);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris',42,11);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu',43,30);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('a pede posuere',44,25);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('condimentum neque',45,59);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi',46,7);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit',47,4);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida',48,28);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('scelerisque quam turpis adipiscing lorem vitae mattis nibh',49,15);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet',50,4);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec',51,42);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien',52,54);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('quis',53,13);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet',54,51);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non',55,14);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue',56,19);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio',57,6);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim',58,52);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia',59,35);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis',60,26);


INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (58,48);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (23,44);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (33,5);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (4,26);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (54,13);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (57,28);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (27,32);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (9,16);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (52,21);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (31,43);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (27,50);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (50,38);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (13,12);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (22,25);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (46,40);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (9,26);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (48,3);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (12,58);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (20,49);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (28,41);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (34,23);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (1,59);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (2,30);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (31,42);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (3,57);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (54,5);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (24,23);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (39,16);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (12,44);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (47,4);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (56,60);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (5,52);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (28,8);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (54,9);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (12,26);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (8,2);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (59,34);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (1,7);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (2,42);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (57,14);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (59,22);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (29,56);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (60,9);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (39,12);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (32,50);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (48,53);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (7,37);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (27,58);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (53,49);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (36,29);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (41,15);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (26,50);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (27,15);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (18,6);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (46,31);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (14,49);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (16,41);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (43,41);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (18,28);
INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (1,50);




# PetServiceProviders
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (1,'Saint Joseph','Missouri',64504);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (2,'Saint Louis','Missouri',63143);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (3,'Boise','Idaho',83732);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (4,'Naples','Florida',33963);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (5,'Canton','Ohio',44760);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (6,'Mobile','Alabama',36628);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (7,'Montgomery','Alabama',36104);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (8,'Longview','Texas',75605);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (9,'Atlanta','Georgia',30368);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (10,'Sioux Falls','South Dakota',57110);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (11,'Duluth','Minnesota',55811);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (12,'Monroe','Louisiana',71213);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (13,'San Antonio','Texas',78225);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (14,'Baltimore','Maryland',21275);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (15,'Oceanside','California',92056);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (16,'Minneapolis','Minnesota',55436);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (17,'Washington','District of Columbia',20005);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (18,'New Orleans','Louisiana',70174);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (19,'Washington','District of Columbia',20022);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (20,'Colorado Springs','Colorado',80995);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (21,'Dayton','Ohio',45403);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (22,'Saint Louis','Missouri',63196);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (23,'Bronx','New York',10454);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (24,'New York City','New York',10034);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (25,'Washington','District of Columbia',20580);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (26,'Fairfield','Connecticut',06825);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (27,'Mesa','Arizona',85210);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (28,'Billings','Montana',59105);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (29,'New York City','New York',10090);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (30,'Johnstown','Pennsylvania',15906);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (31,'Washington','District of Columbia',20046);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (32,'Green Bay','Wisconsin',54313);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (33,'Hattiesburg','Mississippi',39404);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (34,'Tampa','Florida',33625);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (35,'Houston','Texas',77260);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (36,'Irving','Texas',75037);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (37,'New Bedford','Massachusetts',02745);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (38,'Kansas City','Kansas',66112);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (39,'Atlanta','Georgia',31165);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (40,'Toledo','Ohio',43666);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (41,'Muncie','Indiana',47306);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (42,'Frankfort','Kentucky',40618);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (43,'Lansing','Michigan',48919);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (44,'New Orleans','Louisiana',70129);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (45,'Jackson','Tennessee',38308);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (46,'Baton Rouge','Louisiana',70820);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (47,'Lancaster','California',93584);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (48,'Portland','Oregon',97211);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (49,'Cleveland','Ohio',44177);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (50,'Sarasota','Florida',34276);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (51,'Washington','District of Columbia',20530);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (52,'Albany','New York',12262);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (53,'Houston','Texas',77075);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (54,'Norfolk','Virginia',23504);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (55,'Colorado Springs','Colorado',80935);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (56,'Hartford','Connecticut',06105);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (57,'Fort Lauderdale','Florida',33336);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (58,'Charlottesville','Virginia',22908);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (59,'Saint Louis','Missouri',63136);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (60,'Washington','District of Columbia',20051);



# service
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (42,1,'varius nulla facilisi cras non velit nec nisi vulputate',5,'2023-02-28');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (33,2,'vestibulum sed magna at nunc commodo placerat praesent blandit nam',7,'2022-05-04');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (54,3,'felis donec semper sapien a',8,'2023-03-20');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (28,4,'at vulputate vitae nisl aenean lectus',7,'2022-11-03');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (59,5,'luctus et ultrices posuere cubilia',7,'2022-12-14');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (29,6,'ante vel ipsum praesent blandit lacinia erat vestibulum sed magna',2,'2022-11-19');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (29,7,'orci vehicula condimentum curabitur in libero ut massa volutpat convallis',1,'2022-05-01');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (7,8,'amet lobortis sapien sapien non mi integer ac neque duis',3,'2022-11-20');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (37,9,'eget tempus vel pede morbi porttitor lorem',4,'2022-09-09');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (9,10,'primis in faucibus orci luctus et',5,'2023-02-13');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (19,11,'in hac habitasse platea dictumst maecenas ut',7,'2022-08-15');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (21,12,'iaculis congue vivamus metus arcu adipiscing molestie hendrerit',6,'2023-02-22');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (51,13,'justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla',5,'2022-09-22');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (40,14,'ut volutpat sapien arcu sed augue aliquam erat volutpat',3,'2022-10-15');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (26,15,'et ultrices posuere cubilia curae donec pharetra magna',8,'2023-03-20');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (23,16,'congue elementum in hac habitasse platea dictumst morbi vestibulum',6,'2022-07-12');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (40,17,'praesent id massa id nisl venenatis lacinia aenean sit',2,'2022-07-16');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (11,18,'neque libero convallis eget eleifend',4,'2022-12-18');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (40,19,'in est risus auctor sed tristique in tempus sit amet',2,'2022-05-15');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (44,20,'ullamcorper purus sit amet nulla quisque',7,'2023-03-01');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (29,21,'tincidunt nulla mollis molestie lorem quisque ut erat curabitur',5,'2023-02-04');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (1,22,'posuere felis sed lacus morbi sem mauris laoreet',1,'2022-06-13');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (13,23,'vestibulum proin eu mi nulla ac enim',8,'2023-02-10');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (21,24,'vestibulum sed magna at nunc commodo placerat praesent',4,'2023-03-08');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (45,25,'nullam sit amet turpis elementum ligula vehicula consequat',5,'2022-04-15');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (52,26,'sed ante vivamus tortor duis mattis egestas metus',4,'2022-12-06');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (50,27,'non pretium quis lectus suspendisse potenti in',3,'2022-11-06');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (34,28,'tristique fusce congue diam id ornare',8,'2023-03-04');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (12,29,'tristique est et tempus semper est quam pharetra',3,'2023-03-09');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (19,30,'ac nibh fusce lacus purus',6,'2023-01-29');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (53,31,'turpis enim blandit mi in porttitor pede justo eu massa',1,'2022-05-18');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (48,32,'morbi a ipsum integer a nibh',3,'2022-08-13');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (29,33,'adipiscing lorem vitae mattis nibh',1,'2023-01-23');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (3,34,'justo nec condimentum neque sapien placerat ante',6,'2022-06-14');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (38,35,'a suscipit nulla elit ac nulla sed',6,'2022-12-13');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (43,36,'quis tortor id nulla ultrices aliquet maecenas',2,'2022-04-27');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (17,37,'duis bibendum morbi non quam nec dui',5,'2022-06-05');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (58,38,'in felis donec semper sapien a libero nam dui proin',5,'2023-03-20');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (9,39,'orci luctus et ultrices posuere cubilia curae nulla dapibus dolor',6,'2022-10-25');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (7,40,'euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula',4,'2022-10-21');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (15,41,'enim in tempor turpis nec euismod scelerisque',7,'2022-05-06');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (51,42,'et eros vestibulum ac est lacinia nisi venenatis tristique fusce',1,'2022-12-27');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (1,43,'quam turpis adipiscing lorem vitae mattis nibh ligula',1,'2022-04-11');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (33,44,'sapien ut nunc vestibulum ante ipsum primis',8,'2022-07-02');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (4,45,'nam dui proin leo odio porttitor id',3,'2022-08-18');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (27,46,'ipsum aliquam non mauris morbi non',5,'2022-09-15');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (60,47,'eu sapien cursus vestibulum proin eu mi',8,'2022-06-29');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (22,48,'at vulputate vitae nisl aenean lectus pellentesque eget',6,'2023-02-22');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (53,49,'tellus nisi eu orci mauris lacinia',7,'2022-11-23');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (44,50,'morbi vestibulum velit id pretium',7,'2022-04-25');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (2,51,'vehicula consequat morbi a ipsum integer a nibh',1,'2023-01-15');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (13,52,'duis consequat dui nec nisi volutpat',4,'2022-05-02');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (42,53,'aenean auctor gravida sem praesent id massa',4,'2022-11-17');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (6,54,'dis parturient montes nascetur ridiculus mus vivamus',1,'2022-08-16');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (17,55,'faucibus cursus urna ut tellus nulla ut',7,'2023-03-12');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (26,56,'lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum',6,'2022-10-19');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (48,57,'massa quis augue luctus tincidunt',5,'2022-12-09');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (3,58,'nisi venenatis tristique fusce congue diam id ornare imperdiet',1,'2022-11-06');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (34,59,'feugiat non pretium quis lectus suspendisse',1,'2022-07-24');
INSERT INTO Service(user_id,service_id,type,duration_hours,service_date) VALUES (22,60,'sit amet consectetuer adipiscing elit proin interdum',8,'2022-06-02');

# experience
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (37,'Gonabad University of Medical Sciences','Senior Cost Accountant','interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus','Brooklyn','New York',11236);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (31,'La Salle Universities - International Programmes','Technical Writer','sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus','Las Vegas','Nevada',89150);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (2,'FAAP - Fundação Armando Alvares Penteado','VP Product Management','feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio','Shreveport','Louisiana',71161);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (40,'Aichi Gakusen University','Chief Design Engineer','pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl','Mesquite','Texas',75185);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (3,'Technical University of Mining and Metallurgy Ostrava','Professor','pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis','Columbus','Ohio',43240);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (47,'Universidad Autónoma de Querétaro','Office Assistant IV','porttitor pede justo eu massa donec dapibus duis at velit','Washington','District of Columbia',20530);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (30,'University of South Carolina - Beaufort','Technical Writer','risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien','San Jose','California',95113);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (36,'University of Calcutta','Cost Accountant','mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a','Miami','Florida',33158);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (54,'California State University, Chico','Data Coordinator','ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti','Stamford','Connecticut',06905);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (51,'Pomona College','Recruiting Manager','vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan','Fort Wayne','Indiana',46825);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (41,'Johnson State College','Systems Administrator I','donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut','Shreveport','Louisiana',71166);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (19,'Tohoku College of Pharmacy','Health Coach IV','ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem','Charleston','West Virginia',25336);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (24,'Fiji School of Medicine','Junior Executive','auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis','Seattle','Washington',98166);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (26,'Acharya Ranga Agricultural University','VP Accounting','lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non','Portsmouth','New Hampshire',03804);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (19,'Syracuse University','Mechanical Systems Engineer','vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis','Albany','New York',12262);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (59,'Military University Shoumen','Developer III','posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit','Erie','Pennsylvania',16510);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (53,'Dubai Medical College for Girls','Analyst Programmer','ut massa volutpat convallis morbi odio odio elementum eu interdum eu','Scottsdale','Arizona',85260);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (37,'Boston Architectural Center','Internal Auditor','id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in','Philadelphia','Pennsylvania',19125);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (33,'Washington State University, Spokane','Senior Developer','massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu','Jacksonville','Florida',32244);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (20,'Hochschule Magdeburg-Stendal (FH)','Executive Secretary','convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat','Chicago','Illinois',60641);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (2,'El Shorouk Academy','Cost Accountant','id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu','Lake Worth','Florida',33462);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (29,'University of Kerala','Tax Accountant','dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur','Irvine','California',92619);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (25,'City University College of Science and Technology','Marketing Manager','blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo','Chicago','Illinois',60686);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (16,'Kalinga University','Help Desk Operator','eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed','Toledo','Ohio',43666);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (12,'Sanjay Gandhi Postgraduate lnstitute of Medical Sciences','Software Engineer II','morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non','Lexington','Kentucky',40581);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (54,'Kentucky State University','Senior Sales Associate','justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices','Edmond','Oklahoma',73034);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (18,'Wright Institute','Staff Accountant IV','curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer','Oakland','California',94611);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (16,'Georgia Health Sciences University','Budget/Accounting Analyst I','sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo','Buffalo','New York',14276);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (42,'Osaka Medical College','Office Assistant IV','convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia','Murfreesboro','Tennessee',37131);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (29,'Université d''Evry Val d''Essonne','Financial Advisor','ipsum primis in faucibus orci luctus et ultrices posuere cubilia','Chicago','Illinois',60636);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (51,'Universidad Tecnológica San Antonio de Machala','Design Engineer','feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce','Jacksonville','Florida',32230);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (25,'Université de Monastir','Account Executive','mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis','Saint Louis','Missouri',63104);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (52,'Anadolu University','Editor','in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque','Santa Cruz','California',95064);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (26,'Ibaraki Christian College','Occupational Therapist','primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam','Worcester','Massachusetts',01610);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (9,'Washington College','Cost Accountant','sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu','Topeka','Kansas',66667);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (10,'Guangxi University','Financial Advisor','in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in','Charleston','West Virginia',25362);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (39,'Christchurch Polytechnic Institute of Technology','Sales Associate','dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida','Lake Charles','Louisiana',70616);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (24,'Kokand State Pedagogical Institute','Biostatistician II','condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales','Flint','Michigan',48555);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (14,'Petronas Technology University','Environmental Tech','leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat','Schaumburg','Illinois',60193);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (44,'Humboldt Universität Berlin','Quality Control Specialist','nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque','Kansas City','Missouri',64144);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (21,'University of Basrah','Marketing Manager','proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie','Memphis','Tennessee',38143);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (51,'University of New Hampshire','Geologist IV','sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas','Oakland','California',94627);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (54,'National University of Music','Senior Editor','tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non','Fort Wayne','Indiana',46825);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (27,'Ecole Supérieure de Physique et de Chimie Industrielles','Safety Technician III','in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in','Charleston','West Virginia',25362);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (47,'Tokyo Dental College','Structural Engineer','nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt','Wilmington','Delaware',19886);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (20,'Fachhochschule Landshut, Hochschule für Wirtschaft - Sozialwesen - Technik','Civil Engineer','sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum','Plano','Texas',75074);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (16,'Shikoku University','Systems Administrator IV','morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue','San Antonio','Texas',78265);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (15,'University of Wamia and Masuria in Olsztyn','Graphic Designer','posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci','Newark','New Jersey',07112);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (33,'Allahabad Agricultural Institute, Deemed University','Actuary','luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante','Santa Fe','New Mexico',87505);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (13,'Syktyvkar State University','General Manager','rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis','Topeka','Kansas',66606);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (18,'Southern New Hampshire University','Legal Assistant','dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis','Raleigh','North Carolina',27658);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (54,'Toyama Medical and Pharmaceutical University','Mechanical Systems Engineer','varius ut blandit non interdum in ante vestibulum ante ipsum','Corpus Christi','Texas',78465);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (7,'Belarusian-Russian University','Administrative Officer','in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna','Boston','Massachusetts',02298);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (9,'Royal Free Hospital School of Medicine, University of London','VP Sales','id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit','North Hollywood','California',91606);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (20,'University for Peace','Staff Scientist','elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus','Wichita','Kansas',67220);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (43,'Konkuk University','Help Desk Technician','scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at','Omaha','Nebraska',68134);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (28,'Gollis University','Quality Control Specialist','lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam','Tallahassee','Florida',32314);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (37,'Portland Community College','Web Designer IV','egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget','Duluth','Minnesota',55805);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (1,'California School of Professional Psychology - Los Angels','Information Systems Manager','blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id','Little Rock','Arkansas',72209);
INSERT INTO Experience(psp_id,education,career,qualification,city,state,zip) VALUES (25,'University of Toronto','Programmer III','ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id','Des Moines','Iowa',50315);

#provider review
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (20,25,2,'Fusce consequat. Nulla nisl. Nunc nisl.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (55,29,2,'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (48,42,4,'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (46,25,4,'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (25,44,1,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (21,26,1,'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (1,51,3,'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (57,19,2,'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (40,44,4,'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (8,28,3,'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (20,19,3,'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (21,5,5,'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (20,15,4,'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (57,9,2,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (23,60,4,'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (33,25,4,'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (7,45,4,'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (23,27,1,'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (10,49,2,'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (33,7,4,'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (51,41,1,'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (40,6,3,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (27,18,2,'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (12,54,5,'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (60,51,5,'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (40,2,2,'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (51,4,2,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (37,57,4,'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (59,29,5,'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (3,38,2,'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (10,17,4,'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (46,16,5,'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (32,10,1,'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (25,20,5,'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (60,13,2,'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (43,47,1,'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (11,34,2,'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (55,22,2,'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (17,13,3,'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (48,38,2,'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (6,32,4,'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (22,30,2,'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (35,47,5,'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (22,43,2,'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (5,54,2,'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (10,47,1,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (56,26,3,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (17,25,4,'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (29,15,1,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (28,46,5,'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (2,2,5,'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (51,5,5,'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (43,25,4,'Fusce consequat. Nulla nisl. Nunc nisl.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (8,42,5,'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (60,43,1,'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (39,16,4,'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (18,3,3,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (54,45,1,'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (39,32,4,'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
INSERT INTO ProviderReview(psp_id,cust_id,rating,description) VALUES (46,18,3,'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');


# PreferredPetSpecies
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (20,13,0,18,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (23,41,1,3,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (35,34,1,25,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (57,54,1,11,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (39,28,1,26,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (53,24,0,29,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (33,31,1,17,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (48,9,0,6,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (44,50,1,3,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (26,30,0,18,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (16,11,0,10,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (44,32,0,21,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (21,46,0,25,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (54,19,1,25,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (31,17,0,16,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (17,4,0,7,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (15,36,1,23,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (10,37,0,28,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (4,19,1,20,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (42,9,0,16,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (46,28,0,27,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (33,43,0,16,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (3,50,1,29,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (46,37,0,8,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (32,43,1,3,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (7,20,1,20,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (45,7,1,26,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (38,13,1,19,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (15,55,1,7,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (14,60,0,16,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (42,51,0,29,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (41,46,1,7,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (13,26,1,1,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (50,3,1,13,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (32,12,1,6,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (17,16,0,26,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (58,31,0,25,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (22,14,0,21,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (28,48,0,30,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (17,31,1,12,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (25,23,1,27,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (6,10,0,25,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (34,34,0,4,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (45,53,1,28,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (7,60,1,16,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (40,28,1,7,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (49,10,1,24,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (13,23,0,9,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (55,23,1,10,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (25,1,0,8,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (47,25,1,14,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (33,23,0,23,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (26,6,1,23,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (47,50,0,7,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (8,48,1,15,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (36,10,1,12,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (54,40,1,30,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (25,34,0,8,1);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (53,39,1,5,0);
INSERT INTO PreferredPetSpecies(service_id,species_id,vaccination,age,sterilization) VALUES (33,1,1,11,1);


Create table Region(
Region_ID varchar(11) Primary Key, 
Region_Name varChar(8),
Region_Gen integer
);

Create table PType(
Type_ID varchar(10) Primary Key,
Type_Name varchar (8),
Type_Weakness varchar(8),
Type_Immune varchar(8)
);

Create table Pokemon(
Pokemon_ID char(3) Primary key,
Pokemon_Name varChar(20),
Pokemon_Category char(20),
Type_ID varchar(10),
Foreign key (Type_ID) references PType(Type_ID) On update cascade 
);

Create table NaturalHabitat( #IK foreign keys should aslo be primary for this table but I dont know hoe to write that so :P
Habitat_Name varchar(30),
Pokemon_ID char(3),
Region_ID varchar(11),
Foreign key (Pokemon_ID) references Pokemon(Pokemon_ID) on update cascade, 
Foreign key (Region_ID) references Region(Region_ID) on update cascade  
);

Create table Stats(
 Stat_Max integer, 
 Stat_Avg decimal(2,1),
 Pokemon_Nature char(11),
 Pokemon_ID char(3),
 #foreign key (Pokemon_Nature) references Pokemon(Pokemon_Nature) On update cascade, 
 foreign key (Pokemon_ID) references Pokemon(Pokemon_ID) on update cascade #primary key
 );

Create table Move(
Move_Name varchar(30) primary key,
Move_Stats varchar(11), 
Move_PP varchar(11)
 );
 
create table Classification(
Class_Type varchar(11),
Pokemon_ID char(3),
Type_ID varchar(10),
foreign key (Pokemon_ID) references Pokemon(Pokemon_ID) on update cascade, #(PK,FK1), 
foreign key (Type_ID) references PType(Type_ID) on update cascade #(PK,FK2), 
);

Create table Signature(
Signature_Type varchar(11),
Pokemon_ID char(3),
Move_Name varchar(30),
foreign key (Pokemon_ID) references Pokemon(Pokemon_ID) on update cascade, #(PK,FK)
foreign key (Move_Name) references Move(Move_Name) on update cascade #(PK,FK)
 );


INSERT INTO Region values("03", "Hoenn", 1);
INSERT INTO Region values("01", "Kanto", 1);
INSERT INTO Region values("NA", "Lab", 1);
INSERT INTO Region values("12", "Guiana", 1);
INSERT INTO Region values("09", null, null);

INSERT INTO PType values ("01", "fire", "water", "Fire"); #chose 1 weakness and one strength
INSERT INTO PType values ("17", "fire", "water", "grass"); 
INSERT INTO PType values ("00", "psychic", "ghost", "phychic");
INSERT INTO PType values ("10", "grass", "poison", "psychic");
INSERT INTO PType values ("13", "normal", "normal", "fighting");


#Inserting Vulpix 1 (Created)
INSERT INTO Pokemon VALUES("037", "Vulpix", "Fox", "01");
INSERT INTO Pokemon VALUES("007", "Squirtle", "Tiny Turtle", "17");
INSERT INTO Pokemon VALUES("004", "Charmander", "Lizard", "01");
INSERT INTO Pokemon VALUES("150", "Mewtwo", "Genetic", "00");
INSERT INTO Pokemon VALUES("001", "Bulbasaur", "Seed", "10");
INSERT INTO Pokemon VALUES("002", "Ivysaur", "Seed", "10");
INSERT INTO Pokemon VALUES("133", "Eevee", "Evolution", "13");
INSERT INTO Pokemon VALUES("132", "Ditto", "Transform", "13");
INSERT INTO Pokemon VALUES("151", "Mew", "New Species", "00");
INSERT INTO Pokemon VALUES("663", "TalonFlame", "Scorching", "01");


INSERT INTO NaturalHabitat Values( "Mt. Pyre Grass", "037", "03");
INSERT INTO NaturalHabitat Values( "Celadon City", "007", "01");
INSERT INTO NaturalHabitat Values( "Celadon City", "004", "03");
INSERT INTO NaturalHabitat Values( null, "150", null);
INSERT INTO NaturalHabitat Values( "Celadon City", "001", "03");
INSERT INTO NaturalHabitat Values( "Celadon City", "002", "NA");
INSERT INTO NaturalHabitat Values( "Celadon Mansion", "133", "03");
INSERT INTO NaturalHabitat Values( null, "132", null);
INSERT INTO NaturalHabitat Values( "Jungle", "151", "12");
INSERT INTO NaturalHabitat Values( null, "663", null);


INSERT INTO Stats values (3, 3.3, "Fox","037");
INSERT INTO Stats values (4, 3.3, "Tiny Turtle","007");
INSERT INTO Stats values ("4", "3.5", "Lizard","004");
INSERT INTO Stats values (10, 7.7, "Genetic","150");
INSERT INTO Stats values (3, 3.3, "Seed","002");
INSERT INTO Stats values (4, 4.3, "Seed","001");
INSERT INTO Stats values (4, 3.6, "Evolution","133");
INSERT INTO Stats values (10, 7.7, "Transform","132");
INSERT INTO Stats values (6, 6, "New Species","151");
INSERT INTO Stats values (8, 4.6, "Scorching","663");

INSERT INTO Move values("Flash Fire", 3, 1 ); #NGL im guessing on the pp part
INSERT INTO Move values("Torrent", 3, 1 ); 
INSERT INTO Move values("Blaze", 4, 1 ); 
INSERT INTO Move values("Pressure", 10, 1 ); 
INSERT INTO Move values("Overgrow", 4, 1 ); 
INSERT INTO Move values("Growl", 5, 1 ); 
INSERT INTO Move values("Adaptability", 0, 1 ); 
INSERT INTO Move values("Limber", 0, 1 ); 
INSERT INTO Move values("Synchronize", "New Species", 3 ); 
INSERT INTO Move values("Flame Body", 5, 6 ); 
 
INSERT INTO Classification values("fire", "037" , "01");
INSERT INTO Classification values("water", "007" , "17");
INSERT INTO Classification values("fire", "004" , "01");
INSERT INTO Classification values("psychic", "150" , "00");
INSERT INTO Classification values("grass", "002" , "10");
INSERT INTO Classification values("grass", "001" , "10");
INSERT INTO Classification values("normal", "133" , "13");
INSERT INTO Classification values("normal", "132" , "13");
INSERT INTO Classification values("psychic", "151" , "00");
INSERT INTO Classification values("airfire", "663" , "01");

INSERT INTO Signature values("flame", "037","Flash Fire");
INSERT INTO Signature values("splash", "007","Torrent");
INSERT INTO Signature values("flame", "004","Blaze");
INSERT INTO Signature values("psy", "150","Pressure");
INSERT INTO Signature values("toxicgrass", "002","Overgrow");
INSERT INTO Signature values("toxicgrass", "001","Overgrow");
INSERT INTO Signature values("evo", "133","Adaptability");
INSERT INTO Signature values("copy", "132","Limber");
INSERT INTO Signature values("psy", "151","Synchronize");
INSERT INTO Signature values("scorch", "663","Flame Body");


#Querys 

# Query 1: Find the name of the pokemon with the highest stat_max
select Pokemon_Name, max(stat_max) from Pokemon
natural join Stats;

# Query 2: Count the number of fire pokemon
select count(Pokemon_ID) from Pokemon
natural join 
PType
where Type_Name = "fire";

# Query 3: Finds Pokemon with the max stat higher than a pokemon selected
SELECT Pokemon.Pokemon_ID, Pokemon_Name, Stat_Max
From Pokemon, Stats
where Pokemon.Pokemon_ID = Stats.Pokemon_ID AND Stat_Max >
(SELECT Stat_Max
From Stats
Where Pokemon_ID = '001');


# Query 4: Find the one or multiple Pokemon with the Avg_stats no greater than 5
select Pokemon_Name, Stat_Avg from Pokemon
natural join
Stats
Group by Pokemon_Name
Having Stat_Avg <= 5.0;

# Query 5: Find the Pokemon_ID belonging to the pokemon who dont have a natural habitat
SELECT Pokemon.Pokemon_ID
FROM NaturalHabitat
LEFT JOIN Pokemon
ON NaturalHabitat.Pokemon_ID = Pokemon.Pokemon_ID
WHERE Habitat_Name is null;
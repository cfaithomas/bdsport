create table equipe(id int,nom varchar(255) not null ,constraint pk primary key (id));
create table joueur(numero int,nom varchar(255) not null ,prenom varchar(255) not null
,constraint primary key(numero),idequipe int,
constraint foreign key(idequipe) references equipe(id));
create table partie(id int,lieu varchar(255) not null,constraint primary key(id));
create table jouer(ide int,idp int,date date,constraint primary key (ide,idp),
constraint foreign key(idp) references partie(id),constraint foreign key(ide) references
equipe(id));
insert into equipe values(1,'les fumeurs');
insert into sn2.joueur values(1,'Platini','Michel',1);
insert into sn2.joueur values(2,'Girese','Alain',1);
insert into sn2.joueur values(3,'Zinedine','Zidane',1);
insert into equipe values(2,'les vainqueurs');
insert into sn2.joueur values(4,'Rocheteau','Dominique',2);
insert into sn2.joueur values(5,'Bossis','Maxime',2);
insert into sn2.joueur values(6,'Bolli','Basile',2);
insert into sn2.partie values(1,'Nantes');
insert into sn2.partie values (2,'Dijon');
insert into jouer values(1,2,'2019-03-02');
insert into jouer values(1,2,'2019-09-09');
insert into jouer values(1,2,'2019-10-10');
insert into jouer values(1,1,'2019-12-10');
insert into jouer values(2,2,'2014-03-02');
insert into jouer values(2,2,'2014-09-09');
insert into jouer values(2,2,'2014-10-10');
alter table jouer add constraint primary key (ide,idp,date);
alter table jouer add constraint foreign key(ide) references equipe(id);
alter table sn2.jouer add constraint foreign key(idp) references partie(id);
select numero,nom,prenom from sn2.joueur;
#les joueurs de l'equipe 1
select * from sn2.joueur where idequipe=1;
#les joueurs dont le nom commence par b et le prenom  fini par e
select * from sn2.joueur where nom like 'b%' and prenom like '%e';
#les noms des joueurs de l'équipe n°2 triés par ordre alphabétique
select nom from joueur where idequipe=2 order by nom asc;
# le nom de l'équipe de basile bolli
select equipe.nom from equipe join joueur on equipe.id = joueur.idequipe
where joueur.nom='Bolli' and joueur.prenom='Basile';
# Toutes les dates auxquelles a joué l'équipe n°2
select date from jouer join equipe on jouer.ide = equipe.id where equipe.id=2
order by date desc;
#Toutes les dates auxquelles a joué l'équipe n°2 à Dijon
select date from jouer join equipe on jouer.ide = equipe.id join
    sn2.partie on partie.id=jouer.idp where equipe.id=2 and partie.lieu='Dijon';
#le nombre de match auquel a participé l'équipe n°2
select count(*) from jouer where ide=2;
#combien de fois a joué l'équipe n°1 à Dijon
select count(ide) from sn2.jouer join sn2.partie on jouer.idp = partie.id
where lieu='Dijon' and ide=1;
#le nombre de joueurs par équipe
select equipe.nom,count(numero) from joueur join equipe on joueur.idequipe = equipe.id
group by equipe.nom;
#le nombre de parties pour chaque lieu
select partie.lieu,count(*) as nbparticipation from jouer join sn2.partie on jouer.idp=partie.id
group by partie.lieu;
#le nombre de parties >5 pour chaque lieu
select partie.lieu,count(*) as nbparticipation from jouer join sn2.partie on jouer.idp=partie.id
group by partie.lieu having nbparticipation>5;
#les joueurs ayant participé au moins à deux parties
select joueur.nom,joueur.prenom from joueur join equipe as e on joueur.idequipe = e.id
    join jouer as j on e.id = j.ide
group by joueur.numero having count(*)>=2;
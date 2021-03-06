DROP TABLE IF EXISTS project_type;
DROP TABLE IF EXISTS project_nfa;
DROP TABLE IF EXISTS project_stakeholder;
DROP TABLE IF EXISTS stakeholder_factor;

DROP TABLE IF EXISTS stakeholder;
DROP TABLE IF EXISTS nfa_project;
DROP TABLE IF EXISTS metric_nfa;

DROP TABLE IF EXISTS type;

DROP TABLE IF EXISTS custom_nfa;
DROP TABLE IF EXISTS nfa;

DROP TABLE IF EXISTS criteria_metric;
DROP TABLE IF EXISTS metric;

DROP TABLE IF EXISTS factor_criteria;
DROP TABLE IF EXISTS nfa_factor;
DROP TABLE IF EXISTS nfa_criteria;

DROP SEQUENCE IF EXISTS project_sequence;
CREATE SEQUENCE project_sequence START 5; 

--  Start at 500 to make sure its after every NFA
DROP SEQUENCE IF EXISTS nfa_sequence;
CREATE SEQUENCE nfa_sequence START 500;

CREATE TABLE public.nfa_project
(
  ID serial PRIMARY KEY,
  NFA_PROJECT_NUMBER character varying(40),
  CUSTOMER_NAME character varying(40),
  CONTACT_PERS_CUSTOMER character varying(40),
  CONTACT_PERS_MSG character varying(40),
  BRANCH character varying(40),
  DEVELOPMENT_PROCESS character varying(40),
  PROJECT_PHASE character varying(40),
  PROJECT_STATUS character varying(40)
);
INSERT INTO nfa_project VALUES (1,'1234','ArbeitAgentur','Tom','Alex','Public Sector','Agile','None','On Process');
INSERT INTO nfa_project VALUES (2,'1234','XYZ','Bob','Alex','Public Sector','Classic','Specification Sheet','Archived');
INSERT INTO nfa_project VALUES (3,'1234','ABC','John','Alex','Public Sector','Agile','None','On Process');
INSERT INTO nfa_project VALUES (4,'1234','ASDF','Andre','Alex','Public Sector','Classic','Requirements Specification','Archived');


CREATE TABLE public.stakeholder (
  stakeholder_id bigserial NOT NULL,
  stakeholder_name varchar(45) NOT NULL,
  PRIMARY KEY (stakeholder_id)
);


CREATE TABLE public.project_stakeholder
(
    project_id serial NOT NULL,
    stakeholder_id serial NOT NULL,
    CONSTRAINT project_fk FOREIGN KEY (project_id)
        REFERENCES public.nfa_project (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT stakeholder_fk FOREIGN KEY (stakeholder_id)
        REFERENCES public.stakeholder (stakeholder_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE public.type
(
    id bigserial NOT NULL,
    name character varying(100),
    PRIMARY KEY (id)
);

INSERT INTO public.type VALUES (1,'Communication Project');
INSERT INTO public.type VALUES (2,'Data Exchange Project');	

CREATE TABLE public.project_type
(
    project_id serial NOT NULL,
    type_id serial NOT NULL,
    CONSTRAINT project_fk FOREIGN KEY (project_id)
        REFERENCES public.nfa_project (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT type_fk FOREIGN KEY (type_id)
        REFERENCES public.type (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

INSERT INTO public.project_type VALUES (1,1);
INSERT INTO public.project_type VALUES (1,2);
INSERT INTO public.project_type VALUES (2,2);
INSERT INTO public.project_type VALUES (3,1);
INSERT INTO public.project_type VALUES (4,2);


--------------------------------------------------------------
/*                 NFA CATALOG STUFF                        */
--------------------------------------------------------------

CREATE TABLE public.nfa_factor
(
	factor_id serial PRIMARY KEY,
	factor varchar(45) NOT NULL
);

CREATE TABLE public.nfa_criteria
(
	criteria_id serial PRIMARY KEY,
	criteria_num int NOT NULL,
	criteria varchar(80) NOT NULL
);


CREATE TABLE public.factor_criteria
(
    factor_id serial NOT NULL,
    criteria_id serial NOT NULL,
    CONSTRAINT factor_fk FOREIGN KEY (factor_id)
        REFERENCES public.nfa_factor (factor_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT criteria_fk FOREIGN KEY (criteria_id)
        REFERENCES public.nfa_criteria (criteria_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	PRIMARY KEY(factor_id, criteria_id)
);

-- 1	Effektivit??t
INSERT INTO nfa_factor VALUES (1,'Effektivit??t');
INSERT INTO nfa_criteria VALUES (43,1, 'Effektivit??t');
INSERT INTO public.factor_criteria VALUES (1,43);
-- 2	Effizienz
INSERT INTO nfa_factor VALUES (2,'Effizienz');
INSERT INTO nfa_criteria VALUES (44,1, 'Effizienz');
INSERT INTO public.factor_criteria VALUES (2,44);
-- 3	Zufriedenheit
INSERT INTO nfa_factor VALUES (3,'Zufriedenheit');

INSERT INTO nfa_criteria VALUES (1,1, 'Zufriedenheit');
INSERT INTO nfa_criteria VALUES (2,2, 'N??tzlichkeit');
INSERT INTO nfa_criteria VALUES (3,3, 'Vertrauen');
INSERT INTO nfa_criteria VALUES (4,4, 'Freude im Umgang mit dem Systems');
INSERT INTO nfa_criteria VALUES (5,5, 'Komfort');

INSERT INTO public.factor_criteria VALUES (3,1);
INSERT INTO public.factor_criteria VALUES (3,2);
INSERT INTO public.factor_criteria VALUES (3,3);
INSERT INTO public.factor_criteria VALUES (3,4);
INSERT INTO public.factor_criteria VALUES (3,5);

-- 4	Risikofreiheit
INSERT INTO nfa_factor VALUES (4,'Risikofreiheit');

INSERT INTO nfa_criteria VALUES (6, 1, 'Verringerung der ??konomischen Risiken');
INSERT INTO nfa_criteria VALUES (7, 2, 'Verringerung der Risiken hinsichtlich Gesundheit und Sicherheit');
INSERT INTO nfa_criteria VALUES (8, 3, 'Verringerung der Umweltrisiken');

INSERT INTO public.factor_criteria VALUES (4,6);
INSERT INTO public.factor_criteria VALUES (4,7);
INSERT INTO public.factor_criteria VALUES (4,8);

-- 5	Umgebungsabdeckung
INSERT INTO nfa_factor VALUES (5,'Umgebungsabdeckung');

INSERT INTO nfa_criteria VALUES (9 ,1, 'Komplette Abdeckung aller Umgebungsanforderungen');
INSERT INTO nfa_criteria VALUES (10,2, 'Flexibilit??t');

INSERT INTO public.factor_criteria VALUES (5, 9);
INSERT INTO public.factor_criteria VALUES (5, 10);
	
-- 6	Funktionale Eignung
INSERT INTO nfa_factor VALUES (6,'Funktionale Eignung');

INSERT INTO nfa_criteria VALUES (11, 1, 'Funktionale Vollst??ndigkeit');
INSERT INTO nfa_criteria VALUES (12, 2, 'Funktionale Korrektheit');
INSERT INTO nfa_criteria VALUES (13, 3, 'Funktionale Angemessenheit');

INSERT INTO public.factor_criteria VALUES (6, 11);
INSERT INTO public.factor_criteria VALUES (6, 12);
INSERT INTO public.factor_criteria VALUES (6, 13);

-- 7	Leistungseffizienz
INSERT INTO nfa_factor VALUES (7,'Leistungseffizienz');

INSERT INTO nfa_criteria VALUES (14 , 1, 'Zeitverhalten');
INSERT INTO nfa_criteria VALUES (15 , 2, 'Ressourcennutzung');
INSERT INTO nfa_criteria VALUES (16 , 3, 'Kapazit??t');

INSERT INTO public.factor_criteria VALUES (7, 14);
INSERT INTO public.factor_criteria VALUES (7, 15);
INSERT INTO public.factor_criteria VALUES (7, 16);

-- 8	Kompatibilit??t
INSERT INTO nfa_factor VALUES (8,'Kompatibilit??t');

INSERT INTO nfa_criteria VALUES (17, 1, 'Koexistenz');
INSERT INTO nfa_criteria VALUES (18, 2, 'Interoperabilit??t');

INSERT INTO public.factor_criteria VALUES (8, 17);
INSERT INTO public.factor_criteria VALUES (8, 18);

-- 9	Usability
INSERT INTO nfa_factor VALUES (9,'Usability');

INSERT INTO nfa_criteria VALUES (19, 1, 'Erkennbarkeit der Eignung');
INSERT INTO nfa_criteria VALUES (20, 2, 'Lernf??higkeit');
INSERT INTO nfa_criteria VALUES (21, 3, 'Bedienbarkeit');
INSERT INTO nfa_criteria VALUES (22, 4, 'Schutz der Nutzer, Fehler zu begehen');
INSERT INTO nfa_criteria VALUES (23, 5, '??sthetik des User-Interfaces');
INSERT INTO nfa_criteria VALUES (24, 6, 'Erreichbarkeit');

INSERT INTO public.factor_criteria VALUES (9, 19);
INSERT INTO public.factor_criteria VALUES (9, 20);
INSERT INTO public.factor_criteria VALUES (9, 21);
INSERT INTO public.factor_criteria VALUES (9, 22);
INSERT INTO public.factor_criteria VALUES (9, 23);
INSERT INTO public.factor_criteria VALUES (9, 24);

-- 10	Zuverl??ssigkeit
INSERT INTO nfa_factor VALUES (10,'Zuverl??ssigkeit');

INSERT INTO nfa_criteria VALUES (25, 1, 'Reife');
INSERT INTO nfa_criteria VALUES (26, 2, 'Verf??gbarkeit');
INSERT INTO nfa_criteria VALUES (27, 3, 'Fehlertoleranz');
INSERT INTO nfa_criteria VALUES (28, 4, 'Wiederherstellbarkeit');

INSERT INTO public.factor_criteria VALUES (10, 25);
INSERT INTO public.factor_criteria VALUES (10, 26);
INSERT INTO public.factor_criteria VALUES (10, 27);
INSERT INTO public.factor_criteria VALUES (10, 28);

-- 11	Sicherheit
INSERT INTO nfa_factor VALUES (11,'Sicherheit');

INSERT INTO nfa_criteria VALUES (29, 1, 'Vertraulichkeit');
INSERT INTO nfa_criteria VALUES (30, 2, 'Integrit??t');
INSERT INTO nfa_criteria VALUES (31, 3, 'Nicht-Ablehnung');
INSERT INTO nfa_criteria VALUES (32, 4, 'Rechenschaft');
INSERT INTO nfa_criteria VALUES (33, 5, 'Authentizit??t');

INSERT INTO public.factor_criteria VALUES (11, 29);
INSERT INTO public.factor_criteria VALUES (11, 30);
INSERT INTO public.factor_criteria VALUES (11, 31);
INSERT INTO public.factor_criteria VALUES (11, 32);
INSERT INTO public.factor_criteria VALUES (11, 33);

-- 12	Wartbarkeit
INSERT INTO nfa_factor VALUES (12,'Wartbarkeit');

INSERT INTO nfa_criteria VALUES (34, 1, 'Modularit??t');
INSERT INTO nfa_criteria VALUES (35, 2, 'Wiederverwendbarkeit');
INSERT INTO nfa_criteria VALUES (36, 3, 'Analysierbarkeit');
INSERT INTO nfa_criteria VALUES (37, 4, 'Modifizierbarkeit');
INSERT INTO nfa_criteria VALUES (38, 5, 'Stabilit??t');
INSERT INTO nfa_criteria VALUES (39, 6, 'Testbarkeit');

INSERT INTO public.factor_criteria VALUES (12, 34);
INSERT INTO public.factor_criteria VALUES (12, 35);
INSERT INTO public.factor_criteria VALUES (12, 36);
INSERT INTO public.factor_criteria VALUES (12, 37);
INSERT INTO public.factor_criteria VALUES (12, 38);
INSERT INTO public.factor_criteria VALUES (12, 39);

-- 13	??bertragbarkeit
INSERT INTO nfa_factor VALUES (13,'??bertragbarkeit');

INSERT INTO nfa_criteria VALUES (40, 1, 'Anpassbarkeit');
INSERT INTO nfa_criteria VALUES (41, 2, 'Installierbarkeit');
INSERT INTO nfa_criteria VALUES (42, 3, 'Ersetzbarkeit');

INSERT INTO public.factor_criteria VALUES (13, 40);
INSERT INTO public.factor_criteria VALUES (13, 41);
INSERT INTO public.factor_criteria VALUES (13, 42);

CREATE TABLE public.metric
(
	ID serial PRIMARY KEY,
	METRIC_NUMBER int NOT NULL,
	BEZEICHNUNG character varying(100),
	FORMEL character varying(500),
	INTERPRETATION character varying(500),
	ERKLAERUNG_MESSGROESSE character varying(500)
);

INSERT INTO metric VALUES (1,1,'Effektivit??t der Arbeit','{X = 1-??Ai | X???0}; Ai = Anteiliger Wert von jedem fehlenden oder fehlerhaften Ziel am Ende der Arbeit (maximaler Wert = 1)','{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.','Wie genau das spezifizierte Ziel erreicht ist. Hierbei wird die Anzahl der exakt vollendeten Aufgaben mit Gesamtanzahl aller Aufgaben verglichen.');
INSERT INTO metric VALUES (2,2,'Fehler bei der Arbeit','X = A; A = Anzahl der Fehler','{X | 0 < X}; Je kleiner der Wert ist, desto besser.','Wie hoch die Anzahl der Fehler ist. Hierbei wird die Anzahl der Fehler gemessen.');
INSERT INTO metric VALUES (3,3,'Fehlerhafte Arbeit','X = A/B; A = Anzahl der fehlerhaften Aufgaben; B = Gesamtzahl an Aufgaben','{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.','Bei wie vielen Aufgaben Fehler gemacht wurden. Hierbei wird die Anzahl der fehlerhaften Aufgaben mit der Gesamtzahl aller Aufgaben verglichen');
INSERT INTO metric VALUES (4,4,'Fehlerintensit??t','X = A/B; A = Anzahl der Nutzer, die einen Fehler gemacht haben; B = Gesamtzahl der Nutzer, die eine Aufgabe durchf??hren','{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.','Wie viele Nutzer einen Fehler gemacht haben. Hierbei wird die Anzahl der Nutzer, die einen Fehler gemacht haben, mit der Gesamtzahl der Nutzer, die eine Aufgabe durchf??hren, verglichen.');

-- 4	Risikofreiheit
INSERT INTO metric VALUES (5,1,'Einnahmen durch den einzelnen Kunden','X = A; A = Einnahmen durch den einzelnen Kunden','{X | 0 ??? X < ???}; Je gr????er der Wert ist, desto besser.','Wie hoch die Einnahmen durch den einzelnen Kunden sind. Hierbei werden die Einnahmen jedes einzelnen Kunden gemessen, wobei anhand von verschiedenen Kundenmerkmalen M??glichkeiten zur Systemevaluierung f??r bestimmte Nutzergruppen abgeleitet werden k??nnen.');
INSERT INTO metric VALUES (6,1,'H??ufigkeit an krankheitsbedingten Ausf??llen der Nutzer','X = A/B; A = Anzahl der Nutzer, die von gesundheitlichen Beschwerden auf Grund der Nutzung berichten; B = Gesamtzahl aller Nutzer','{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.','Wie gro?? der Anteil an Nutzern eines Produkts oder Systems ist, die von gesundheitlichen Beschwerden auf Grund der Nutzung berichten. Hierbei wird die Anzahl an Nutzern, die von gesundheitlichen Beschwerden auf Grund der Nutzung berichten, mit der Gesamtzahl aller Nutzer verglichen, wobei die Berechnung anhand der Nutzungsdauer gewichtet werden kann.');
INSERT INTO metric VALUES (7,2,'Auswirkung auf Gesundheit und Sicherheit f??r den Nutzer','n = Anzahl der betroffenen Nutzer; Tai = Dauer, f??r die der ite Nutzer betroffen ist; Si = Grad der Auswirkung f??r den iten Nutzer; L??nge der Zeit von Beginn der Systemnutzung an','{X | 0 ??? X}; Je kleiner der Wert ist, desto besser.','Wie gro?? die Auswirkung auf Gesundheit und Sicherheit der Nutzer eines Produkts oder Systems ist. Hierbei wird die Summe aus den mulitplizierten Faktoren L??nge und Grad der Auswirkung mit der L??nge der Zeit von Beginn der Systemnutzung an verglichen.');
INSERT INTO metric VALUES (8,3,'Anteil der Sicherheitsgef??hrdungen','X = A/B; A = Anzahl der Nutzer, die gef??hrdet wurden; B = Gesamtzahl der Nutzer, die gef??hrdet werden k??nnten','{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.','Wie gro?? die Sicherheitsrisiken f??r die Nutzer des Systems gemessen an der Gesamtzahl der potentiell gef??hrdeten Nutzer sind. Hierbei wird die Anzahl der Nutzer, die gef??hrdet wurden, mit der Gesamtzahl der Nutzer, die gef??hrdet werden k??nnten, verglichen.');



CREATE TABLE public.criteria_metric
(
    criteria_id serial NOT NULL,
	metric_id serial NOT NULL,
    CONSTRAINT criteria_fk FOREIGN KEY (criteria_id)
        REFERENCES public.nfa_criteria (criteria_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	CONSTRAINT metric_fk FOREIGN KEY (metric_id)
        REFERENCES public.metric (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	PRIMARY KEY( criteria_id, metric_id)
);
INSERT INTO public.criteria_metric VALUES (43, 1);
INSERT INTO public.criteria_metric VALUES (43, 2);
INSERT INTO public.criteria_metric VALUES (43, 3);
INSERT INTO public.criteria_metric VALUES (43, 4);

INSERT INTO public.criteria_metric VALUES (6, 5);
INSERT INTO public.criteria_metric VALUES (7, 6);
INSERT INTO public.criteria_metric VALUES (7, 7);
INSERT INTO public.criteria_metric VALUES (7, 8);

CREATE TABLE public.nfa
(
 nfa_id serial PRIMARY KEY,
 NFA_NUMBER int NOT NULL,
 NFA_TYPE character varying(40),
 LEGAL_LIABILITY character varying(40),
 VALUE character varying(200),
 FORMULATION character varying(40),
 REFERENCE character varying(40),
 REFERENCED_PROJECTS character varying(40),
 CRITICALITY character varying(40),
 DOCUMENT character varying(40),    
 BLUEPRINT character varying(500));
 

INSERT INTO nfa VALUES (2,1,'Type:1','Verbindlichkeit:1','[12.22]','Formulierung:1','JUAC','CbCR','kritikalitaet', 'document1', '{"de":{"bezeichnung":"Qualit??t der Arbeit","erklaerung":"Das System muss dem bzw. der Anwender_in dabei unterst??tzen, ihre bzw. seine Aufgaben mit hoher Qualit??t, Genauigkeit und Effizienz zu erledigen."}, "en":{"bezeichnung":null,"erklaerung":null}}');
INSERT INTO nfa VALUES (3,1,'Type:1','Verbindlichkeit:1','[12.22]','Formulierung:1','','','kritikalitaet', 'document1', '{"de":{"bezeichnung":"Fehleranteil","erklaerung":"Die Anzahl der Fehler darf nicht h??her sein als 0,1% aller durchgef??hrten Operationen eines bzw. einer Anwender_in im System."}, "en":{"bezeichnung":null,"erklaerung":null}}');
INSERT INTO nfa VALUES (4,1,'Type:1','Verbindlichkeit:1','[12.22]','Formulierung:1','referenz:1','referenzierte_projekt:1','kritikalitaet', 'document1', '{"de":{"bezeichnung":"Entstehende Fehler","erklaerung":"Bei der Bearbeitung von Aufgaben mit dem System sollen m??glichst keine Fehler entstehen."}, "en":{"bezeichnung":null,"erklaerung":null}}');
INSERT INTO nfa VALUES (5,1,'Type:1','Verbindlichkeit:1','[12.22]','Formulierung:1','referenz:1','referenzierte_projekt:1','kritikalitaet', 'document1', '{"de":{"bezeichnung":"Fehlerfreie Bedienung","erklaerung":"Der bzw. die Anwender_in muss das System m??glichst fehlerfrei bedienen k??nnen."}, "en":{"bezeichnung":null,"erklaerung":null}}');


CREATE TABLE public.custom_nfa
(
 custom_id serial PRIMARY KEY,
 nfa_id serial NOT NULL,
 project_id serial NOT NULL,
 VALUE character varying(200),
 FORMULATION character varying(40),
 REFERENCE character varying(40), 
 CRITICALITY character varying(40),
 DOCUMENT character varying(40),
 BLUEPRINT character varying(500)
);

CREATE TABLE public.metric_nfa
(
    metric_id serial NOT NULL,
	nfa_id serial NOT NULL,
    CONSTRAINT metrik_fk FOREIGN KEY (metric_id)
        REFERENCES public.metric (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	CONSTRAINT nfa_fk FOREIGN KEY (nfa_id)
        REFERENCES public.nfa (nfa_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	PRIMARY KEY( metric_id, nfa_id)
);

INSERT INTO public.metric_nfa VALUES (1, 2);
INSERT INTO public.metric_nfa VALUES (2, 3);
INSERT INTO public.metric_nfa VALUES (3, 4);
INSERT INTO public.metric_nfa VALUES (4, 5);

CREATE TABLE public.project_nfa
(
    project_id serial NOT NULL,
	nfa_id serial NOT NULL,
    CONSTRAINT project_fk FOREIGN KEY (project_id)
        REFERENCES public.nfa_project (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	CONSTRAINT nfa_fk FOREIGN KEY (nfa_id)
        REFERENCES public.nfa (nfa_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	PRIMARY KEY( project_id, nfa_id)
);

INSERT INTO public.project_nfa VALUES (1, 2);
INSERT INTO public.project_nfa VALUES (2, 3);
INSERT INTO public.project_nfa VALUES (3, 4);
INSERT INTO public.project_nfa VALUES (4, 5);

CREATE TABLE public.stakeholder_factor
(
    stakeholder_id serial NOT NULL,
    factor_id      serial NOT NULL,
    CONSTRAINT stakeholder_fk FOREIGN KEY (stakeholder_id)
        REFERENCES public.stakeholder (stakeholder_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT factor_fk FOREIGN KEY (factor_id)
        REFERENCES public.nfa_factor (factor_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

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
INSERT INTO nfa_project VALUES (1,'1234','Project 1',' ','Muller','Public Sector','Agile','None','On Process');
INSERT INTO nfa_project VALUES (2,'1234','Project 2',' ','Maxmillien','Public Sector','Classic','Specification Sheet','Archived');
INSERT INTO nfa_project VALUES (3,'1234','Project 3',' ','Alex','Public Sector','Agile','None','On Process');
INSERT INTO nfa_project VALUES (4,'1234','Project 4',' ','Gerhard','Public Sector','Classic','Requirements Specification','Archived');
INSERT INTO nfa_project VALUES (5,'1234','Project 5',' ','Juergen','Public Sector','Agile','None','On Process');
INSERT INTO nfa_project VALUES (6,'1234','Project 6',' ','Schmeidel','Public Sector','Classic','Specification Sheet','Archived');
INSERT INTO nfa_project VALUES (7,'1234','Project 7',' ','Michael','Public Sector','Agile','None','On Process');



CREATE TABLE public.stakeholder (
  stakeholder_id bigserial NOT NULL,
  stakeholder_name varchar(45) NOT NULL,
  PRIMARY KEY (stakeholder_id)
);

INSERT INTO public.stakeholder( stakeholder_name) VALUES ('Stakeholder1');
INSERT INTO public.stakeholder( stakeholder_name) VALUES ('Stakeholder2');
INSERT INTO public.stakeholder( stakeholder_name) VALUES ('Stakeholder3');
INSERT INTO public.stakeholder( stakeholder_name) VALUES ('Stakeholder4');
INSERT INTO public.stakeholder( stakeholder_name) VALUES ('Stakeholder5');

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

INSERT INTO public.project_stakeholder(project_id, stakeholder_id) VALUES (1,1);
INSERT INTO public.project_stakeholder(project_id, stakeholder_id) VALUES (2,2);
INSERT INTO public.project_stakeholder(project_id, stakeholder_id) VALUES (3,3);
INSERT INTO public.project_stakeholder(project_id, stakeholder_id) VALUES (4,4);
INSERT INTO public.project_stakeholder(project_id, stakeholder_id) VALUES (5,5);

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
	factor varchar(45) NOT NULL,
	erklarung varchar(500)
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
	BEZEICHNUNG character varying(300),
	FORMEL character varying(500),
	INTERPRETATION character varying(500),
	ERKLAERUNG_MESSGROESSE character varying(500)
);


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
 BLUEPRINT character varying(1000));
 


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






---------------update factors explanation 
UPDATE nfa_factor SET erklarung = 'enauigkeit und Vollst??ndigkeit, mit dem ein Nutzer spezifische Ziele erreicht' 	WHERE factor_id =	1	;
UPDATE nfa_factor SET erklarung = 'Ressourcen, die in Bezug auf die Genauigkeit und Vollst??ndigkeit, mit denen die Nutzer Ziele erreichen - aufgewendet werden - relevante Ressourcen k??nnen Zeit zur Komplettierung der Aufgabe (menschliche Ressourcen), Materialien oder die finanziellen Kosten der Nutzung beinhalten' 	WHERE factor_id =	2	;
UPDATE nfa_factor SET erklarung = 'Grad, zu dem ein Nutzer mit der wahrgenommenen Erreichung von Programmierzielen inklusive der Ergebnisse und den Auswirkungen der Nutzung zufrieden ist' WHERE factor_id =	3	;
UPDATE nfa_factor SET erklarung = 'Grad, zu dem die Qualit??t eines Produkts oder Systems, potentielle Risiken dem Nutzer gegen??ber mindert.'	WHERE factor_id =	4	;
UPDATE nfa_factor SET erklarung = 'Grad, zu dem ein Produkt oder System sowohl innerhalb als auch au??erhalb der definierten Nutzungsumgebungen effektiv, effizient, zufriedenstellend und frei von Risiken genutzt werden kann.'	WHERE factor_id =	5	;
UPDATE nfa_factor SET erklarung = 'Grad, zu dem ein Produkt oder System die Bed??rfnisse, die festgelegt und vorausgesetzt wurden, zur Verf??gung stellt, wenn sie unter spezifischen Bedingungen genutzt werden.'	WHERE factor_id =	6	;
UPDATE nfa_factor SET erklarung = 'Leistungsgrad bez??glich der Menge an Ressourcen, die unter festgelegten Umst??nden genutzt werden' WHERE factor_id =	7	;
UPDATE nfa_factor SET erklarung = 'Grad, zu dem ein Produkt, ein System oder eine Komponente beim Teilen der selben Hardware- oder Softwareumgebung Informationen mit anderen Produkten, Systemen oder Komponenten austauschen kann und/oder seine/ihre ben??tigten Funktionen ausf??hren kann' WHERE factor_id =	8	;
UPDATE nfa_factor SET erklarung = 'Grad, zu dem ein Produkt oder System von einem spezifischen Nutzer zur effektiven, effizienten und innerhalb einer Nutzungsumgebung zufriedenstellenden Zielerreichung genutzt werden kann'	WHERE factor_id =	9	;
UPDATE nfa_factor SET erklarung = 'Grad, zu dem ein Produkt, ein System oder eine Komponente spezifische Funktionen unter spezifischen Bedingungen innerhalb einer spezifische Zeitperiode ausf??hrt' WHERE factor_id =	10	;
UPDATE nfa_factor SET erklarung = 'Grad, zu dem ein Produkt oder System Informationen und Daten so sch??tzt, dass f??r Nutzer, andere Produkte oder Systeme ein angemessener Grad an Datenzugriff gem???? ihrer Autorisierungstypen und -levels vorherrscht' WHERE factor_id =	11	;
UPDATE nfa_factor SET erklarung = 'Grad an Effektivit??t und Effizienz, mit dem ein Produkt oder System durch den vorgesehenen Warter modifiziert werden kann' WHERE factor_id =	12	;
UPDATE nfa_factor SET erklarung = 'Grad an Effektivit??t und Effizienz mit dem ein Produkt, ein System oder eine Komponente von einer Hardware, Software oder einer anderen Betriebs- oder Nutzungsumgebung auf eine andere ??bertragen werden kann' WHERE factor_id =	13	;

-------------------------insert metrics 
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	2  , 'Vollst??ndigkeit der Arbeit'  , 'In welchem Umfang die Aufgaben durch einen Nutzer oder einer Nutzergruppe in Bezug auf die in den Anforderungen identifizierten oder vom Nutzer angestrebten Aufgaben erledigt sind. Hierbei wird die Anzahl der erledigten Aufgaben mit der Anzahl der angestrebten Aufgaben verglichen.'  , 'X = A/B; A = Anzahl der einzigartigen Aufgaben, die abgeschlossen wurden; B = Gesamtzahl der angestrebten Aufgaben; bei verschiedener Komplexit??t der Aufgaben: = ?? (i=1..n) Wi ?? Ai/B; i = Anzahl der Aufgben; Wi = Schwierigkeit der Aufgabe bei einer Summe von 1,00'  , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	3  , 'Fehler bei der Arbeit'  , 'Wie hoch die Anzahl der Fehler ist. Hierbei wird die Anzahl der Fehler gemessen.'  , 'X = A; A = Anzahl der Fehler'  , '{X | 0 < X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	4  , 'Fehlerhafte Arbeit'  , 'Bei wie vielen Aufgaben Fehler gemacht wurden. Hierbei wird die Anzahl der fehlerhaften Aufgaben mit der Gesamtzahl aller Aufgaben verglichen'  , 'X = A/B; A = Anzahl der fehlerhaften Aufgaben; B = Gesamtzahl an Aufgaben'  , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1  , 'Effektivit??t der Arbeit'  , 'Wie genau das spezifizierte Ziel erreicht ist. Hierbei wird die Anzahl der exakt vollendeten Aufgaben mit Gesamtanzahl aller Aufgaben verglichen.'  , '{X = 1-??Ai | X???0}; Ai = Anteiliger Wert von jedem fehlenden oder fehlerhaften Ziel am Ende der Arbeit (maximaler Wert = 1)'  , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	5   , 'Fehlerintensit??t'  , 'Wie viele Nutzer einen Fehler gemacht haben. Hierbei wird die Anzahl der Nutzer, die einen Fehler gemacht haben, mit der Gesamtzahl der Nutzer, die eine Aufgabe durchf??hren, verglichen.'  , 'X = A/B; A = Anzahl der Nutzer, die einen Fehler gemacht haben; B = Gesamtzahl der Nutzer, die eine Aufgabe durchf??hren'  , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1	,'Dauer der Arbeit' , 'Wie viel Zeit zur Erledigung der Arbeit ben??tigt ist. Hierbei wird die Arbeitszeit gemessen.' , 'X = T; T = Arbeitszeit' , '{X | 0 < X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	2	,'Automatische Messung qualitativer Effekte' , 'Wie viel qualitativer Effekt erreicht ist. Hierbei wird der qualitative Effekt gemessen.' , 'X = A; A = qualitativer Effekt' , '{X | 0 ??? X}; Je gr????er der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	3	,'Effizienz der Arbeit' , 'Wie effizient und genau, gemessen an den Zielen, die Aufgabe erreicht ist. Hierbei wird die Anzahl der erreichten Ziele mit der ben??tigten Zeit verglichen. Zus??tzlich kann dieser Quotient mit dem eines Experten oder dem bei manueller Bearbeitung gegen??bergestellt werden. Bei verschiedener Wichtigkeit der Ziele ist es au??erdem noch m??glich, dieses Ma??e mit einflie??en zu lassen.' , 'X = A/T; A = Anzahl der erreichten Ziele; T = ben??tigte Zeit' , '{X | 0 < X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	4	,'??konomische Produktivit??t' , 'Wie effizient und genau die Aufgabe hinsichtlich der Ausgaben erreicht ist. Hierbei werden die Gesamtkosten dieser Aufgabe mit der Anzahl an erreichten Zielen verglichen. Zus??tzlich kann dieser Quotient mit dem bei manueller Bearbeitung verglichen werden. Bei verschiedener Wichtigkeit der Ziele ist es au??erdem noch m??glich, ieses Ma??e mit einflie??en zu lassen.' , 'X = A/B; A = Gesamtkosten der Aufgabe; B = Anzahl der erreichten Ziele' , '{X | 0 < X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	5	,'Kennziffer der Produktivit??t' , 'Wie viel seiner Gesamtzeit der Nutzer mit produktiven Aktivit??ten verbringt. Hierbei wird die Produktivit??tszeit mit der Arbeitszeit verglichen.' , 'X = Ta/Tb; Ta = Produktivit??tszeit = ben??tigte Zeit zur Erf??llung der Aufgabe - ben??tigte Zeit zur Einholung von Hilfe - ben??tigte Zeit zur Fehlerbeseitigung - ben??tigte Zeit f??r ineffektives Suchen; Tb = Arbeitszeit' , '{X | 0 < X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	6	,'Relative Nutzereffizienz' , 'Wie effizient der Nutzer im Vergleich mit einem erfahrenen Nutzer arbeiten kann. Hierbei wird die die aktuelle Leistung mit der urpsr??nglichen verglichen und von "1" abgezogen. ' , 'X = 1 - A/B; A = aktuelle Leistung; B = urspr??ngliche Leistung' , '{X | 0 ??? X}; Je n??her der Wert an "0" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	7	,'??bergreifende Kennziffer zur Bearbeitungszeit' , 'Bis zu welchem Grad die angestrebte Gesamtbearbeitungszeit realisiert ist. Hierbei wird die bisherige Arbeitszeit mit der angestrebten Gesamtbearbeitungszeit verglichen.' , 'X = A/B; A = bisherige Arbeitszeit; B = angestrebte Gesamtbearbeitungszeit' , '{X | 0 < X}; Je kleiner der Wert ist, desto besser, wobei X vom Bearbeitungsfortschritt abh??ngt.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	8	,'Compliance bei der Effizienz' , 'Wie sehr die Effizienz eines Produkts anwendbare Regulationen, Standards und Konventionen erf??llt. Hierbei wird die Anzahl der Elemente, f??r die Compliance bei der Effizienz spezifiziert wurde und bei denen diese noch nicht implementiert wurde, mit der Gesamtzahl aller Elemente, f??r die Compliance bei der Effizienz spezifiziert wurde, verglichen und von "1" abgezogen.' , 'X = 1 - A/B; A = Anzahl der Elemente, f??r die Compliance bei der Effizienz spezifiziert wurde und bei denen diese noch nicht implementiert wurde; B = Gesamtzahl aller Anzahl der spezfizierten Effizienz-Compliance-Elemente' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1	,'Gesamtzufriedenheit' , 'Wie viel Zufriedenheit durch die Nutzung erreicht wird. Hierbei wird die Summe der quantitativen Antworten zu einer Frage gemessen, beispielsweise mit Hilfe des Net Promoter Scores.' , 'X = ??ai; Ai = Antwort zu einer Frage' , '{X | 0 ??? X}; Je gr????er der Wert ist, desto besser, wobei X von der Bewertungsskala abh??ngt.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1	,'Zufriedenheit mit Features' , 'Wie viel Zufriedenheit mit speziellen Features erreicht wird. Hierbei wird die Summe der quantitativen Antworten einer Frage, die auf ein bestimmtes Features bezogen ist, gemessen.' , 'X = ??ai; Ai = Antwort zu einer Frage ??ber ein bestimmtes Feature' , '{X | 0 ??? X}; Je gr????er der Wert ist, desto besser, wobei X von der Bewertungsskala abh??ngt.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	2	,'Nutzung von Features' , 'Wie viele Nutzer ein bestimmtes Feature verwenden. Hierbei wird die Anzahl der Nutzer eines bestimmten Features mit der Gesamtzahl aller Nutzer verglichen.' , 'X = A/B; A = Anzahl der Nutzer eines bestimmten Features; B = Gesamtzahl aller Nutzer' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	3	,'Nutzung nach Ermessen' , 'Wie viele Beschwerden eingereicht werden. Hierbei wird die Anzahl der Beschwerden gemessen.' , 'X = A; A = Anzahl der Beschwerden' , '{X | 0 ??? X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	4	,'Anzahl der Beschwerden' , 'Wie viele Beschwerden gemessen an der Gesamtzahl der Nutzer eingereicht werden. Hierbei wird die Anzahl der sich beschwerenden Nutzer mit der Gesamtzahl an Nutzern verglichen.' , 'X = A/B; A = Anzahl der sich beschwerenden Nutzer; B = Gesamtzahl aller Nutzer' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	5	,'Anteil der Beschwerden' , 'Wie viele Nutzer sich ??ber ein bestimmtes Features beschweren. Hierbei wird die Anzahl der sich beschwerenden Nutzer ??ber ein bestimmtes Feature mit der Gesamtzahl aller Nutzer verglichen.' , 'X = A/B; A = Anzahl der sich beschwerenden Nutzer ??ber ein bestimmtes Feature; B = Gesamtzahl aller Nutzer' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1	,'Vertrauen des Nutzers' , 'Wie sehr der Nutzer dem System vertraut. Hierbei wird der psychometrische Skalenwert aus einem Fragebogen zu Vertrauen gemessen.' , 'X = A; A = Psychometrischer Skalenwert aus einem Fragebogen zu Vertrauen' , '{X | 0 ??? X}; Je gr????er der Wert ist, desto besser, wobei X von der Bewertungsskala abh??ngt.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1	,'Freude des Nutzers im Umgang mit dem System' , 'Wie viel Freude der Nutzer im Umgang mit dem System im Vergleich zu anderen Sytemen dieser Art hat. Hierbei wird der psychometrische Skalenwert aus einem Fragebogen zu Freude im Umgang mit dem System gemessen.' , 'X = A; A = Psychometrischer Skalenwert aus einem Fragebogen zur Freude im Umgang mit dem System' , '{X | 0 ??? X}; Je gr????er der Wert ist, desto besser, wobei X von der Bewertungsskala abh??ngt.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1	,'Physikalischer Komfort' , 'Wie sehr f??r den Nutzer im Umgang mit dem System die Nutzerbed??rfnisse in Bezug auf den physikalischen Komfort im Vergleich zu anderen Systemen dieser Art erf??llt sind. Hierbei wird der psychometrische Skalenwert aus einem Fragebogen zur Erf??llung der Nutzerbed??rfnisse in Bezug auf den physikalischen Komfort im Umgang mit dem System gemessen.' , 'X = A; A = Psychometrischer Skalenwert aus einem Fragebogen zur Erf??llung der Nutzerbed??rfnisse in Bezug auf den physikalischen Komfort im Umgang mit dem System' , '{X | 0 ??? X}; Je gr????er der Wert ist, desto besser, wobei X von der Bewertungsskala abh??ngt.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1	,'Return on Investment (ROI)' , 'Wie sehr sich die Einf??hrung und Nutzung des Systems auf monet??re Art und Weise lohnt. Hierbei werden der Erl??s und das eingesetzte Kapital miteinander verglichen, wobei die Gewinne in diesem Fall s??mtliche Einsparungen im Vergleich zu manueller Bearbeitung sind.' , 'X = (A-B)/B; A = Zus??tzliche Gewinne durch das System; B = Eingesetztes Kapital' , '{X | 0 ??? X < ???}; Je gr????er der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	2	,'Zeit bis zum Erhalt des ROI' , 'Wie lange es dauert, bis sich der ROI auswirkt. Hierbei wird die Dauer bis zum Erreichen des ROI gemessen, wobei diese akzeptabel sein muss.' , 'X = T; T = Zeit bis zum Erreich des ROI' , '{X | 0 < X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	3	,'Gesch??ftsleistung' , 'Wie hoch die Profitabilit??t gemessen an einem Ziel tats??chlich ist. Hierbei wird die tats??chliche mit der angestrebten Profitabilit??t verglichen, wobei dieser Quotient mit dem anderer Firmen in Relation gesetzt werden kann.' , 'X = Aa/At; A = Profitabilit??t oder Verk??ufe (a = tats??chlich, t = angestrebt)' , '{X | 0 ??? X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	4	,'Gewinne aus der Investition in die IT' , 'Wie hoch die Gewinne aus der Investition in die IT gemessen an einer Zielgr????e sind. Hierbei werden die tats??chlichen mit den angestrebten Gewinnen verglichen, beispielsweise mit Hilfe der Balanced Score Card.' , 'X = Aa/At; A = Gewinne aus der Investition in die IT (a = tats??chlich, t = angestrebt)' , '{X | 0 ??? X}; Je n??her der Wert an "1" ist, desto besser wurde der angestrebte Wert eingehalten. Je gr????er der Wert ist, desto besser im Allgemeinen.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	5	,'Kundenservice' , 'Wie hoch der angstrebte Servicelevel dem Kunden gegen??ber ist. Dieses kann beispielsweise bei Lieferp??nktlichkeit oder geringerer durchschnittlicher Wartezeit in der Kundenbetreuung erh??ht werden. Hierbei wird der aktuelle mit dem angstrebten Servicelevel verglichen, wo der Wert bei einer ??berf??llung der Ziele ">1" ist. ' , 'X = A/B; A = Tats??chlicher Servicelevel; B = Angestrebter Servicelevel' , '{X | 0 ??? X}; Je n??her der Wert an "1" ist, desto besser wurde der angestrebte Wert eingehalten. Je gr????er der Wert ist, desto besser im Allgemeinen.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	6	,'H??ufigkeit der Lieferversp??tungen' , 'Bei wie vielen Sendungen es Verp??tungen in der Lieferzeit gab. Hierbei wird die Anzahl der versp??teten Lieferungen  mit der Gesamtzahl aller Lieferungen verglichen und von "1" abgezogen.' , 'X = 1 - A/B; A = Anzahl der verp??teten Lieferungen; B = Gesamtzahl aller Lieferungen' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	7	,'Anzahl der fehlenden Artikel' , 'Wie viele F??lle von fehlenden Artikeln es gab. Hierbei wird die Anzahl der fehlenden Artikel mit der Gesamtzahl aller Artikel verglichen und von "1" abgezogen.' , 'X = 1 - A/B; A = Anzahl der fehlenden Artikel; B = Gesamtzahl aller Artikel' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	8	,'Besucher der Webseite, die tats??chlich zu Kunden werden' , 'Welcher Anteil der Besucher einer Webseite tats??chlich zu Kunden werden. Hierbei wird der Anteil der Besucher einer Website mit der Anzahl der Besucher einer Website verglichen.' , 'X = A/B; A = Anzahl der Besucher, die zu Kunden geworden sind; B = Anzahl der (eindeutigen) Besucher einer Website' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	9	,'Einnahmen durch den einzelnen Kunden' , 'Wie hoch die Einnahmen durch den einzelnen Kunden sind. Hierbei werden die Einnahmen jedes einzelnen Kunden gemessen, wobei anhand von verschiedenen Kundenmerkmalen M??glichkeiten zur Systemevaluierung f??r bestimmte Nutzergruppen abgeleitet werden k??nnen.' , 'X = A; A = Einnahmen durch den einzelnen Kunden' , '{X | 0 ??? X < ???}; Je gr????er der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	10	,'Zielerreichung der Einnahmen durch den neue Kunden' , 'Wie hoch der Anteil der Einnahmen durch neue Kunden gemessen an einer Zielgr????e sind. Hierbei werden die tats??chlichen mit den angestrebten Einnahmen durch neue Kunden verglichen.' , 'X = Aa/At; A = Einnahmen durch neue Kunden (a = tats??chlich, t = angestrebt)' , '{X | 0 < X}; Je n??her der Wert an "1" ist, desto besser wurde der angestrebte Wert eingehalten. Je gr????er der Wert ist, desto besser im Allgemeinen.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	11	,'??konomischer Schaden' , 'Wie hoch der Anteil an Nutzungssituationen (= Transaktionen) ist, bei denen menschliche oder Systemfehler zu ??konomischem Schaden f??hren. Hierbei wird die Anzahl der Fehler, die zu ??konomischen Folgen gef??hrt haben, mit der Anzahl an Nutzungssituationen verglichen.' , 'X = A/B; A = Anzahl der Fehler, die zu ??konomischem Schaden gef??hrt haben; B = Anzahl an Nutzungssituationen' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	12	,'Vergleich mit anderen Unternehmen (Benchmark)' , 'Wie der Status des eigenen Unternehmens im Vergleich zu anderen Spitzenunternehmen in der selben Branche ist. Hierbei wird der Status des eigenen Unternehmens f??r einen bestimmten Bereich mit dem des Spitzenunternehmens in diesem Bereich in Beziehung gesetzt.' , 'X = A/B; A = Status des eigenen Unternehmens; B = Status des Spitzenunternehmens' , '{X | 0 < X}; Je n??her der Wert an "1" ist, desto besser n??her ist man in diesem Bereich am Spitzenunternehmen. Je gr????er der Wert ist, desto besser im Allgemeinen.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	13	,'Opportunit??tsverlust' , 'Wie hoch der Profitverlust durch Nicht-Einsatz des Systems ist. Hierbei wird die H??he des Profits gemessen, der durch den Nicht-Einsatz des Systems nicht erzielt werden konnte.' , 'X = A; A = Profitverlust durch Nicht-Einsatz des Systems' , '{X | 0 < X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	14	,'IT Analagenbestand' , 'Wie effektiv der Betrag f??r die IT Investition genutzt wird. Hierbei werden der effektive Investitionsbetrag und der Betrag f??r die IT Investition verglichen.' , 'X = A/B; A = effektiver Investitionsbetrag; B = Betrag f??r die IT Investition' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1	,'H??ufigkeit an krankheitsbedingten Ausf??llen der Nutzer' , 'Wie gro?? der Anteil an Nutzern eines Produkts oder Systems ist, die von gesundheitlichen Beschwerden auf Grund der Nutzung berichten. Hierbei wird die Anzahl an Nutzern, die von gesundheitlichen Beschwerden auf Grund der Nutzung berichten, mit der Gesamtzahl aller Nutzer verglichen, wobei die Berechnung anhand der Nutzungsdauer gewichtet werden kann.' , 'X = A/B; A = Anzahl der Nutzer, die von gesundheitlichen Beschwerden auf Grund der Nutzung berichten; B = Gesamtzahl aller Nutzer' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	2	,'Auswirkung auf Gesundheit und Sicherheit f??r den Nutzer' , 'Wie gro?? die Auswirkung auf Gesundheit und Sicherheit der Nutzer eines Produkts oder Systems ist. Hierbei wird die Summe aus den mulitplizierten Faktoren L??nge und Grad der Auswirkung mit der L??nge der Zeit von Beginn der Systemnutzung an verglichen.' , '"n = Anzahl der betroffenen Nutzer; Tai = Dauer, f??r die der i-te Nutzer betroffen ist; Si = Grad der Auswirkung f??r den i-ten Nutzer; L??nge der Zeit von Beginn der Systemnutzung an"' , '{X | 0 ??? X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	3	,'Beeinflussung der Sicherheit f??r den Nutzer' , 'Wie gro?? die Sicherheitsrisiken f??r die Nutzer des Systems sind. Hierbei wird die Anzahl der Nutzer, die gef??hrdet wurden, gemessen.' , 'X = A; A = Anzahl der Nutzer, die gef??hrdet wurden' , '{X | 0 ??? X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	4	,'Anteil der Sicherheits-gef??hrdungen' , 'Wie gro?? die Sicherheitsrisiken f??r die Nutzer des Systems gemessen an der Gesamtzahl der potentiell gef??hrdeten Nutzer sind. Hierbei wird die Anzahl der Nutzer, die gef??hrdet wurden, mit der Gesamtzahl der Nutzer, die gef??hrdet werden k??nnten, verglichen.' , 'X = A/B; A = Anzahl der Nutzer, die gef??hrdet wurden; B = Gesamtzahl der Nutzer, die gef??hrdet werden k??nnten' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "0" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	5	,'Grad der Bel??stigung f??r den Kunden' , 'Wie gro?? die Bel??stigung f??r den Kunden ist. Hierbei wird die Anzahl der bel??stigten mit der Schwere der Bel??stigung multipliziert.' , 'X = AxB; A = Anzahl der bel??stigten Kunden; B = Schwere der Bel??stigung' , '{X | 0 ??? X}; Je kleiner der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1	,'Auswirkung auf die Umwelt' , 'Wie sehr sich, gemessen an einer Zielgr????e, die Herstellung bzw. Entwicklung eines Systems oder Produkts auf die Umwelt auswirkt. Risiken f??r die Umwelt k??nnten aus Softwarefehlern oder aus fehlerhafter Nutzung auf Grund eines schlecht entworfenen User-Interfaces resultieren. Hierbei wird die tats??chliche Auswirkung auf die Umwelt mit der angestrebten verglichen.' , 'X = Aa/At; A = Auswirkung auf die Umwelt (a = tats??chlich; t = angestrebt)' , '{X | 0 < X}; Je n??her der Wert an "1" ist, desto besser wurde der angestrebte Wert eingehalten. Je kleiner der Wert ist, desto besser im Allgemeinen.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	2	,'Grad an Erf??llung von rechtlichen Voraussetzungen f??r  die F??rderung umweltfreundlicher Beschaffungsma??nahmen' , 'Wie hoch die staatliche F??rderung zur Reduzierung umweltlicher Belastungen ist. Hierbei wird die H??he der F??rderung auf Grund bestimmter Voraussetzungen gemessen.' , 'X = A; A = H??he der F??rderung' , '{X | 0 ??? X}; Je gr????er der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	3	,'Zielwert zur CO2 -Emission' , 'Wie hoch die Werte der CO2-Emission gemessen an einem Zielwert sind. Hierbei werden die CO2 -Emission f??r den laufenden Betrieb und w??hrend der Produktion bzw. Entwicklung mit der angestrebten CO2 -Emission verglichen.' , 'X = (Ao + Ap)/At; A = CO2 -Emission (o = im laufenden Betrieb, p = w??hrend der Produktion bzw. Entwicklung, t = angestrebt)' , '{X | 0 <}; Je n??her der Wert an "1" ist, desto besser wurde der angestrebte Wert eingehalten. Je kleiner der Wert ist, desto besser im Allgemeinen.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1	,'Vollst??ndigkeit der Umgebung' , 'Wie hoch, gemessen an der Gesamtzahl aller unterschiedlichen Umgebungsanforderungen, der Anteil der angestrebten Nutzungsumgebungen ist, in denen ein Produkt oder System mit akzeptabler N??tzlichkeit und akzeptablem Risiko genutzt werden kann. Hierbei wird die Anzahl der Nutzungsumgebungen mit akzeptabler N??tzlichkeit und akzeptablem Risiko mit der Gesamtzahl aller unterschiedlichen Umgebungsanforderungen verglichen.' , 'X = A/B; A = Anzahl der Nutzungsumgebungen mit akzeptabler N??tzlichkeit und akzeptablem Risiko; B = Gesamtzahl aller unterschiedlichen Umgebungsanforderungen' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	1	,'Flexible Nutzungsumgebung' , 'Inwieweit ein Produkt oder System in zus??tzlichen Nutzungsumgebungen (verschiedene Arten von Nutzern, Aufgaben und Umgebungen) ohne oder nur mit geringen Modifizierungen genutzt werden kann. Hierbei wird die Anzahl der zus??tzlichen Nutzungsumgebungen, f??r die eine akzeptable Nutzungsqualit??t des Produkts oder des Systems vorherrscht, mit der Gesamtzahl aller potentiellen zus??tzlichen Nutzungsumgebungen verglichen.' , 'X = A/B; A = Anzahl der Nutzungsumgebungen, f??r die eine akzeptable Nutzungsqualit??t des Produkts oder des Systems vorherrscht; B = Gesamtzahl aller potentiellen zus??tzlichen Nutzungsumgebungen' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	2	,'Produktflexibilit??t' , 'Wie einfach ein Produkt oder System modifiziert werden kann, um zus??tzliche Nutzeranforderungen zu erf??llen. Hierbei wird die Summe der Modifizierbarkeit aller zus??tzlichen Anforderungen mit der Gesamtzahl aller neuen Anforderungen eines spezifischen Nutzers in Relation gesetzt.' , '"Ai = Modifizierbarkeit (spezifiziert in ISO/IEC 25023) f??r die i-te Anforderung; B = Gesamtzahl aller neuen Anforderungen eines spezifischen Nutzers"' , '{X | 0 ??? X}; Je gr????er der Wert ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	3	,'Unabh??ngigkeit der Kenntnisse' , 'Inwieweit ein Produkt oder System von Personen ohne spezielles Wissen, F??higkeiten oder Erfahrungen genutzt werden kann. Hierbei wird die Anahl der zus??tzlichen Nutzergruppen, die ohne spezielle Kenntnisse das Produkt oder System nutzen k??nnen, mit der Gesamtzahl aller potentiellen Nutzergruppen ohne spezielle Kenntnisse verglichen.' , 'X = A/B; A = Anahl der der zus??tzlichen Nutzergruppen, die ohne spezielle Kenntnisse das Produkt oder System nutzen k??nnen; B = Gesamtzahl der potentiellen Nutzergruppen ohne spezielle Kenntnisse' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	4	,'Wiederherstellungszeit' , 'Wie viele Tage, gemessen an einer Zielgr????e, zur betriebsf??higen, (fast) vollst??ndigen Wiederherstellung des Systems nach einer Katastrophe  vergehen. Hierbei werden die tats??chlich ben??tigt mit den vorher geplanten Tage zur Wiederherstellung des Systems verglichen.' , 'X = Aa/At; A = Tage zur Wiederherstellung des Systems (a = tats??chlich, t = geplant)' , '{X | 0 < X}; Je n??her der Wert an "1" ist, desto besser wurde der angestrebte Wert eingehalten. Je kleiner der Wert ist, desto besser im Allgemeinen.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	5	,'Backup-F??higkeit' , 'Welcher Grad an F??higkeiten dazugelernt wurde, um auf ein Backup-System umzuschalten oder das System einfach wiederherzustellen. Hierbei wird der Grad an F??higkeiten gemessen, um auf ein Backup-System umzuschalten.' , 'X = A; A = Grad an F??higkeiten, um auf ein Backup-System umzuschalten' , '{X | 0 ??? X ??? 1}; Je gr????er der Wert ist, desto besser, wobei X von der Bewertungsskala abh??ngt' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	6	,'Unterst??tzung bei Hardware-St??rungen' , 'Wie sehr Standards bei einer Hardware-St??rung befolgt werden. Hierbei wird die H??ufigkeit der Durchf??hrung einer standardisierten Vorgehensweise bei einer Hardware-St??rung mit der Gesamtzahl aller Hardware-St??rungen verglichen.' , 'X = A/B; A = H??ufigkeit der Durchf??hrung einer standardisierten Vorgehensweise bei einer Hardware-St??rung; B = Gesamtzahl aller Hardware-St??rungen' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	7	,'Unterst??tzung bei Netzwerk-St??rungen' , 'Wie sehr Standards bei einer Netzwerk-St??rung befolgt werden. Hierbei wird die H??ufigkeit der Durchf??hrung einer standardisierten Vorgehensweise bei einer Netzwerk-St??rung mit der Gesamtzahl aller Netzwerk-St??rungen verglichen.' , 'X = A/B; A = H??ufigkeit der Durchf??hrung einer standardisierten Vorgehensweise bei einer Netzwerk-St??rung; B = Gesamtzahl aller Netzwerk-St??rungen' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
INSERT INTO metric ( metric_number, bezeichnung,erklaerung_messgroesse, formel, interpretation)  VALUES (	8	,'Unterst??tzung bei Software-St??rungen' , 'Wie sehr Standards bei einer Software-St??rung befolgt werden. Hierbei wird die H??ufigkeit der Durchf??hrung einer standardisierten Vorgehensweise bei einer Software-St??rung mit der Gesamtzahl aller Software-St??rungen verglichen.' , 'X = A/B; A = H??ufigkeit der Durchf??hrung einer standardisierten Vorgehensweise bei einer Software-St??rung; B = Gesamtzahl aller Software-St??rungen' , '{X | 0 ??? X ??? 1}; Je n??her der Wert an "1" ist, desto besser.' );
										
---------------------mertic - criteria

INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effektivit??t'),	(SELECT id  FROM metric where bezeichnung like'Vollst??ndigkeit der Arbeit'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effektivit??t'),	(SELECT id  FROM metric where bezeichnung like'Fehler bei der Arbeit'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effektivit??t'),	(SELECT id  FROM metric where bezeichnung like'Fehlerhafte Arbeit'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effektivit??t'),	(SELECT id  FROM metric where bezeichnung like'Fehlerintensit??t'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effizienz'),	(SELECT id  FROM metric where bezeichnung like'Dauer der Arbeit'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effektivit??t'),	(SELECT id  FROM metric where bezeichnung like'Effektivit??t der Arbeit'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effizienz'),	(SELECT id  FROM metric where bezeichnung like'Automatische Messung qualitativer Effekte'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effizienz'),	(SELECT id  FROM metric where bezeichnung like'Effizienz der Arbeit'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effizienz'),	(SELECT id  FROM metric where bezeichnung like'??konomische Produktivit??t'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effizienz'),	(SELECT id  FROM metric where bezeichnung like'Kennziffer der Produktivit??t'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effizienz'),	(SELECT id  FROM metric where bezeichnung like'Relative Nutzereffizienz'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Effizienz'),	(SELECT id  FROM metric where bezeichnung like'??bergreifende Kennziffer zur Bearbeitungszeit'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Zufriedenheit'),	(SELECT id  FROM metric where bezeichnung like'Compliance bei der Effizienz'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'N??tzlichkeit'),	(SELECT id  FROM metric where bezeichnung like'Gesamtzufriedenheit'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'N??tzlichkeit'),	(SELECT id  FROM metric where bezeichnung like'Zufriedenheit mit Features'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'N??tzlichkeit'),	(SELECT id  FROM metric where bezeichnung like'Nutzung von Features'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'N??tzlichkeit'),	(SELECT id  FROM metric where bezeichnung like'Nutzung nach Ermessen'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'N??tzlichkeit'),	(SELECT id  FROM metric where bezeichnung like'Anzahl der Beschwerden'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'N??tzlichkeit'),	(SELECT id  FROM metric where bezeichnung like'Anteil der Beschwerden'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Vertrauen'),	(SELECT id  FROM metric where bezeichnung like'Vertrauen des Nutzers'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Freude im Umgang mit dem Systems'),	(SELECT id  FROM metric where bezeichnung like'Freude des Nutzers im Umgang mit dem System'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Komfort'),	(SELECT id  FROM metric where bezeichnung like'Physikalischer Komfort'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'Return on Investment (ROI)'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'Zeit bis zum Erhalt des ROI'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'Gesch??ftsleistung'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'Gewinne aus der Investition in die IT'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'Kundenservice'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'H??ufigkeit der Lieferversp??tungen'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'Anzahl der fehlenden Artikel'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'Besucher der Webseite, die tats??chlich zu Kunden werden'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'Einnahmen durch den einzelnen Kunden'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'Zielerreichung der Einnahmen durch den neue Kunden'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'??konomischer Schaden'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'Vergleich mit anderen Unternehmen (Benchmark)'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'Opportunit??tsverlust'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der ??konomischen Risiken'),	(SELECT id  FROM metric where bezeichnung like'IT Analagenbestand'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der Risiken hinsichtlich Gesundheit und Sicherheit'),	(SELECT id  FROM metric where bezeichnung like'H??ufigkeit an krankheitsbedingten Ausf??llen der Nutzer'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der Risiken hinsichtlich Gesundheit und Sicherheit'),	(SELECT id  FROM metric where bezeichnung like'Auswirkung auf Gesundheit und Sicherheit f??r den Nutzer'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der Risiken hinsichtlich Gesundheit und Sicherheit'),	(SELECT id  FROM metric where bezeichnung like'Beeinflussung der Sicherheit f??r den Nutzer'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der Risiken hinsichtlich Gesundheit und Sicherheit'),	(SELECT id  FROM metric where bezeichnung like'Anteil der Sicherheits-gef??hrdungen'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der Risiken hinsichtlich Gesundheit und Sicherheit'),	(SELECT id  FROM metric where bezeichnung like'Grad der Bel??stigung f??r den Kunden'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der Umweltrisiken'),	(SELECT id  FROM metric where bezeichnung like'Auswirkung auf die Umwelt'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der Umweltrisiken'),	(SELECT id  FROM metric where bezeichnung like'Grad an Erf??llung von rechtlichen Voraussetzungen f??r  die F??rderung umweltfreundlicher Beschaffungsma??nahmen'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Verringerung der Umweltrisiken'),	(SELECT id  FROM metric where bezeichnung like'Zielwert zur CO2 -Emission'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Komplette Abdeckung aller Umgebungsanforderungen'),	(SELECT id  FROM metric where bezeichnung like'Vollst??ndigkeit der Umgebung'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Flexibilit??t'),	(SELECT id  FROM metric where bezeichnung like'Flexible Nutzungsumgebung'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Flexibilit??t'),	(SELECT id  FROM metric where bezeichnung like'Produktflexibilit??t'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Flexibilit??t'),	(SELECT id  FROM metric where bezeichnung like'Unabh??ngigkeit der Kenntnisse'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Flexibilit??t'),	(SELECT id  FROM metric where bezeichnung like'Wiederherstellungszeit'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Flexibilit??t'),	(SELECT id  FROM metric where bezeichnung like'Backup-F??higkeit'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Flexibilit??t'),	(SELECT id  FROM metric where bezeichnung like'Unterst??tzung bei Hardware-St??rungen'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Flexibilit??t'),	(SELECT id  FROM metric where bezeichnung like'Unterst??tzung bei Netzwerk-St??rungen'));
INSERT INTO criteria_metric(criteria_id, metric_id) VALUES (	(SELECT criteria_id  FROM nfa_criteria where criteria like 'Flexibilit??t'),	(SELECT id  FROM metric where bezeichnung like'Unterst??tzung bei Software-St??rungen'));


----------------------------- nfa 

INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Qualit??t der Arbeit","erklaerung":"Das System muss dem bzw. der Anwender_in dabei unterst??tzen, ihre bzw. seine Aufgaben mit hoher Qualit??t, Genauigkeit und Effizienz zu erledigen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Vollst??ndige Durchf??hrung der Arbeit","erklaerung":"Das System muss alle vom bzw. von dem bzw. der Anwender_in zu erledigenden Aufgaben vollst??ndig unterst??tzen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (3 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Fehleranteil","erklaerung":"Die Anzahl der Fehler darf nicht h??her sein als 0,1% aller durchgef??hrten Operationen eines bzw. einer Anwender_in im System.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (4 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Entstehende Fehler","erklaerung":"Bei der Bearbeitung von Aufgaben mit dem System sollen m??glichst keine Fehler entstehen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (5 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Fehlerfreie Bedienung","erklaerung":"Der bzw. die Anwender_in muss das System m??glichst fehlerfrei bedienen k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Effiziente Zeitauslastung","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Verz??gerung","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (3 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Zeitlimit","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (4 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Keine Zeitbegrenzung","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (5 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"??berschreitung der Bearbeitungszeit","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Qualitativer Effekt","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Effizienz bei der Bearbeitung","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Effiziente Arbeit","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (3 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Effiziente Datenbankbedienung","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Qualitative Effizienz","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Optimierung der Schritte f??r die Aufgabe","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Produktivit??t","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Relative Effizienz","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Angestrebte Bearbeitungszeit","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Mengenger??st 1","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Netzwerk Bandbreiten bei Rollout & Update 1","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (3 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Netzwerk Bandbreiten bei Rollout & Update 2","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (4 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Netzwerk Bandbreiten bei Rollout & Update 3","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (5 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Netzwerk Bandbreiten bei Rollout & Update 4","erklaerung":"Der bzw. die Anwender_in muss in angemessener Zeit ihre bzw. seine Aufgaben durchf??hren k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Zufriedenheit","erklaerung":"Die bzw. der Anwender_in muss mit der Nutzung des Systems zufrieden sein.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Zufriedenheit mit Features","erklaerung":"Die bzw. der Anwender_in muss mit der Nutzung eines bestimmten Features zufrieden sein.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Nutzung","erklaerung":"Alle Anwender_innen des Fachgebiets sollen das System nutzen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Anzahl der Beschwerden","erklaerung":"Es soll m??glichst keine Beschwerden ??ber das System geben.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Beschwerden","erklaerung":"Es soll sich ein m??glichst kleiner Teil der Nutzer ??ber das System beschweren.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Beschwerden ??ber ein bestimmtes Feature","erklaerung":"Es soll sich ein m??glichst kleiner Teil der Nutzer ??ber ein bestimmtes Feature beschweren.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Vertrauen","erklaerung":"Die bzw. der Anwender_in muss dem System in Bezug auf seine Qualit??tsaspekte (z.B. Effektivit??t, Korrektheit, Leistung) vertrauen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Freude bei der Nutzung","erklaerung":"Die bzw. der Anwender_in muss Freude empfinden bei der Ausf??hrung der Software.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Wohlbefinden","erklaerung":"Die bzw. der Anwender_in muss Wohlbefinden bei der Bedienung des Systems empfinden.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Ergonomik","erklaerung":"Das System muss ??ber ergonomische Grundeinstellungen verf??gen (z.B. geeignete Tastenkombinationen oder Schriftgr????en).","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (3 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Keine Tastaturfalle 1","erklaerung":"Kann der Tastaturfokus durch Verwendung einer Tastaturschnittstelle auf ein Element der Seite bewegt werden, so muss der Fokus ??ber die Tastaturschnittstelle auch von diesem Element wegbewegt werden k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (4 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Keine Tastaturfalle 2","erklaerung":"Sind hierf??r mehr als die Standard-, Pfeil- oder -Tabulator-Tasten erforderlich, m??ssen die Anwender_innen dar??ber informiert werden, mit welcher Methode (Etwa Tooltips) der Fokus wegbewegt werden kann. ","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"ROI 1","erklaerung":"Das System muss einen ROI erwirtschaften.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"ROI 2","erklaerung":"Das System soll einen ROI erwirtschaften.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Dauer bis zum Erreichen des ROI","erklaerung":"Der ROI soll sp??testens nach ??? Monaten erreicht werden.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Profitabilit??t","erklaerung":"Die angestrebte Profitabilit??t soll zu mindestens ???% erreicht werden.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Wirtschaftliche Entlastung","erklaerung":"Das System muss die bzw. den Auftraggeber_in wirtschaftlich entlasten.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Balanced Score Card","erklaerung":"Die Investition in das System muss bei der Bewertung durch eine Balanced Score Card (Finanzen, Kunden, Gesch??ftsprozesse, Personalentwicklung) als effektiv eingestuft sein.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Information ??ber Verz??gerung","erklaerung":"Die Auftragnehmerin bzw. der Auftragnehmer muss der Auftraggebern bzw. dem Auftraggeber bei erkennbaren Termin??berschreitungen (z.B. bei Nicht-Einhalten von Meilensteinen) oder Problemen innerhalb von ... Arbeitstagen informieren.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Technischer Support","erklaerung":"Es muss Support f??r technische Fragen und Bedienung in Anspruch genommen werden k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (3 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"E-Mail-Support","erklaerung":"Die bzw. der Anwender_in muss Supportleistungen per E-Mail in Anspruch nehmen k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (4 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Telefon-Support","erklaerung":"Der bzw. die Anwender_in muss Supportleistungen telefonisch w??hrend der Regelarbeitszeit in Anspruch nehmen k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (5 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Support-verf??gbarkeit","erklaerung":"Supportleistungen per E-Mail m??ssen 24 Stunden und 7 Tage die Woche in Anspruch genommen werden k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (6 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Antwortzeit des Supports","erklaerung":"Der Support soll innerhalb von ??? Std. antworten.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (7 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Fremdsprache des Supports","erklaerung":"Das System kann einen Support in <Fremdsprache> anbieten.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Lieferp??nktlichkeit","erklaerung":"Es sollen mindestens ???% aller Lieferungen p??nktlich kommen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Vollst??ndigkeit der Artikel","erklaerung":"Die Fehler bei der Logisktik sollen so gering sein, dass mindestens ???% aller Artikel mitgeliefert werden.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Kundenrate","erklaerung":"Die Webseite soll so ansprechend gestaltet sein, dass mindestens ???% aller Besucher der Webseite zu Kunden werden.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Umsatz je Kunde","erklaerung":"Das System erwirtschaftet einen messbaren Umsatz je Kunde.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Einnahmen durch neue Kunden","erklaerung":"???% aller Einnahmen sollen durch Neukunden generiert werden.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Imageverlust durch Hardwareausfall","erklaerung":"Das System muss sicherstellen, dass durch den Ausfall einer Hardware-Komponente kein Imageverlust eintritt.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Imageverlust durch Hardware-, Netz- oder Softwaresch??den","erklaerung":"Das System muss sicherstellen, dass beim Auftreten von Hardware-, Netz- oder Softwaresch??den kein Imageverlust eintritt.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (3 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Vermeidung von ??konomischem Sch??den","erklaerung":"Das System unterst??tzt bei der Vermeidung von ??konomischem Schaden.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (4 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Vermeidung von Image-Sch??den","erklaerung":"Das System unterst??tzt bei der Vermeidung von Image-Sch??den.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Benchmark","erklaerung":"Das System muss in einem Benchmark mit einem vergleichbaren System vergleichbarer Auftraggeber_innen zu den Besten geh??ren.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Kundenbindung","erklaerung":"Das System muss f??r Kundenbindung sorgen. Es ist zu bewerten an der Frage, wie viel Umsatz, Reputation nicht erreicht wird, wenn das System nicht in Betrieb geht.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"IT Investitionsvolumen","erklaerung":"Das IT Investitionsvolumen wird effektiv f??r das System genutzt.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Kranke Nutzer","erklaerung":"Das System muss eine Erh??hung Anzahl der krankheitsbedingten Ausf??lle der Anwender_innen, die unmittelbar durch die Systemnutzung verursacht werden, verhindern.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"St??rung des Wohlbefindens","erklaerung":"Das System muss die St??rung des Wohlbefindens eines bzw. einer Anwender_in verhindern.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Vermeidung von epileptischen Anf??llen 1","erklaerung":"Inhalte m??ssen so zu gestaltet sein, dass keine epileptischen Anf??lle ausgel??st werden.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (3 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Blinkende Elemente vermeiden","erklaerung":"Die Software sollte es erm??glichen, dass Schmerz oder Verletzung nicht auftreten.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (4 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Anpassung der taktilen Ausgabe","erklaerung":"Die Software sollte aus dem t??glichen Leben vertraute Muster bereitstellen, um Meldungen taktiler Art zu beschreiben.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Anzahl der gef??hrdeten Nutzer","erklaerung":"Das System muss eine Erh??hung der Sicherheitsrisiken der Anwender_innen, die unmittelbar mit der Nutzung des Systems einhergehen, verhindern.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Tats??chlich gef??hrdete Nutzer","erklaerung":"Die Anteil der tats??chlich gef??hrdeten Nutzer muss gegen 0 gehen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Kundenbel??stigung","erklaerung":"Das System muss die St??rung des Wohlbefindens eines Kunden verhindern.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Vermeiden von Umweltbelastungen","erklaerung":"Das System muss Umweltbelastungen vermeiden.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (2 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Minimierung von Umweltbelastungen","erklaerung":"Das System muss zur Minimierung von Umweltbelastungen beitragen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (3 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Vermeiden von Ressourcen-verschwendungen","erklaerung":"Das System muss bei der Vermeidung der Verschwendung von Ressourcen unterst??tzen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Einnahmen durch staatliche F??rderung.","erklaerung":"Durch die Nutzung eines umweltfreundlichen Systems sollen Einnahmen durch staatliche F??rderung erzielt werden.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Unterst??tzung bei der Verringerung der CO2-Emission","erklaerung":"Das System unterst??tzt bei der Verringerung der CO2-Emission.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Abdeckung aller Umgebungsanforderungen","erklaerung":"Das System soll in folgenden Nutzungsumgebungen eingesetzt werden:<Nutzungsumgebungen>","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Zus??tzliche Nutzungsumgebungen","erklaerung":"Das System soll in folgenden Nutzungsumgebungen flexibel einsetzbar sein: <Nutzungsumgebungen>","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Aufwand zum Einsatz in zus??tzlichen Nutzungsumgebungen","erklaerung":"Die Modifzierbarkeit soll m??glichst gering sein.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Einsatz bei zus??tzlichen Nutzergruppen","erklaerung":"Das System soll ohne spezielles Wissen, F??higkeiten oder Erfahrungen von m??glichst vielen Nutzergruppen genutzt werden k??nnen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Angestrebte Wiederherstellungszeit","erklaerung":"Das System sollte im Schadensfall schneller wieder verf??gbar sein als geplant.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Erlernte Backup-F??higkeit","erklaerung":"Der bzw. die Auftragnehmer_in des Systems m??ssen durch t??gliches Training einen Wissensstand erreichen, der es ihnen erm??glicht, eine Backup-Maschine im Schadensfall zu aktivieren, um das System betriebsbereit respektive die Ausfallzeit gering zu halten.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Standards bei Hardwarefehlfunktionen","erklaerung":"Es m??ssen Standards f??r die Behandlung einer Hardwarefehlfunktion vorliegen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Standards bei Netzwerkfehlfunktionen","erklaerung":"Es m??ssen Standards f??r die Behandlung einer Netzwerkfehlfunktion vorliegen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );
INSERT INTO nfa( nfa_number, nfa_type, legal_liability, blueprint) VALUES (1 , 'nfa_type_1' , 'true' , '{"de":{"bezeichnung":"Standards bei Softwarefehlfunktionen","erklaerung":"Es m??ssen Standards f??r die Behandlung einer Softwarefehlfunktion vorliegen.","characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null},"en":{"bezeichnung":null,"erklaerung":null,"characteristic":null,"property":null,"modalVerb":null,"qualifyingEx":null,"verb":null}}' );

------------------------nfa  -metric
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	7	,	(SELECT id  FROM metric where bezeichnung like 'Dauer der Arbeit'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	8	,	(SELECT id  FROM metric where bezeichnung like 'Dauer der Arbeit'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	9	,	(SELECT id  FROM metric where bezeichnung like 'Dauer der Arbeit'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	10	,	(SELECT id  FROM metric where bezeichnung like 'Dauer der Arbeit'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	11	,	(SELECT id  FROM metric where bezeichnung like 'Automatische Messung qualitativer Effekte'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	12	,	(SELECT id  FROM metric where bezeichnung like 'Effizienz der Arbeit'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	13	,	(SELECT id  FROM metric where bezeichnung like 'Effizienz der Arbeit'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	14	,	(SELECT id  FROM metric where bezeichnung like 'Effizienz der Arbeit'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	15	,	(SELECT id  FROM metric where bezeichnung like '??konomische Produktivit??t'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	16	,	(SELECT id  FROM metric where bezeichnung like '??konomische Produktivit??t'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	17	,	(SELECT id  FROM metric where bezeichnung like 'Kennziffer der Produktivit??t'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	18	,	(SELECT id  FROM metric where bezeichnung like 'Relative Nutzereffizienz'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	19	,	(SELECT id  FROM metric where bezeichnung like '??bergreifende Kennziffer zur Bearbeitungszeit'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	20	,	(SELECT id  FROM metric where bezeichnung like 'Compliance bei der Effizienz'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	21	,	(SELECT id  FROM metric where bezeichnung like 'Compliance bei der Effizienz'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	22	,	(SELECT id  FROM metric where bezeichnung like 'Compliance bei der Effizienz'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	23	,	(SELECT id  FROM metric where bezeichnung like 'Compliance bei der Effizienz'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	24	,	(SELECT id  FROM metric where bezeichnung like 'Compliance bei der Effizienz'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	25	,	(SELECT id  FROM metric where bezeichnung like 'Gesamtzufriedenheit'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	26	,	(SELECT id  FROM metric where bezeichnung like 'Zufriedenheit mit Features'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	27	,	(SELECT id  FROM metric where bezeichnung like 'Nutzung von Features'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	28	,	(SELECT id  FROM metric where bezeichnung like 'Nutzung nach Ermessen'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	29	,	(SELECT id  FROM metric where bezeichnung like 'Anzahl der Beschwerden'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	30	,	(SELECT id  FROM metric where bezeichnung like 'Anteil der Beschwerden'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	31	,	(SELECT id  FROM metric where bezeichnung like 'Vertrauen des Nutzers'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	32	,	(SELECT id  FROM metric where bezeichnung like 'Freude des Nutzers im Umgang mit dem System'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	33	,	(SELECT id  FROM metric where bezeichnung like 'Physikalischer Komfort'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	34	,	(SELECT id  FROM metric where bezeichnung like 'Physikalischer Komfort'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	35	,	(SELECT id  FROM metric where bezeichnung like 'Physikalischer Komfort'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	36	,	(SELECT id  FROM metric where bezeichnung like 'Physikalischer Komfort'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	37	,	(SELECT id  FROM metric where bezeichnung like 'Return on Investment (ROI)'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	38	,	(SELECT id  FROM metric where bezeichnung like 'Return on Investment (ROI)'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	39	,	(SELECT id  FROM metric where bezeichnung like 'Zeit bis zum Erhalt des ROI'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	40	,	(SELECT id  FROM metric where bezeichnung like 'Gesch??ftsleistung'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	41	,	(SELECT id  FROM metric where bezeichnung like 'Gewinne aus der Investition in die IT'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	42	,	(SELECT id  FROM metric where bezeichnung like 'Gewinne aus der Investition in die IT'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	43	,	(SELECT id  FROM metric where bezeichnung like 'Kundenservice'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	44	,	(SELECT id  FROM metric where bezeichnung like 'Kundenservice'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	45	,	(SELECT id  FROM metric where bezeichnung like 'Kundenservice'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	46	,	(SELECT id  FROM metric where bezeichnung like 'Kundenservice'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	47	,	(SELECT id  FROM metric where bezeichnung like 'Kundenservice'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	48	,	(SELECT id  FROM metric where bezeichnung like 'Kundenservice'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	49	,	(SELECT id  FROM metric where bezeichnung like 'Kundenservice'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	50	,	(SELECT id  FROM metric where bezeichnung like 'H??ufigkeit der Lieferversp??tungen'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	51	,	(SELECT id  FROM metric where bezeichnung like 'Anzahl der fehlenden Artikel'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	52	,	(SELECT id  FROM metric where bezeichnung like 'Besucher der Webseite, die tats??chlich zu Kunden werden'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	53	,	(SELECT id  FROM metric where bezeichnung like 'Einnahmen durch den einzelnen Kunden'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	54	,	(SELECT id  FROM metric where bezeichnung like 'Zielerreichung der Einnahmen durch den neue Kunden'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	55	,	(SELECT id  FROM metric where bezeichnung like '??konomischer Schaden'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	56	,	(SELECT id  FROM metric where bezeichnung like '??konomischer Schaden'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	57	,	(SELECT id  FROM metric where bezeichnung like '??konomischer Schaden'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	58	,	(SELECT id  FROM metric where bezeichnung like '??konomischer Schaden'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	59	,	(SELECT id  FROM metric where bezeichnung like 'Vergleich mit anderen Unternehmen (Benchmark)'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	60	,	(SELECT id  FROM metric where bezeichnung like 'Opportunit??tsverlust'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	61	,	(SELECT id  FROM metric where bezeichnung like 'IT Analagenbestand'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	62	,	(SELECT id  FROM metric where bezeichnung like 'H??ufigkeit an krankheitsbedingten Ausf??llen der Nutzer'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	63	,	(SELECT id  FROM metric where bezeichnung like 'Auswirkung auf Gesundheit und Sicherheit f??r den Nutzer'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	64	,	(SELECT id  FROM metric where bezeichnung like 'Auswirkung auf Gesundheit und Sicherheit f??r den Nutzer'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	65	,	(SELECT id  FROM metric where bezeichnung like 'Auswirkung auf Gesundheit und Sicherheit f??r den Nutzer'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	66	,	(SELECT id  FROM metric where bezeichnung like 'Auswirkung auf Gesundheit und Sicherheit f??r den Nutzer'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	67	,	(SELECT id  FROM metric where bezeichnung like 'Beeinflussung der Sicherheit f??r den Nutzer'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	68	,	(SELECT id  FROM metric where bezeichnung like 'Anteil der Sicherheits-gef??hrdungen'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	69	,	(SELECT id  FROM metric where bezeichnung like 'Grad der Bel??stigung f??r den Kunden'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	70	,	(SELECT id  FROM metric where bezeichnung like 'Auswirkung auf die Umwelt'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	71	,	(SELECT id  FROM metric where bezeichnung like 'Auswirkung auf die Umwelt'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	72	,	(SELECT id  FROM metric where bezeichnung like 'Auswirkung auf die Umwelt'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	73	,	(SELECT id  FROM metric where bezeichnung like 'Grad an Erf??llung von rechtlichen Voraussetzungen f??r  die F??rderung umweltfreundlicher Beschaffungsma??nahmen'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	74	,	(SELECT id  FROM metric where bezeichnung like 'Zielwert zur CO2 -Emission'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	75	,	(SELECT id  FROM metric where bezeichnung like 'Vollst??ndigkeit der Umgebung'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	76	,	(SELECT id  FROM metric where bezeichnung like 'Flexible Nutzungsumgebung'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	77	,	(SELECT id  FROM metric where bezeichnung like 'Produktflexibilit??t'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	78	,	(SELECT id  FROM metric where bezeichnung like 'Unabh??ngigkeit der Kenntnisse'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	79	,	(SELECT id  FROM metric where bezeichnung like 'Wiederherstellungszeit'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	80	,	(SELECT id  FROM metric where bezeichnung like 'Backup-F??higkeit'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	81	,	(SELECT id  FROM metric where bezeichnung like 'Unterst??tzung bei Hardware-St??rungen'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	82	,	(SELECT id  FROM metric where bezeichnung like 'Unterst??tzung bei Netzwerk-St??rungen'));
INSERT INTO public.metric_nfa( nfa_id, metric_id) VALUES (	83	,	(SELECT id  FROM metric where bezeichnung like 'Unterst??tzung bei Software-St??rungen'));

------------------project nfa
INSERT INTO public.project_nfa VALUES (1, 2);
INSERT INTO public.project_nfa VALUES (2, 3);
INSERT INTO public.project_nfa VALUES (3, 4);
INSERT INTO public.project_nfa VALUES (4, 5);

-------------------------stakeholder factors
INSERT INTO public.stakeholder_factor(stakeholder_id, factor_id) VALUES (1,1);
INSERT INTO public.stakeholder_factor(stakeholder_id, factor_id) VALUES (2,2);
INSERT INTO public.stakeholder_factor(stakeholder_id, factor_id) VALUES (3,3);
INSERT INTO public.stakeholder_factor(stakeholder_id, factor_id) VALUES (4,4);
INSERT INTO public.stakeholder_factor(stakeholder_id, factor_id) VALUES (5,5);
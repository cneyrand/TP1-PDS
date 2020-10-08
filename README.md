# TP1-PDS
# Rendu Pablo Espana Gutierrez et Côme Neyrand.

Bonjour, voici le résumé de notre projet.

Nous avions initialement choisi l'ASD suivante :



Turtle ::= PHRASE((Sujet (Predicat (Objet)+)+)*)

Sujet ::= SUJET(String)

Predicat ::= PREDICAT(String)

Objet ::= OBJET(String) | STRING(STRING)



Cependant, il semblait assez difficile de pouvoir adapter cette ASD si l'on voulait rajouter une extension car le TAD Turtle encapsule trop d'information, c'est pourquoi nous avons décidé de garder l'ASD suivante, mieux répartie :



Turtle ::= PHRASE(Sujet*)

Sujet ::= SUJET(String, Predicat+)

Predicat ::= PREDICAT(String, Objet+)

Objet ::= OBJET(String) | STRING(String)



Nous avons ensuite attribué notre ASD de la manière suivante :


[Turtle.Triplets, une liste de String]

Turtle ::= PHRASE(Sujet*) ---{Turtle.Triplets = concaténation des listes Sujets.Triplets}


[Sujet.Triplets, une liste de String
 Sujet.val, une String qui représente le nom du sujet]
 
Sujet ::= SUJET(String, Predicat+) ---{Sujet.val = String; Sujet.Triplets = concaténation des listes Predicat.Duets à laquelle on ajoute la String de Sujet devant}


[Predicat.Duets, une liste de String
 Predicat.val, une String qui représente le nom du prédicat]
 
Predicat ::= PREDICAT(String, Objet+) ---{Predicat.val = String; Predicat.Duets = concaténation des listes Objets.val à laquelle on ajoute la String de Predicat devant}


[Objet.val, une liste d'une seule string qui est celle contenue par l'objet]

Objet ::= OBJET(String) | STRING(String) ---{Objet.val = [String]}




L'idée est de générer la liste des triplets en remontant l'AST.
En ce qui concerne le parser, nous avons défini la grammaire suivante :



T -> S T | epsilon

S -> < Str > (V ;)* V.

V -> < Str > (O, )* O

O -> " Str " | < Str >



Le lexer reconnait les token nécessaires et des string qui comportent des lettres, des chiffres, des espaces, des tirets et des esperluettes.
Nous avions au départ une erreur : à cause d'une récursivité du mauvais côté le parser n'arrivait pas à fonctionner. Pour corriger cela nous avons donc légèrement modifié notre grammaire pour obtenir celle-ci :


T -> ST | epsilon

S -> < Str > V (; V)* .

V -> < Str > O (, O)*

O -> " Str " | < Str >


Nous avons testé notre compilateur sur les deux fichiers tests et obtenu les résultats attendus, ainsi que sur un fichier de test personnel. Pour cela, il suffit après un make de lancer la commande ./main.native < tests/test1.ttl

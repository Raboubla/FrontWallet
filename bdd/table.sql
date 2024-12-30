CREATE TABLE Admin(
   idAdmin INTEGER,
   nomAdmin VARCHAR(50)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   password VARCHAR(255)  NOT NULL,
   PRIMARY KEY(idAdmin)
);

CREATE TABLE Proprietaire(
   idProprietaire INTEGER,
   nomProprietaire VARCHAR(50)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   password VARCHAR(255)  NOT NULL,
   PRIMARY KEY(idProprietaire)
);

CREATE TABLE Unite(
   idUnite INTEGER,
   Unite VARCHAR(50)  NOT NULL,
   PRIMARY KEY(idUnite)
);

CREATE TABLE typeProduit(
   idTypeProduit INTEGER,
   nonTypeProduit VARCHAR(50)  NOT NULL,
   PRIMARY KEY(idTypeProduit)
);

CREATE TABLE Client(
   idClient INTEGER,
   nomClient VARCHAR(50)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   password VARCHAR(255)  NOT NULL,
   telephone VARCHAR(50)  NOT NULL,
   adresse VARCHAR(50)  NOT NULL,
   PRIMARY KEY(idClient)
);

CREATE TABLE Ingredient(
   idIngredient INTEGER,
   nomIngredient VARCHAR(50)  NOT NULL,
   idUnite INTEGER NOT NULL,
   PRIMARY KEY(idIngredient),
   FOREIGN KEY(idUnite) REFERENCES Unite(idUnite)
);

CREATE TABLE Produit(
   idProduit INTEGER,
   nomProduit VARCHAR(255)  NOT NULL,
   prixRevient NUMERIC(15,2)   NOT NULL,
   prixVente NUMERIC(15,2)   NOT NULL,
   image VARCHAR(150) ,
   idTypeProduit INTEGER NOT NULL,
   PRIMARY KEY(idProduit),
   FOREIGN KEY(idTypeProduit) REFERENCES typeProduit(idTypeProduit)
);

CREATE TABLE Stock(
   idStock INTEGER,
   quantiteStock NUMERIC(15,2)   NOT NULL,
   dateFaranyMaj DATE,
   idProduit INTEGER NOT NULL,
   PRIMARY KEY(idStock),
   FOREIGN KEY(idProduit) REFERENCES Produit(idProduit)
);

CREATE TABLE mvtStock(
   idMvtStock INTEGER,
   typeMouvement VARCHAR(50)  NOT NULL,
   quantite NUMERIC(15,2)   NOT NULL,
   dateMvt DATE NOT NULL,
   idStock INTEGER NOT NULL,
   PRIMARY KEY(idMvtStock),
   FOREIGN KEY(idStock) REFERENCES Stock(idStock)
);

CREATE TABLE Formule(
   idFormule INTEGER,
   quantite NUMERIC(15,2)   NOT NULL,
   idProduit INTEGER NOT NULL,
   idIngredient INTEGER NOT NULL,
   PRIMARY KEY(idFormule),
   FOREIGN KEY(idProduit) REFERENCES Produit(idProduit),
   FOREIGN KEY(idIngredient) REFERENCES Ingredient(idIngredient)
);

CREATE TABLE Commande(
   idCommande INTEGER,
   dateCommande DATE NOT NULL,
   status VARCHAR(1000) ,
   idClient INTEGER NOT NULL,
   PRIMARY KEY(idCommande),
   FOREIGN KEY(idClient) REFERENCES Client(idClient)
);

CREATE TABLE commandeProduit(
   idCommandeProduit INTEGER,
   quantite INTEGER NOT NULL,
   idCommande INTEGER NOT NULL,
   idProduit INTEGER NOT NULL,
   PRIMARY KEY(idCommandeProduit),
   FOREIGN KEY(idCommande) REFERENCES Commande(idCommande),
   FOREIGN KEY(idProduit) REFERENCES Produit(idProduit)
);

CREATE TABLE Paiement(
   idPaiement INTEGER,
   montant NUMERIC(15,2)   NOT NULL,
   datePaiement DATE NOT NULL,
   methode VARCHAR(50)  NOT NULL,
   idCommande INTEGER NOT NULL,
   PRIMARY KEY(idPaiement),
   FOREIGN KEY(idCommande) REFERENCES Commande(idCommande)
);

CREATE TABLE Evaluation(
   idEvaluation INTEGER,
   satisfaction VARCHAR(255) ,
   commentaire VARCHAR(1000) ,
   dateEvaluation DATE NOT NULL,
   idCommande INTEGER NOT NULL,
   PRIMARY KEY(idEvaluation),
   FOREIGN KEY(idCommande) REFERENCES Commande(idCommande)
);

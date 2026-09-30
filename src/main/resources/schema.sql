

USE tele_expertise_medicale;


CREATE TABLE utilisateur (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

CREATE TABLE patient (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    date_naissance DATE,
    telephone VARCHAR(20)
);

CREATE TABLE consultation (
    id INT PRIMARY KEY AUTO_INCREMENT,
    date_consultation DATETIME NOT NULL,
    motif VARCHAR(255),
    patient_id INT NOT NULL,
    utilisateur_id INT NOT NULL,

    CONSTRAINT fk_consultation_patient
        FOREIGN KEY (patient_id)
        REFERENCES patient(id),

    CONSTRAINT fk_consultation_utilisateur
        FOREIGN KEY (utilisateur_id)
        REFERENCES utilisateur(id)
);


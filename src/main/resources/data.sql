INSERT INTO utilisateur (nom, email, mot_de_passe, role)
VALUES
('Ahmed Benali', 'ahmed@example.com', 'test123', 'MEDECIN'),
('Sara Amrani', 'sara@example.com', 'test123', 'ADMIN');

INSERT INTO patient (nom, prenom, date_naissance, telephone)
VALUES
('Alaoui', 'Youssef', '1995-04-12', '0612345678'),
('Amrani', 'Sara', '1998-09-20', '0623456789'),
('Bennani', 'Omar', '1987-01-15', '0634567890');


INSERT INTO consultation
    (date_consultation, motif, patient_id, utilisateur_id)
VALUES
    ('2026-09-30 10:00:00', 'Douleur abdominale', 1, 1),
    ('2026-09-30 11:30:00', 'Consultation générale', 2, 1),
    ('2026-09-30 14:00:00', 'Suivi médical', 3, 2);


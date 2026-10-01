USE tele_expertise_medicale;

-- Users
INSERT INTO utilisateurs (nom, email, mot_de_passe, role) VALUES
('Karim Alaoui', 'karim@gmail.com', '$2a$10$testpassword1', 'INFIRMIER'),
('Sara Bennani', 'sara@gmail.com', '$2a$10$testpassword2', 'GENERALISTE');

-- Patients
INSERT INTO patients (
    nom, prenom, date_naissance, numero_securite_sociale,
    tension_arterielle, frequence_cardiaque,
    temperature, frequence_respiratoire, heure_arrivee
) VALUES
(
    'Benali', 'Youssef', '1998-05-12', 'SS001',
    '120/80', 72, 36.7, 16, '2026-09-30 08:30:00'
),
(
    'Amrani', 'Sara', '2001-11-20', 'SS002',
    '125/82', 78, 37.1, 18, '2026-09-30 09:15:00'
),
(
    'El Mansouri', 'Omar', '1985-03-08', 'SS003',
    '140/90', 88, 38.2, 20, '2026-09-30 10:00:00'
);

-- Consultations
INSERT INTO consultations (
    patient_id, motif, observations, diagnostic, traitement, cout, statut
) VALUES
(
    1,
    'Maux de tête',
    'Patient signale des céphalées depuis deux jours',
    'Céphalée légère',
    'Repos et hydratation',
    150.00,
    'TERMINEE'
),
(
    1,
    'Fatigue',
    'Fatigue générale depuis une semaine',
    'Fatigue passagère',
    'Repos',
    150.00,
    'EN_ATTENTE'
),
(
    2,
    'Fièvre',
    'Température légèrement élevée',
    'État grippal',
    'Paracétamol',
    150.00,
    'EN_COURS'
),
(
    3,
    'Toux',
    'Toux persistante depuis trois jours',
    'Infection respiratoire',
    'Traitement symptomatique',
    150.00,
    'TERMINEE'
);
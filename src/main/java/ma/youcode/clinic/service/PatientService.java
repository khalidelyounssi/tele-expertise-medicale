package ma.youcode.clinic.service;

import ma.youcode.clinic.dao.PatientDAO;
import ma.youcode.clinic.entity.Patient;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

public class PatientService {

    private final PatientDAO patientDAO;

    public PatientService(PatientDAO patientDAO) {
        this.patientDAO = Objects.requireNonNull(patientDAO);
    }

    public Patient enregistrer(Patient patient) {
        verifierPatient(patient);
        patient.setHeureArrivee(LocalDateTime.now());
        return patientDAO.save(patient);
    }

    public List<Patient> listerPatientsDuJour() {
        LocalDate aujourdHui = LocalDate.now();

        return patientDAO.findAll()
                .stream()
                .filter(patient -> patient.getHeureArrivee() != null)
                .filter(patient -> patient.getHeureArrivee().toLocalDate().equals(aujourdHui))
                .toList();
    }

    public Optional<Patient> trouverParId(long id) {
        if (id <= 0) {
            return Optional.empty();
        }

        return patientDAO.findById(id);
    }

    private void verifierPatient(Patient patient) {
        if (patient == null) {
            throw new IllegalArgumentException("Le patient est obligatoire");
        }

        if (patient.getNom() == null || patient.getNom().isBlank()) {
            throw new IllegalArgumentException("Le nom est obligatoire");
        }

        if (patient.getPrenom() == null || patient.getPrenom().isBlank()) {
            throw new IllegalArgumentException("Le prénom est obligatoire");
        }

        if (patient.getDateNaissance() == null) {
            throw new IllegalArgumentException("La date de naissance est obligatoire");
        }

        if (patient.getDateNaissance().isAfter(LocalDate.now())) {
            throw new IllegalArgumentException("La date de naissance est invalide");
        }

        if (patient.getNumeroSecuriteSociale() == null || patient.getNumeroSecuriteSociale().isBlank()) {
            throw new IllegalArgumentException("Le numéro de sécurité sociale est obligatoire");
        }
    }
    public List<Patient> patientsEnAttente() {
    return patientDAO.patientsEnAttente();
}
}
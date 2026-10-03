package ma.youcode.clinic.service;

import ma.youcode.clinic.dao.ConsultationDAO;
import ma.youcode.clinic.entity.Consultation;

import java.util.Objects;
import java.util.Optional;

public class ConsultationService {

    private static final double COUT_CONSULTATION = 150.0;

    private final ConsultationDAO consultationDAO;

    public ConsultationService(ConsultationDAO consultationDAO) {
        this.consultationDAO = Objects.requireNonNull(consultationDAO);
    }

    public Consultation cloturer(Consultation consultation) {
        verifierConsultation(consultation);

        if (consultationDAO.findByPatientId(consultation.getPatientId()).isPresent()) {
            throw new IllegalArgumentException("Ce patient possède déjà une consultation");
        }

        consultation.setCout(COUT_CONSULTATION);
        consultation.setStatut(Consultation.Statut.TERMINEE);

        return consultationDAO.save(consultation);
    }

    public Optional<Consultation> trouverParPatientId(long patientId) {
        if (patientId <= 0) {
            return Optional.empty();
        }

        return consultationDAO.findByPatientId(patientId);
    }

    private void verifierConsultation(Consultation consultation) {
        if (consultation == null) {
            throw new IllegalArgumentException("La consultation est obligatoire");
        }

        if (consultation.getPatientId() <= 0) {
            throw new IllegalArgumentException("Le patient est invalide");
        }

        if (consultation.getMotif() == null || consultation.getMotif().isBlank()) {
            throw new IllegalArgumentException("Le motif est obligatoire");
        }

        if (consultation.getObservations() == null || consultation.getObservations().isBlank()) {
            throw new IllegalArgumentException("Les observations sont obligatoires");
        }

        if (consultation.getDiagnostic() == null || consultation.getDiagnostic().isBlank()) {
            throw new IllegalArgumentException("Le diagnostic est obligatoire");
        }

        if (consultation.getTraitement() == null || consultation.getTraitement().isBlank()) {
            throw new IllegalArgumentException("Le traitement est obligatoire");
        }
    }
}
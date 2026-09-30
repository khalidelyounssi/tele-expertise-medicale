package ma.youcode.clinic.dao;

import java.util.Optional;
import ma.youcode.clinic.entity.Consultation;

public interface ConsultationDAO {
    Consultation save(Consultation consultation);
    Optional<Consultation> findByPatientId(long patientId);
}
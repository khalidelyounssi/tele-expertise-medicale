package ma.youcode.clinic.dao.jdbc;

import java.util.Objects;
import java.util.Optional;
import javax.sql.DataSource;

import ma.youcode.clinic.dao.ConsultationDAO;
import ma.youcode.clinic.entity.Consultation;

public class JdbcConsultationDAO implements ConsultationDAO {

    private final DataSource dataSource;

    public JdbcConsultationDAO(DataSource dataSource) {
        this.dataSource = Objects.requireNonNull(dataSource);
    }

    @Override
    public Consultation save(Consultation consultation) {
        throw new UnsupportedOperationException("save à implémenter");
    }

    @Override
    public Optional<Consultation> findByPatientId(long patientId) {
        throw new UnsupportedOperationException("findByPatientId à implémenter");
    }
}
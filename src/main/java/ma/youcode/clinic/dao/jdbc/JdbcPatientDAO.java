package ma.youcode.clinic.dao.jdbc;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import javax.sql.DataSource;

import ma.youcode.clinic.dao.PatientDAO;
import ma.youcode.clinic.entity.Patient;

public class JdbcPatientDAO implements PatientDAO {

    private final DataSource dataSource;

    public JdbcPatientDAO(DataSource dataSource) {
        this.dataSource = Objects.requireNonNull(dataSource);
    }

    @Override
    public Patient save(Patient patient) {
        throw new UnsupportedOperationException("save à implémenter");
    }

    @Override
    public List<Patient> findAll() {
        throw new UnsupportedOperationException("findAll à implémenter");
    }

    @Override
    public Optional<Patient> findById(long id) {
        throw new UnsupportedOperationException("findById à implémenter");
    }
}
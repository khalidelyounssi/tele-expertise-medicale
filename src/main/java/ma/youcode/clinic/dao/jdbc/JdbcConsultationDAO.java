package ma.youcode.clinic.dao.jdbc;

import ma.youcode.clinic.dao.ConsultationDAO;
import ma.youcode.clinic.entity.Consultation;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Objects;
import java.util.Optional;

public class JdbcConsultationDAO implements ConsultationDAO {

    private final DataSource dataSource;

    public JdbcConsultationDAO(DataSource dataSource) {
        this.dataSource = Objects.requireNonNull(dataSource);
    }

    @Override
    public Consultation save(Consultation consultation) {
        String sql = "INSERT INTO consultations (patient_id, motif, observations, diagnostic, traitement, cout, statut) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, consultation.getPatientId());
            statement.setString(2, consultation.getMotif());
            statement.setString(3, consultation.getObservations());
            statement.setString(4, consultation.getDiagnostic());
            statement.setString(5, consultation.getTraitement());
            statement.setDouble(6, consultation.getCout());
            statement.setString(7, consultation.getStatut().name());

            statement.executeUpdate();

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    consultation.setId(generatedKeys.getInt(1));
                }
            }

            return consultation;

        } catch (SQLException e) {
            throw new RuntimeException("Erreur pendant l'enregistrement de la consultation", e);
        }
    }

    @Override
    public Optional<Consultation> findByPatientId(long patientId) {
        String sql = "SELECT id, patient_id, motif, observations, diagnostic, traitement, cout, statut FROM consultations WHERE patient_id = ? ORDER BY id DESC LIMIT 1";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, patientId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return Optional.of(mapConsultation(resultSet));
                }
            }

            return Optional.empty();

        } catch (SQLException e) {
            throw new RuntimeException("Erreur pendant la recherche de la consultation", e);
        }
    }

    private Consultation mapConsultation(ResultSet resultSet) throws SQLException {
        Consultation consultation = new Consultation();

        consultation.setId(resultSet.getInt("id"));
        consultation.setPatientId(resultSet.getInt("patient_id"));
        consultation.setMotif(resultSet.getString("motif"));
        consultation.setObservations(resultSet.getString("observations"));
        consultation.setDiagnostic(resultSet.getString("diagnostic"));
        consultation.setTraitement(resultSet.getString("traitement"));
        consultation.setCout(resultSet.getDouble("cout"));
        consultation.setStatut(Consultation.Statut.valueOf(resultSet.getString("statut")));

        return consultation;
    }
}
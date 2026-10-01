
import ma.youcode.clinic.dao.PatientDAO;
import ma.youcode.clinic.entity.Patient;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

public class JdbcPatientDAO implements PatientDAO {

    private final DataSource dataSource;

    public JdbcPatientDAO(DataSource dataSource) {
        this.dataSource = Objects.requireNonNull(dataSource);
    }

    @Override
    public Patient save(Patient patient) {
        String sql = "INSERT INTO patients (nom, prenom, date_naissance, numero_securite_sociale, tension_arterielle, frequence_cardiaque, temperature, frequence_respiratoire, heure_arrivee) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, patient.getNom());
            statement.setString(2, patient.getPrenom());
            statement.setDate(3, java.sql.Date.valueOf(patient.getDateNaissance()));
            statement.setString(4, patient.getNumeroSecuriteSociale());
            statement.setString(5, patient.getTensionArterielle());
            statement.setInt(6, patient.getFrequenceCardiaque());
            statement.setDouble(7, patient.getTemperature());
            statement.setInt(8, patient.getFrequenceRespiratoire());
            statement.setTimestamp(9, Timestamp.valueOf(patient.getHeureArrivee()));

            statement.executeUpdate();

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    patient.setId(generatedKeys.getInt(1));
                }
            }

            return patient;

        } catch (SQLException e) {
            throw new RuntimeException("Erreur pendant l'enregistrement du patient", e);
        }
    }

    @Override
    public List<Patient> findAll() {
        String sql = "SELECT id, nom, prenom, date_naissance, numero_securite_sociale, tension_arterielle, frequence_cardiaque, temperature, frequence_respiratoire, heure_arrivee FROM patients ORDER BY heure_arrivee ASC";
        List<Patient> patients = new ArrayList<>();

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                patients.add(mapPatient(resultSet));
            }

            return patients;

        } catch (SQLException e) {
            throw new RuntimeException("Erreur pendant la récupération des patients", e);
        }
    }

    @Override
    public Optional<Patient> findById(long id) {
        String sql = "SELECT id, nom, prenom, date_naissance, numero_securite_sociale, tension_arterielle, frequence_cardiaque, temperature, frequence_respiratoire, heure_arrivee FROM patients WHERE id = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return Optional.of(mapPatient(resultSet));
                }
            }

            return Optional.empty();

        } catch (SQLException e) {
            throw new RuntimeException("Erreur pendant la recherche du patient", e);
        }
    }

    private Patient mapPatient(ResultSet resultSet) throws SQLException {
        Patient patient = new Patient();

        patient.setId(resultSet.getInt("id"));
        patient.setNom(resultSet.getString("nom"));
        patient.setPrenom(resultSet.getString("prenom"));
        patient.setDateNaissance(resultSet.getDate("date_naissance").toLocalDate());
        patient.setNumeroSecuriteSociale(resultSet.getString("numero_securite_sociale"));
        patient.setTensionArterielle(resultSet.getString("tension_arterielle"));
        patient.setFrequenceCardiaque(resultSet.getInt("frequence_cardiaque"));
        patient.setTemperature(resultSet.getDouble("temperature"));
        patient.setFrequenceRespiratoire(resultSet.getInt("frequence_respiratoire"));
        patient.setHeureArrivee(resultSet.getTimestamp("heure_arrivee").toLocalDateTime());

        return patient;
    }
}

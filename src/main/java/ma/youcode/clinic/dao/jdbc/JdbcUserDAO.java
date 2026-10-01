package ma.youcode.clinic.dao.jdbc;

import ma.youcode.clinic.dao.UserDAO;
import ma.youcode.clinic.entity.Utilisateur;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;
import java.util.Optional;

public class JdbcUserDAO implements UserDAO {

    private final DataSource dataSource;

    public JdbcUserDAO(DataSource dataSource) {
        this.dataSource = Objects.requireNonNull(dataSource);
    }

    @Override
    public Optional<Utilisateur> findByEmail(String email) {
        String sql = "SELECT id, nom, email, mot_de_passe, role FROM utilisateurs WHERE email = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Utilisateur utilisateur = new Utilisateur();

                    utilisateur.setId(resultSet.getInt("id"));
                    utilisateur.setNom(resultSet.getString("nom"));
                    utilisateur.setEmail(resultSet.getString("email"));
                    utilisateur.setMotDePasse(resultSet.getString("mot_de_passe"));
                    utilisateur.setRole(Utilisateur.Role.valueOf(resultSet.getString("role")));

                    return Optional.of(utilisateur);
                }
            }

            return Optional.empty();

        } catch (SQLException e) {
            throw new RuntimeException("Erreur pendant la recherche de l'utilisateur", e);
        }
    }
}
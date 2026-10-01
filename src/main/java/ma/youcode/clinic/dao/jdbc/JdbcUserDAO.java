package ma.youcode.clinic.dao.jdbc;

import java.util.Objects;
import java.util.Optional;
import javax.sql.DataSource;

import ma.youcode.clinic.dao.UserDAO;
import ma.youcode.clinic.entity.Utilisateur;

public class JdbcUserDAO implements UserDAO {

    private final DataSource dataSource;

    public JdbcUserDAO(DataSource dataSource) {
        this.dataSource = Objects.requireNonNull(dataSource);
    }

    @Override
    public Optional<Utilisateur> findByEmail(String email) {
        throw new UnsupportedOperationException("findByEmail à implémenter");
    }
}
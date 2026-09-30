package ma.youcode.clinic.dao;

import java.util.Optional;
import ma.youcode.clinic.entity.Utilisateur;

public interface UserDAO {
    Optional<Utilisateur> findByEmail(String email);
}
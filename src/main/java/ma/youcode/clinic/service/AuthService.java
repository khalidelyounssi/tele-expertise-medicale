package ma.youcode.clinic.service;

import java.util.Optional;
import ma.youcode.clinic.dao.UserDAO;
import ma.youcode.clinic.entity.Utilisateur;
import org.mindrot.jbcrypt.BCrypt;

public class AuthService {

    private final UserDAO userDAO;

    public AuthService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public Optional<Utilisateur> authentifier(String email, String motDePasse) {
        if (email == null || email.isBlank()
                || motDePasse == null || motDePasse.isBlank()) {
            return Optional.empty();
        }

        Optional<Utilisateur> utilisateur = userDAO.findByEmail(email.trim());

        if (utilisateur.isPresent()
                && BCrypt.checkpw(motDePasse, utilisateur.get().getMotDePasse())) {
            return utilisateur;
        }

        return Optional.empty();
    }
}
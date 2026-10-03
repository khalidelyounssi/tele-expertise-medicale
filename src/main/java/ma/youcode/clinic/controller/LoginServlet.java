package ma.youcode.clinic.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.youcode.clinic.config.DataSourceConfig;
import ma.youcode.clinic.dao.UserDAO;
import ma.youcode.clinic.dao.jdbc.JdbcUserDAO;
import ma.youcode.clinic.entity.Utilisateur;
import ma.youcode.clinic.service.AuthService;

import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() {
        UserDAO userDAO = new JdbcUserDAO(DataSourceConfig.getDataSource());
        authService = new AuthService(userDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        creerTokenCsrf(request);
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        if (!tokenCsrfValide(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Token CSRF invalide");
            return;
        }

        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        Optional<Utilisateur> utilisateur = authService.authentifier(email, motDePasse);

        if (utilisateur.isEmpty()) {
            request.setAttribute("erreur", "Email ou mot de passe incorrect");
            request.setAttribute("email", email);
            doGet(request, response);
            return;
        }

        HttpSession ancienneSession = request.getSession(false);

        if (ancienneSession != null) {
            ancienneSession.invalidate();
        }

        HttpSession nouvelleSession = request.getSession(true);
        nouvelleSession.setAttribute("utilisateur", utilisateur.get());
        nouvelleSession.setAttribute("csrfToken", UUID.randomUUID().toString());

        redirigerSelonRole(request, response, utilisateur.get());
    }

    private void creerTokenCsrf(HttpServletRequest request) {
        HttpSession session = request.getSession();

        if (session.getAttribute("csrfToken") == null) {
            session.setAttribute("csrfToken", UUID.randomUUID().toString());
        }
    }

    private boolean tokenCsrfValide(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session == null) {
            return false;
        }

        String tokenSession = (String) session.getAttribute("csrfToken");
        String tokenFormulaire = request.getParameter("csrfToken");

        return tokenSession != null && tokenSession.equals(tokenFormulaire);
    }

    private void redirigerSelonRole(HttpServletRequest request, HttpServletResponse response, Utilisateur utilisateur) throws IOException {
    if (utilisateur.getRole() == Utilisateur.Role.INFIRMIER) {
        response.sendRedirect(request.getContextPath() + "/patients");
    } else {
        response.sendRedirect(request.getContextPath() + "/generaliste/patients");
    }
}
}
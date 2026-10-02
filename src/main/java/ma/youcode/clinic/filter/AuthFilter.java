package ma.youcode.clinic.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.youcode.clinic.entity.Utilisateur;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String chemin = request.getRequestURI().substring(request.getContextPath().length());

        if (ressourcePublique(chemin)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = session == null ? null : (Utilisateur) session.getAttribute("utilisateur");

        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (chemin.startsWith("/patients") && utilisateur.getRole() != Utilisateur.Role.INFIRMIER) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès réservé aux infirmiers");
            return;
        }

        if (chemin.startsWith("/consultations") && utilisateur.getRole() != Utilisateur.Role.GENERALISTE) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès réservé aux médecins généralistes");
            return;
        }
        if (chemin.startsWith("/generaliste")
                && utilisateur.getRole() != Utilisateur.Role.GENERALISTE) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Accès réservé aux médecins généralistes");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean ressourcePublique(String chemin) {
        return chemin.equals("/login")
                || chemin.startsWith("/css/")
                || chemin.startsWith("/js/")
                || chemin.startsWith("/images/")
                || chemin.equals("/favicon.ico");
    }
}
package ma.youcode.clinic.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.youcode.clinic.config.DataSourceConfig;
import ma.youcode.clinic.dao.PatientDAO;
import ma.youcode.clinic.dao.jdbc.JdbcPatientDAO;
import ma.youcode.clinic.entity.Patient;
import ma.youcode.clinic.service.PatientService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet("/patients")
public class PatientServlet extends HttpServlet {

    private PatientService patientService;

    @Override
    public void init() {
        PatientDAO patientDAO = new JdbcPatientDAO(DataSourceConfig.getDataSource());
        patientService = new PatientService(patientDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        creerTokenCsrf(request);
        request.setAttribute("patients", patientService.listerPatientsDuJour());
        request.getRequestDispatcher("/WEB-INF/views/patients.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        if (!tokenCsrfValide(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Token CSRF invalide");
            return;
        }

        try {
            Patient patient = new Patient();

            patient.setNom(request.getParameter("nom"));
            patient.setPrenom(request.getParameter("prenom"));
            patient.setDateNaissance(LocalDate.parse(request.getParameter("dateNaissance")));
            patient.setNumeroSecuriteSociale(request.getParameter("numeroSecuriteSociale"));
            patient.setTensionArterielle(request.getParameter("tensionArterielle"));
            patient.setFrequenceCardiaque(Integer.parseInt(request.getParameter("frequenceCardiaque")));
            patient.setTemperature(Double.parseDouble(request.getParameter("temperature")));
            patient.setFrequenceRespiratoire(Integer.parseInt(request.getParameter("frequenceRespiratoire")));

            patientService.enregistrer(patient);
            response.sendRedirect(request.getContextPath() + "/patients");

        } catch (IllegalArgumentException e) {
            request.setAttribute("erreur", e.getMessage());
            doGet(request, response);

        } catch (RuntimeException e) {
            request.setAttribute("erreur", "Impossible d'enregistrer le patient");
            doGet(request, response);
        }
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
}
package ma.youcode.clinic.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.youcode.clinic.config.DataSourceConfig;
import ma.youcode.clinic.dao.ConsultationDAO;
import ma.youcode.clinic.dao.PatientDAO;
import ma.youcode.clinic.dao.jdbc.JdbcConsultationDAO;
import ma.youcode.clinic.dao.jdbc.JdbcPatientDAO;
import ma.youcode.clinic.entity.Consultation;
import ma.youcode.clinic.entity.Patient;
import ma.youcode.clinic.service.ConsultationService;
import ma.youcode.clinic.service.PatientService;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/generaliste/consultation")
public class ConsultationServlet extends HttpServlet {

    private PatientService patientService;
    private ConsultationService consultationService;

    @Override
    public void init() {
        DataSource dataSource = DataSourceConfig.getDataSource();

        PatientDAO patientDAO = new JdbcPatientDAO(dataSource);
        ConsultationDAO consultationDAO = new JdbcConsultationDAO(dataSource);

        patientService = new PatientService(patientDAO);
        consultationService = new ConsultationService(consultationDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        creerTokenCsrf(request);
        afficherFormulaire(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        if (!tokenCsrfValide(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Token CSRF invalide");
            return;
        }

        try {
            Consultation consultation = new Consultation();

            consultation.setPatientId(Integer.parseInt(request.getParameter("patientId")));
            consultation.setMotif(request.getParameter("motif"));
            consultation.setObservations(request.getParameter("observations"));
            consultation.setDiagnostic(request.getParameter("diagnostic"));
            consultation.setTraitement(request.getParameter("traitement"));

            consultationService.cloturer(consultation);
            response.sendRedirect(request.getContextPath() + "/generaliste/patients");

        } catch (IllegalArgumentException e) {
            request.setAttribute("erreur", e.getMessage());
            afficherFormulaire(request, response);

        } catch (RuntimeException e) {
            throw new ServletException("Impossible d'enregistrer la consultation", e);
        }
    }

    private void afficherFormulaire(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String patientIdParam = request.getParameter("patientId");

        try {
            long patientId = Long.parseLong(patientIdParam);
            Patient patient = patientService.trouverParId(patientId).orElse(null);

            if (patient == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Patient introuvable");
                return;
            }

            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/WEB-INF/views/consultation.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Identifiant du patient invalide");
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
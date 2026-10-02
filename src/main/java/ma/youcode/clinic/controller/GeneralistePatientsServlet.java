package ma.youcode.clinic.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import ma.youcode.clinic.config.DataSourceConfig;
import ma.youcode.clinic.dao.PatientDAO;
import ma.youcode.clinic.dao.jdbc.JdbcPatientDAO;
import ma.youcode.clinic.service.PatientService;

import java.io.IOException;

@WebServlet("/generaliste/patients")
public class GeneralistePatientsServlet extends HttpServlet {

    private PatientService patientService;

    @Override
    public void init() {
        PatientDAO patientDAO =
                new JdbcPatientDAO(DataSourceConfig.getDataSource());

        patientService = new PatientService(patientDAO);
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setAttribute(
                "patients",
                patientService.patientsEnAttente()
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/attente.jsp"
        ).forward(request, response);
    }
}
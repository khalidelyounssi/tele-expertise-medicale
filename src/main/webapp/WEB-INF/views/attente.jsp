<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Patients en attente</title>
</head>
<body>

    <h1>Patients en attente de consultation</h1>

    <c:choose>
        <c:when test="${empty patients}">
            <p>Aucun patient en attente aujourd'hui.</p>
        </c:when>

        <c:otherwise>
            <table border="1" cellpadding="8">
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Heure d'arrivée</th>
                        <th>Tension artérielle</th>
                        <th>Fréquence cardiaque</th>
                        <th>Température</th>
                        <th>Fréquence respiratoire</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="patient" items="${patients}">
                        <tr>
                            <td><c:out value="${patient.nom}" /></td>
                            <td><c:out value="${patient.prenom}" /></td>
                            <td>
                                <c:out value="${patient.heureArrivee}" />
                            </td>
                            <td>
                                <c:out value="${patient.tensionArterielle}" />
                            </td>
                            <td>
                                <c:out value="${patient.frequenceCardiaque}" />
                            </td>
                            <td>
                                <c:out value="${patient.temperature}" />
                            </td>
                            <td>
                                <c:out value="${patient.frequenceRespiratoire}" />
                            </td>
                            <td>
                                <!-- Add the consultation link after confirming its route -->
                                <button type="button">
                                    Consulter
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

</body>
</html>
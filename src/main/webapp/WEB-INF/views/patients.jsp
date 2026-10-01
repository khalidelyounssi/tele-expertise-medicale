<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des patients</title>
</head>
<body>

<h1>Gestion des patients</h1>

<c:if test="${not empty erreur}">
    <p style="color: red;">
        <c:out value="${erreur}" />
    </p>
</c:if>

<h2>Enregistrer un patient</h2>

<form method="post" action="${pageContext.request.contextPath}/patients">

    <input type="hidden" name="csrfToken" value="<c:out value='${sessionScope.csrfToken}' />">

    <div>
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" required>
    </div>

    <div>
        <label for="prenom">Prénom :</label>
        <input type="text" id="prenom" name="prenom" required>
    </div>

    <div>
        <label for="dateNaissance">Date de naissance :</label>
        <input type="date" id="dateNaissance" name="dateNaissance" required>
    </div>

    <div>
        <label for="numeroSecuriteSociale">Numéro de sécurité sociale :</label>
        <input type="text" id="numeroSecuriteSociale" name="numeroSecuriteSociale" required>
    </div>

    <div>
        <label for="tensionArterielle">Tension artérielle :</label>
        <input type="text" id="tensionArterielle" name="tensionArterielle" placeholder="120/80">
    </div>

    <div>
        <label for="frequenceCardiaque">Fréquence cardiaque :</label>
        <input type="number" id="frequenceCardiaque" name="frequenceCardiaque" min="1" required>
    </div>

    <div>
        <label for="temperature">Température :</label>
        <input type="number" id="temperature" name="temperature" min="30" max="45" step="0.1" required>
    </div>

    <div>
        <label for="frequenceRespiratoire">Fréquence respiratoire :</label>
        <input type="number" id="frequenceRespiratoire" name="frequenceRespiratoire" min="1" required>
    </div>

    <button type="submit">Enregistrer</button>

</form>

<h2>Patients du jour</h2>

<c:choose>
    <c:when test="${empty patients}">
        <p>Aucun patient enregistré aujourd'hui.</p>
    </c:when>

    <c:otherwise>
        <table border="1">
            <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Date de naissance</th>
                <th>N° sécurité sociale</th>
                <th>Tension</th>
                <th>Fréquence cardiaque</th>
                <th>Température</th>
                <th>Fréquence respiratoire</th>
                <th>Heure d'arrivée</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="patient" items="${patients}">
                <tr>
                    <td><c:out value="${patient.id}" /></td>
                    <td><c:out value="${patient.nom}" /></td>
                    <td><c:out value="${patient.prenom}" /></td>
                    <td><c:out value="${patient.dateNaissance}" /></td>
                    <td><c:out value="${patient.numeroSecuriteSociale}" /></td>
                    <td><c:out value="${patient.tensionArterielle}" /></td>
                    <td><c:out value="${patient.frequenceCardiaque}" /></td>
                    <td><c:out value="${patient.temperature}" /></td>
                    <td><c:out value="${patient.frequenceRespiratoire}" /></td>
                    <td><c:out value="${patient.heureArrivee}" /></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>

</body>
</html>
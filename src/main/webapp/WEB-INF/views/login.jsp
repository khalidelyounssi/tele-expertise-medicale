<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
</head>
<body>

<h1>Connexion</h1>

<c:if test="${not empty erreur}">
    <p style="color: red;">
        <c:out value="${erreur}" />
    </p>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/login">

    <input type="hidden" name="csrfToken" value="<c:out value='${sessionScope.csrfToken}' />">

    <div>
        <label for="email">Email :</label>
        <input type="email" id="email" name="email" value="<c:out value='${email}' />" required>
    </div>

    <div>
        <label for="motDePasse">Mot de passe :</label>
        <input type="password" id="motDePasse" name="motDePasse" required>
    </div>

    <button type="submit">Se connecter</button>

</form>

</body>
</html>
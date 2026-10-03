<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediClinic</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-sky-50 text-slate-800">

<header class="border-b border-sky-100 bg-white">
    <div class="mx-auto flex max-w-7xl items-center justify-between px-4 py-4 sm:px-6 lg:px-8">
        <div class="flex items-center gap-3">
            <span class="flex h-11 w-11 items-center justify-center rounded-2xl bg-cyan-600 text-2xl font-black text-white">+</span>
            <span><strong class="block text-xl text-slate-900">MediClinic</strong><small class="text-slate-500">Gestion clinique</small></span>
        </div>
        <form method="post" action="${pageContext.request.contextPath}/logout">
            <input type="hidden" name="csrfToken" value="<c:out value='${sessionScope.csrfToken}' />">
            <button type="submit" class="rounded-xl border border-slate-200 px-4 py-2.5 text-sm font-bold text-slate-600 hover:bg-red-50 hover:text-red-600">Déconnexion</button>
        </form>
    </div>
</header>

<main class="mx-auto max-w-7xl px-4 py-10 sm:px-6 lg:px-8">
    <section class="relative overflow-hidden rounded-[2rem] bg-gradient-to-br from-cyan-600 to-sky-800 p-8 text-white shadow-2xl shadow-cyan-900/15 sm:p-12">
        <div class="absolute -right-20 -top-20 h-72 w-72 rounded-full bg-white/10"></div>
        <div class="relative max-w-3xl">
            <span class="rounded-full bg-white/15 px-4 py-2 text-sm font-semibold">Tableau de bord clinique</span>
            <h1 class="mt-6 text-4xl font-black leading-tight sm:text-5xl">Bienvenue, <c:out value="${sessionScope.utilisateur.nom}" /></h1>
            <p class="mt-4 text-lg text-cyan-50">Accédez rapidement à votre espace de travail sécurisé.</p>
        </div>
    </section>

    <section class="mt-8 grid gap-6 md:grid-cols-2">
        <c:if test="${sessionScope.utilisateur.role == 'INFIRMIER'}">
            <a href="${pageContext.request.contextPath}/patients" class="group rounded-[2rem] bg-white p-8 shadow-lg shadow-sky-900/5 transition hover:-translate-y-1 hover:shadow-xl">
                <span class="flex h-14 w-14 items-center justify-center rounded-2xl bg-cyan-100 text-2xl">♡</span>
                <h2 class="mt-6 text-2xl font-black text-slate-900">Accueil infirmier</h2>
                <p class="mt-3 text-slate-500">Enregistrer un patient, saisir ses constantes et consulter la liste du jour.</p>
                <span class="mt-6 inline-block font-bold text-cyan-700">Ouvrir l'espace →</span>
            </a>
        </c:if>
        <c:if test="${sessionScope.utilisateur.role == 'GENERALISTE'}">
            <a href="${pageContext.request.contextPath}/generaliste/patients" class="group rounded-[2rem] bg-white p-8 shadow-lg shadow-sky-900/5 transition hover:-translate-y-1 hover:shadow-xl">
                <span class="flex h-14 w-14 items-center justify-center rounded-2xl bg-cyan-100 text-2xl">✚</span>
                <h2 class="mt-6 text-2xl font-black text-slate-900">Patients en attente</h2>
                <p class="mt-3 text-slate-500">Consulter les constantes et ouvrir le dossier médical du prochain patient.</p>
                <span class="mt-6 inline-block font-bold text-cyan-700">Voir la file active →</span>
            </a>
        </c:if>
        <div class="rounded-[2rem] bg-gradient-to-br from-white to-cyan-50 p-8 shadow-lg shadow-sky-900/5">
            <span class="text-sm font-bold uppercase tracking-[0.18em] text-cyan-600">MediClinic</span>
            <h2 class="mt-3 text-2xl font-black text-slate-900">Une prise en charge fluide</h2>
            <p class="mt-3 text-slate-500">Les données suivent le patient de l'accueil infirmier jusqu'à la clôture de sa consultation.</p>
        </div>
    </section>
</main>

</body>
</html>

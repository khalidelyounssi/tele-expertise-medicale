<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patients en attente | MediClinic</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-sky-50 text-slate-800">

<header class="sticky top-0 z-20 border-b border-sky-100 bg-white/95 backdrop-blur">
    <div class="mx-auto flex max-w-7xl items-center justify-between px-4 py-4 sm:px-6 lg:px-8">
        <a href="${pageContext.request.contextPath}/generaliste/patients" class="flex items-center gap-3">
            <span class="flex h-11 w-11 items-center justify-center rounded-2xl bg-cyan-600 text-2xl font-black text-white">+</span>
            <span><strong class="block text-xl text-slate-900">MediClinic</strong><small class="text-slate-500">Espace généraliste</small></span>
        </a>
        <div class="flex items-center gap-3">
            <div class="hidden text-right sm:block"><p class="text-sm font-bold text-slate-800"><c:out value="${sessionScope.utilisateur.nom}" /></p><p class="text-xs uppercase tracking-wider text-cyan-600">Médecin généraliste</p></div>
            <form method="post" action="${pageContext.request.contextPath}/logout">
                <input type="hidden" name="csrfToken" value="<c:out value='${sessionScope.csrfToken}' />">
                <button type="submit" class="rounded-xl border border-slate-200 px-4 py-2.5 text-sm font-bold text-slate-600 transition hover:border-red-200 hover:bg-red-50 hover:text-red-600">Déconnexion</button>
            </form>
        </div>
    </div>
</header>

<main class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
    <section class="relative overflow-hidden rounded-[2rem] bg-gradient-to-r from-cyan-600 to-sky-700 p-7 text-white shadow-xl shadow-cyan-900/10 sm:p-10">
        <div class="absolute -right-10 -top-24 h-72 w-72 rounded-full bg-white/10"></div>
        <div class="relative flex flex-col gap-6 md:flex-row md:items-end md:justify-between">
            <div><span class="rounded-full bg-white/15 px-4 py-2 text-sm font-semibold">File active</span><h1 class="mt-5 text-3xl font-black sm:text-4xl">Patients en attente</h1><p class="mt-3 max-w-2xl text-cyan-50">Consultez les constantes, ouvrez le dossier et clôturez la consultation depuis un seul espace.</p></div>
            <div class="rounded-2xl bg-white/15 px-6 py-4 text-center backdrop-blur"><p class="text-sm text-cyan-50">Statut</p><p class="mt-1 text-xl font-black">Service ouvert</p></div>
        </div>
    </section>

    <section class="mt-8 rounded-[2rem] bg-white p-6 shadow-lg shadow-sky-900/5 sm:p-8">
        <div class="mb-6 flex flex-col gap-2 sm:flex-row sm:items-end sm:justify-between">
            <div><span class="text-sm font-bold uppercase tracking-[0.18em] text-cyan-600">Aujourd'hui</span><h2 class="mt-2 text-2xl font-black text-slate-900">Ordre de passage</h2></div>
            <span class="rounded-full bg-amber-50 px-4 py-2 text-sm font-bold text-amber-700">Du plus ancien au plus récent</span>
        </div>

        <c:choose>
            <c:when test="${empty patients}">
                <div class="rounded-2xl border border-dashed border-sky-200 bg-sky-50 p-12 text-center">
                    <div class="mx-auto flex h-16 w-16 items-center justify-center rounded-full bg-white text-3xl shadow-sm">✓</div>
                    <p class="mt-5 text-lg font-black text-slate-800">Aucun patient en attente</p>
                    <p class="mt-2 text-sm text-slate-500">Tous les patients du jour ont été pris en charge.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="overflow-x-auto rounded-2xl border border-slate-100">
                    <table class="min-w-full text-left text-sm">
                        <thead class="bg-slate-50 text-xs uppercase tracking-wider text-slate-500">
                        <tr><th class="px-5 py-4">Patient</th><th class="px-5 py-4">Arrivée</th><th class="px-5 py-4">Tension</th><th class="px-5 py-4">Cardiaque</th><th class="px-5 py-4">Température</th><th class="px-5 py-4">Respiration</th><th class="px-5 py-4 text-right">Action</th></tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100">
                        <c:forEach var="patient" items="${patients}">
                            <tr class="transition hover:bg-cyan-50/50">
                                <td class="whitespace-nowrap px-5 py-5"><strong class="block text-slate-900"><c:out value="${patient.prenom}" /> <c:out value="${patient.nom}" /></strong><small class="text-slate-500">Dossier #<c:out value="${patient.id}" /></small></td>
                                <td class="whitespace-nowrap px-5 py-5 font-semibold text-cyan-700"><c:out value="${patient.heureArrivee}" /></td>
                                <td class="whitespace-nowrap px-5 py-5"><span class="rounded-lg bg-sky-50 px-3 py-2 font-semibold"><c:out value="${patient.tensionArterielle}" /></span></td>
                                <td class="whitespace-nowrap px-5 py-5"><c:out value="${patient.frequenceCardiaque}" /> bpm</td>
                                <td class="whitespace-nowrap px-5 py-5"><c:out value="${patient.temperature}" /> °C</td>
                                <td class="whitespace-nowrap px-5 py-5"><c:out value="${patient.frequenceRespiratoire}" /> /min</td>
                                <td class="whitespace-nowrap px-5 py-5 text-right">
                                    <c:url var="consultationUrl" value="/generaliste/consultation"><c:param name="patientId" value="${patient.id}" /></c:url>
                                    <a href="${consultationUrl}" class="inline-flex rounded-xl bg-cyan-600 px-4 py-2.5 font-bold text-white shadow-md shadow-cyan-600/20 transition hover:bg-cyan-700">Consulter</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>
</main>

</body>
</html>

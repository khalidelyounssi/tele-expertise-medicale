<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultation médicale | MediClinic</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-sky-50 text-slate-800">

<header class="border-b border-sky-100 bg-white">
    <div class="mx-auto flex max-w-7xl items-center justify-between px-4 py-4 sm:px-6 lg:px-8">
        <a href="${pageContext.request.contextPath}/generaliste/patients" class="flex items-center gap-3">
            <span class="flex h-11 w-11 items-center justify-center rounded-2xl bg-cyan-600 text-2xl font-black text-white">+</span>
            <span><strong class="block text-xl text-slate-900">MediClinic</strong><small class="text-slate-500">Consultation médicale</small></span>
        </a>
        <form method="post" action="${pageContext.request.contextPath}/logout">
            <input type="hidden" name="csrfToken" value="<c:out value='${sessionScope.csrfToken}' />">
            <button type="submit" class="rounded-xl border border-slate-200 px-4 py-2.5 text-sm font-bold text-slate-600 transition hover:border-red-200 hover:bg-red-50 hover:text-red-600">Déconnexion</button>
        </form>
    </div>
</header>

<main class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
    <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div><a href="${pageContext.request.contextPath}/generaliste/patients" class="text-sm font-bold text-cyan-700 hover:text-cyan-900">← Retour à la file d'attente</a><h1 class="mt-3 text-3xl font-black text-slate-900">Consultation médicale</h1></div>
        <div class="rounded-2xl bg-white px-5 py-3 text-sm shadow-sm"><span class="text-slate-500">Coût fixe</span><strong class="ml-2 text-lg text-cyan-700">150 DH</strong></div>
    </div>

    <c:if test="${not empty erreur}">
        <div class="mb-6 rounded-2xl border border-red-200 bg-red-50 px-5 py-4 font-semibold text-red-700"><c:out value="${erreur}" /></div>
    </c:if>

    <div class="grid gap-8 lg:grid-cols-[360px_1fr]">
        <aside class="h-fit space-y-6">
            <section class="overflow-hidden rounded-[2rem] bg-gradient-to-br from-cyan-600 to-sky-700 p-7 text-white shadow-xl shadow-cyan-900/10">
                <span class="inline-flex h-14 w-14 items-center justify-center rounded-2xl bg-white/15 text-2xl font-black">P</span>
                <h2 class="mt-5 text-2xl font-black"><c:out value="${patient.prenom}" /> <c:out value="${patient.nom}" /></h2>
                <p class="mt-1 text-sm text-cyan-100">Dossier patient #<c:out value="${patient.id}" /></p>
                <div class="mt-6 space-y-3 border-t border-white/20 pt-5 text-sm">
                    <p class="flex justify-between gap-4"><span class="text-cyan-100">Né(e) le</span><strong><c:out value="${patient.dateNaissance}" /></strong></p>
                    <p class="flex justify-between gap-4"><span class="text-cyan-100">N° sécurité</span><strong><c:out value="${patient.numeroSecuriteSociale}" /></strong></p>
                </div>
            </section>

            <section class="rounded-[2rem] bg-white p-6 shadow-lg shadow-sky-900/5">
                <h3 class="font-black text-slate-900">Signes vitaux</h3>
                <div class="mt-5 grid grid-cols-2 gap-3">
                    <div class="rounded-2xl bg-sky-50 p-4"><small class="text-slate-500">Tension</small><strong class="mt-1 block text-lg text-slate-900"><c:out value="${patient.tensionArterielle}" /></strong></div>
                    <div class="rounded-2xl bg-sky-50 p-4"><small class="text-slate-500">Cardiaque</small><strong class="mt-1 block text-lg text-slate-900"><c:out value="${patient.frequenceCardiaque}" /> bpm</strong></div>
                    <div class="rounded-2xl bg-sky-50 p-4"><small class="text-slate-500">Température</small><strong class="mt-1 block text-lg text-slate-900"><c:out value="${patient.temperature}" /> °C</strong></div>
                    <div class="rounded-2xl bg-sky-50 p-4"><small class="text-slate-500">Respiration</small><strong class="mt-1 block text-lg text-slate-900"><c:out value="${patient.frequenceRespiratoire}" /> /min</strong></div>
                </div>
            </section>
        </aside>

        <section class="rounded-[2rem] bg-white p-6 shadow-lg shadow-sky-900/5 sm:p-8">
            <span class="text-sm font-bold uppercase tracking-[0.18em] text-cyan-600">Compte rendu</span>
            <h2 class="mt-2 text-2xl font-black text-slate-900">Détails de la consultation</h2>
            <p class="mt-2 text-sm text-slate-500">Complétez tous les champs avant de clôturer la consultation.</p>

            <form method="post" action="${pageContext.request.contextPath}/generaliste/consultation" class="mt-7 space-y-5">
                <input type="hidden" name="patientId" value="<c:out value='${patient.id}' />">
                <input type="hidden" name="csrfToken" value="<c:out value='${sessionScope.csrfToken}' />">
                <div><label for="motif" class="mb-2 block text-sm font-bold">Motif de consultation</label><textarea id="motif" name="motif" rows="3" required placeholder="Décrivez la raison principale..." class="w-full resize-none rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:bg-white focus:ring-4 focus:ring-cyan-100"><c:out value="${param.motif}" /></textarea></div>
                <div><label for="observations" class="mb-2 block text-sm font-bold">Observations cliniques</label><textarea id="observations" name="observations" rows="5" required placeholder="Examen clinique, symptômes..." class="w-full resize-none rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:bg-white focus:ring-4 focus:ring-cyan-100"><c:out value="${param.observations}" /></textarea></div>
                <div class="grid gap-5 md:grid-cols-2">
                    <div><label for="diagnostic" class="mb-2 block text-sm font-bold">Diagnostic</label><textarea id="diagnostic" name="diagnostic" rows="4" required placeholder="Diagnostic retenu..." class="w-full resize-none rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:bg-white focus:ring-4 focus:ring-cyan-100"><c:out value="${param.diagnostic}" /></textarea></div>
                    <div><label for="traitement" class="mb-2 block text-sm font-bold">Traitement prescrit</label><textarea id="traitement" name="traitement" rows="4" required placeholder="Prescription et recommandations..." class="w-full resize-none rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:bg-white focus:ring-4 focus:ring-cyan-100"><c:out value="${param.traitement}" /></textarea></div>
                </div>
                <div class="flex flex-col gap-4 border-t border-slate-100 pt-6 sm:flex-row sm:items-center sm:justify-between">
                    <p class="text-sm text-slate-500">La clôture enregistrera le statut <strong class="text-slate-800">TERMINÉE</strong>.</p>
                    <button type="submit" class="rounded-xl bg-gradient-to-r from-cyan-600 to-sky-600 px-6 py-3.5 font-bold text-white shadow-lg shadow-cyan-600/20 transition hover:-translate-y-0.5">Clôturer la consultation</button>
                </div>
            </form>
        </section>
    </div>
</main>

</body>
</html>

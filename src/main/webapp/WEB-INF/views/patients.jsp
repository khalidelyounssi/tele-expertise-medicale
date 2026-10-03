<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil infirmier | MediClinic</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-sky-50 text-slate-800">

<header class="sticky top-0 z-20 border-b border-sky-100 bg-white/95 backdrop-blur">
    <div class="mx-auto flex max-w-7xl items-center justify-between px-4 py-4 sm:px-6 lg:px-8">
        <a href="${pageContext.request.contextPath}/patients" class="flex items-center gap-3">
            <span class="flex h-11 w-11 items-center justify-center rounded-2xl bg-cyan-600 text-2xl font-black text-white">+</span>
            <span><strong class="block text-xl text-slate-900">MediClinic</strong><small class="text-slate-500">Espace infirmier</small></span>
        </a>
        <div class="flex items-center gap-3">
            <div class="hidden text-right sm:block">
                <p class="text-sm font-bold text-slate-800"><c:out value="${sessionScope.utilisateur.nom}" /></p>
                <p class="text-xs uppercase tracking-wider text-cyan-600">Infirmier</p>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/logout">
                <input type="hidden" name="csrfToken" value="<c:out value='${sessionScope.csrfToken}' />">
                <button type="submit" class="rounded-xl border border-slate-200 px-4 py-2.5 text-sm font-bold text-slate-600 transition hover:border-red-200 hover:bg-red-50 hover:text-red-600">Déconnexion</button>
            </form>
        </div>
    </div>
</header>

<main class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
    <section class="relative overflow-hidden rounded-[2rem] bg-gradient-to-r from-cyan-600 to-sky-700 p-7 text-white shadow-xl shadow-cyan-900/10 sm:p-10">
        <div class="absolute -right-16 -top-20 h-64 w-64 rounded-full bg-white/10"></div>
        <div class="relative">
            <span class="rounded-full bg-white/15 px-4 py-2 text-sm font-semibold">Accueil clinique</span>
            <h1 class="mt-5 text-3xl font-black sm:text-4xl">Gestion des patients</h1>
            <p class="mt-3 max-w-2xl text-cyan-50">Enregistrez l'identité et les signes vitaux. L'heure d'arrivée sera ajoutée automatiquement.</p>
        </div>
    </section>

    <c:if test="${not empty erreur}">
        <div class="mt-6 rounded-2xl border border-red-200 bg-red-50 px-5 py-4 font-semibold text-red-700"><c:out value="${erreur}" /></div>
    </c:if>

    <div class="mt-8 grid gap-8 xl:grid-cols-[420px_1fr]">
        <section class="h-fit rounded-[2rem] bg-white p-6 shadow-lg shadow-sky-900/5 sm:p-8">
            <span class="text-sm font-bold uppercase tracking-[0.18em] text-cyan-600">Nouveau dossier</span>
            <h2 class="mb-7 mt-2 text-2xl font-black text-slate-900">Enregistrer un patient</h2>

            <form method="post" action="${pageContext.request.contextPath}/patients" class="space-y-5">
                <input type="hidden" name="csrfToken" value="<c:out value='${sessionScope.csrfToken}' />">
                <div class="grid gap-4 sm:grid-cols-2 xl:grid-cols-1 2xl:grid-cols-2">
                    <div><label for="nom" class="mb-2 block text-sm font-bold">Nom</label><input type="text" id="nom" name="nom" required class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"></div>
                    <div><label for="prenom" class="mb-2 block text-sm font-bold">Prénom</label><input type="text" id="prenom" name="prenom" required class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"></div>
                </div>
                <div><label for="dateNaissance" class="mb-2 block text-sm font-bold">Date de naissance</label><input type="date" id="dateNaissance" name="dateNaissance" required class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"></div>
                <div><label for="numeroSecuriteSociale" class="mb-2 block text-sm font-bold">Numéro de sécurité sociale</label><input type="text" id="numeroSecuriteSociale" name="numeroSecuriteSociale" required placeholder="Ex. SS004" class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"></div>

                <div class="border-t border-slate-100 pt-5">
                    <h3 class="mb-4 font-black text-slate-900">Signes vitaux</h3>
                    <div class="grid gap-4 sm:grid-cols-2 xl:grid-cols-1 2xl:grid-cols-2">
                        <div><label for="tensionArterielle" class="mb-2 block text-sm font-bold">Tension artérielle</label><input type="text" id="tensionArterielle" name="tensionArterielle" placeholder="120/80" class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"></div>
                        <div><label for="frequenceCardiaque" class="mb-2 block text-sm font-bold">Fréquence cardiaque</label><input type="number" id="frequenceCardiaque" name="frequenceCardiaque" min="1" required placeholder="72" class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"></div>
                        <div><label for="temperature" class="mb-2 block text-sm font-bold">Température °C</label><input type="number" id="temperature" name="temperature" min="30" max="45" step="0.1" required placeholder="36.7" class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"></div>
                        <div><label for="frequenceRespiratoire" class="mb-2 block text-sm font-bold">Fréquence respiratoire</label><input type="number" id="frequenceRespiratoire" name="frequenceRespiratoire" min="1" required placeholder="16" class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"></div>
                    </div>
                </div>
                <button type="submit" class="w-full rounded-xl bg-gradient-to-r from-cyan-600 to-sky-600 px-5 py-3.5 font-bold text-white shadow-lg shadow-cyan-600/20 transition hover:-translate-y-0.5">Enregistrer le patient</button>
            </form>
        </section>

        <section class="min-w-0 rounded-[2rem] bg-white p-6 shadow-lg shadow-sky-900/5 sm:p-8">
            <div class="mb-6 flex flex-col gap-2 sm:flex-row sm:items-end sm:justify-between">
                <div><span class="text-sm font-bold uppercase tracking-[0.18em] text-cyan-600">Suivi journalier</span><h2 class="mt-2 text-2xl font-black text-slate-900">Patients du jour</h2></div>
                <span class="rounded-full bg-cyan-50 px-4 py-2 text-sm font-bold text-cyan-700">Triés par heure d'arrivée</span>
            </div>
            <c:choose>
                <c:when test="${empty patients}">
                    <div class="rounded-2xl border border-dashed border-sky-200 bg-sky-50 p-10 text-center"><p class="font-bold text-slate-700">Aucun patient enregistré aujourd'hui</p><p class="mt-2 text-sm text-slate-500">Le prochain patient apparaîtra ici après son enregistrement.</p></div>
                </c:when>
                <c:otherwise>
                    <div class="overflow-x-auto rounded-2xl border border-slate-100">
                        <table class="min-w-full text-left text-sm">
                            <thead class="bg-slate-50 text-xs uppercase tracking-wider text-slate-500"><tr><th class="px-4 py-4">Patient</th><th class="px-4 py-4">NSS</th><th class="px-4 py-4">Tension</th><th class="px-4 py-4">Cardiaque</th><th class="px-4 py-4">Temp.</th><th class="px-4 py-4">Resp.</th><th class="px-4 py-4">Arrivée</th></tr></thead>
                            <tbody class="divide-y divide-slate-100">
                            <c:forEach var="patient" items="${patients}">
                                <tr class="transition hover:bg-cyan-50/50">
                                    <td class="whitespace-nowrap px-4 py-4"><strong class="block text-slate-900"><c:out value="${patient.prenom}" /> <c:out value="${patient.nom}" /></strong><small class="text-slate-500">Né(e) le <c:out value="${patient.dateNaissance}" /></small></td>
                                    <td class="whitespace-nowrap px-4 py-4"><c:out value="${patient.numeroSecuriteSociale}" /></td>
                                    <td class="whitespace-nowrap px-4 py-4"><c:out value="${patient.tensionArterielle}" /></td>
                                    <td class="whitespace-nowrap px-4 py-4"><c:out value="${patient.frequenceCardiaque}" /> bpm</td>
                                    <td class="whitespace-nowrap px-4 py-4"><c:out value="${patient.temperature}" /> °C</td>
                                    <td class="whitespace-nowrap px-4 py-4"><c:out value="${patient.frequenceRespiratoire}" /> /min</td>
                                    <td class="whitespace-nowrap px-4 py-4 font-semibold text-cyan-700"><c:out value="${patient.heureArrivee}" /></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>
    </div>
</main>

</body>
</html>

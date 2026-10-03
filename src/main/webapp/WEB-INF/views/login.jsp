<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion | MediClinic</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-sky-50 via-cyan-50 to-blue-100 text-slate-800">

<main class="mx-auto flex min-h-screen max-w-7xl items-center px-4 py-10 sm:px-6 lg:px-8">
    <section class="grid w-full overflow-hidden rounded-[2rem] bg-white shadow-2xl shadow-cyan-900/10 lg:grid-cols-2">
        <div class="relative hidden min-h-[650px] overflow-hidden bg-gradient-to-br from-cyan-600 to-sky-800 p-12 text-white lg:flex lg:flex-col lg:justify-between">
            <div class="absolute -right-24 -top-24 h-72 w-72 rounded-full bg-white/10"></div>
            <div class="absolute -bottom-20 -left-20 h-64 w-64 rounded-full bg-cyan-300/20"></div>
            <div class="relative flex items-center gap-3">
                <div class="flex h-12 w-12 items-center justify-center rounded-2xl bg-white text-2xl font-black text-cyan-700">+</div>
                <div><p class="text-2xl font-black tracking-tight">MediClinic</p><p class="text-sm text-cyan-100">Gestion clinique sécurisée</p></div>
            </div>
            <div class="relative">
                <span class="inline-flex rounded-full bg-white/15 px-4 py-2 text-sm font-semibold backdrop-blur">Espace professionnel</span>
                <h1 class="mt-6 max-w-md text-5xl font-black leading-tight">Des soins mieux organisés, pour chaque patient.</h1>
                <p class="mt-5 max-w-lg text-lg leading-8 text-cyan-50">Centralisez l'accueil infirmier, les constantes et les consultations dans une interface claire.</p>
            </div>
            <div class="relative grid grid-cols-3 gap-3 text-center text-sm">
                <div class="rounded-2xl bg-white/10 p-4 backdrop-blur"><strong class="block text-xl">24/7</strong>Disponible</div>
                <div class="rounded-2xl bg-white/10 p-4 backdrop-blur"><strong class="block text-xl">100%</strong>Sécurisé</div>
                <div class="rounded-2xl bg-white/10 p-4 backdrop-blur"><strong class="block text-xl">2</strong>Espaces métier</div>
            </div>
        </div>

        <div class="flex min-h-[650px] items-center p-7 sm:p-12 lg:p-16">
            <div class="mx-auto w-full max-w-md">
                <div class="mb-10 flex items-center gap-3 lg:hidden">
                    <div class="flex h-11 w-11 items-center justify-center rounded-2xl bg-cyan-600 text-2xl font-black text-white">+</div>
                    <p class="text-2xl font-black text-slate-900">MediClinic</p>
                </div>
                <span class="text-sm font-bold uppercase tracking-[0.2em] text-cyan-600">Bienvenue</span>
                <h2 class="mt-3 text-4xl font-black tracking-tight text-slate-900">Connexion</h2>
                <p class="mt-3 text-slate-500">Accédez à votre espace infirmier ou généraliste.</p>

                <c:if test="${not empty erreur}">
                    <div class="mt-6 rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-semibold text-red-700"><c:out value="${erreur}" /></div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/login" class="mt-8 space-y-5">
                    <input type="hidden" name="csrfToken" value="<c:out value='${sessionScope.csrfToken}' />">
                    <div>
                        <label for="email" class="mb-2 block text-sm font-bold text-slate-700">Adresse email</label>
                        <input type="email" id="email" name="email" value="<c:out value='${email}' />" required autocomplete="email" placeholder="nom@clinique.ma" class="w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3.5 outline-none transition focus:border-cyan-500 focus:bg-white focus:ring-4 focus:ring-cyan-100">
                    </div>
                    <div>
                        <label for="motDePasse" class="mb-2 block text-sm font-bold text-slate-700">Mot de passe</label>
                        <input type="password" id="motDePasse" name="motDePasse" required autocomplete="current-password" placeholder="Votre mot de passe" class="w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3.5 outline-none transition focus:border-cyan-500 focus:bg-white focus:ring-4 focus:ring-cyan-100">
                    </div>
                    <button type="submit" class="w-full rounded-2xl bg-gradient-to-r from-cyan-600 to-sky-600 px-5 py-4 font-bold text-white shadow-lg shadow-cyan-600/20 transition hover:-translate-y-0.5 hover:shadow-xl">Se connecter</button>
                </form>
                <div class="mt-8 rounded-2xl bg-sky-50 p-4 text-sm text-slate-600"><strong class="text-slate-800">Accès réservé</strong><br>Utilisez le compte professionnel fourni par la clinique.</div>
            </div>
        </div>
    </section>
</main>

</body>
</html>

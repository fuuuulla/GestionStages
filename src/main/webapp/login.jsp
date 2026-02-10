<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Gestion de Stages</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgb(233, 231, 226) 0%, rgb(192, 192, 192) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            width: 100%;
        }

        .header {
            text-align: center;
            margin-bottom: 50px;
            color: white;
        }

        .header h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .header p {
            font-size: 18px;
            opacity: 0.9;
        }

        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.3);
        }

        .card-header {
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 3px solid;
            padding-bottom: 15px;
        }

        .card-header h2 {
            font-size: 24px;
            color: #1E2761;
        }

        .card-header p {
            color: #999;
            font-size: 13px;
            margin-top: 5px;
        }

        .card-header .icon i {
            font-size: 42px;
            margin-bottom: 12px;
            transition: transform 0.3s ease;
        }

        .card:hover .icon i {
            transform: scale(1.15) rotate(-3deg);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #2F3C7E;
            font-weight: bold;
            font-size: 14px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            top: 50%;
            left: 12px;
            transform: translateY(-50%);
            color: #999;
            font-size: 14px;
        }

        .input-wrapper input {
            width: 100%;
            padding: 12px 12px 12px 38px;
            border: 2px solid #CADCFC;
            border-radius: 6px;
            font-size: 14px;
        }

        .input-wrapper input:focus {
            outline: none;
            border-color: #F96167;
            box-shadow: 0 0 0 3px rgba(249, 97, 103, 0.1);
        }

        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            cursor: pointer;
        }

        .info-text {
            text-align: center;
            color: #666;
            font-size: 13px;
            margin-top: 15px;
        }

        .info-text i {
            margin-right: 5px;
        }

        /* COLORS PER ROLE */
        .admin-card { border-top: 4px solid #1E2761; }
        .admin-card .card-header { border-color: #1E2761; }
        .admin-card button { background: #1E2761; }
        .admin-card .icon i { color: #1E2761; }

        .insfp-card { border-top: 4px solid #2F3C7E; }
        .insfp-card .card-header { border-color: #2F3C7E; }
        .insfp-card button { background: #2F3C7E; }
        .insfp-card .icon i { color: #2F3C7E; }

        .student-card { border-top: 4px solid #F96167; }
        .student-card .card-header { border-color: #F96167; }
        .student-card button { background: #F96167; }
        .student-card .icon i { color: #F96167; }

        @media (max-width: 768px) {
            .header h1 { font-size: 28px; }
            .card { padding: 30px; }
        }
    </style>
</head>

<body>
<div class="container">

    <div class="header">
        <h1><i class="fa-solid fa-graduation-cap"></i> Gestion de Stages</h1>
        <p>Choisissez votre profil pour vous connecter</p>
    </div>

    <div class="cards-container">

        <!-- ENTREPRISE -->
        <div class="card admin-card">
            <div class="card-header">
                <div class="icon"><i class="fa-solid fa-building"></i></div>
                <h2>Entreprise</h2>
                <p>Gestion des candidatures</p>
            </div>

            <form method="POST" action="${pageContext.request.contextPath}/login">
                <div class="form-group">
                    <label>Email</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-envelope"></i>
                        <input type="email" name="email" required placeholder="admin@entreprise.com">
                    </div>
                </div>

                <div class="form-group">
                    <label>Mot de passe</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" name="password" required placeholder="••••••••">
                    </div>
                </div>

                <button type="submit">Se connecter</button>

                <div class="info-text">
                    <i class="fa-solid fa-circle-info"></i> Accès réservé aux entreprises
                </div>
            </form>
        </div>

        <!-- INSFP -->
        <div class="card insfp-card">
            <div class="card-header">
                <div class="icon"><i class="fa-solid fa-school"></i></div>
                <h2>INSFP Rahmania</h2>
                <p>Gestion des offres</p>
            </div>

            <form method="POST" action="${pageContext.request.contextPath}/login">
                <div class="form-group">
                    <label>Email</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-envelope"></i>
                        <input type="email" name="email" required placeholder="admin@insfp.dz">
                    </div>
                </div>

                <div class="form-group">
                    <label>Mot de passe</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" name="password" required placeholder="••••••••">
                    </div>
                </div>

                <button type="submit">Se connecter</button>

                <div class="info-text">
                    <i class="fa-solid fa-circle-info"></i> Accès réservé à l'institut
                </div>
            </form>
        </div>

        <!-- ETUDIANT -->
        <div class="card student-card">
            <div class="card-header">
                <div class="icon"><i class="fa-solid fa-user-graduate"></i></div>
                <h2>Étudiant</h2>
                <p>Consulter les offres</p>
            </div>

            <form method="POST" action="${pageContext.request.contextPath}/login">
                <div class="form-group">
                    <label>Email</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-envelope"></i>
                        <input type="email" name="email" required placeholder="etudiant@email.com">
                    </div>
                </div>

                <div class="form-group">
                    <label>Mot de passe</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" name="password" required placeholder="••••••••">
                    </div>
                </div>

                <button type="submit">Se connecter</button>

                <div class="info-text">
                    <i class="fa-solid fa-circle-info"></i> Accès réservé aux étudiants
                </div>
            </form>
        </div>

    </div>
</div>
</body>
</html>

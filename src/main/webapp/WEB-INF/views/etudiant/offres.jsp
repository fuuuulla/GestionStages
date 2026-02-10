<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Offres de Stage</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6fb;
        }

        /* ===== NAVBAR ===== */
        .navbar {
            background: linear-gradient(135deg, rgb(128, 128, 255), rgb(128, 128, 255));
            color: white;
            padding: 16px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        .navbar h1 {
            font-size: 22px;
            font-weight: 700;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 15px;
            padding: 8px 18px;
            border-radius: 20px;
            background: rgba(255,255,255,0.25);
            transition: 0.3s;
        }

        .navbar a:hover {
            background: rgba(255,255,255,0.4);
        }

        /* ===== CONTAINER ===== */
        .container {
            max-width: 1300px;
            margin: 35px auto;
            padding: 0 25px;
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 25px;
            color: #333;
        }

        /* ===== NOTIFICATIONS ===== */
        .notifications {
            margin-bottom: 35px;
        }

        .notification {
            padding: 18px 22px;
            border-radius: 14px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(15px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .notification-icon {
            font-size: 26px;
            margin-right: 18px;
        }

        .notification-title {
            font-weight: 700;
            margin-bottom: 6px;
        }

        .notification-acceptee {
            background: #e8f7ee;
            border-left: 5px solid #3cb371;
            color: #256d45;
        }

        .notification-refusee {
            background: #fdeaea;
            border-left: 5px solid #e55353;
            color: #8b2c2c;
        }

        .notification-en-attente {
            background: #f4f1ff;
            border-left: 5px solid #8b7cf6;
            color: rgb(255, 128, 0);
        }

        /* ===== MESSAGES ===== */
        .message {
            background: #e8f7ee;
            color: #256d45;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 20px;
            border-left: 4px solid #3cb371;
        }

        .error {
            background: #fdeaea;
            color: #8b2c2c;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 20px;
            border-left: 4px solid #e55353;
        }

        /* ===== GRID OFFRES ===== */
        .offres-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
        }

        .offre-card {
            background: white;
            padding: 28px;
            border-radius: 18px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.08);
            transition: 0.3s;
        }

        .offre-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 18px 40px rgba(0,0,0,0.12);
        }

        .offre-card h3 {
            color: rgb(128, 128, 192);
            margin-bottom: 15px;
            font-size: 22px;
        }

        .offre-info {
            margin: 8px 0;
            color: #555;
            line-height: 1.6;
            font-size: 14px;
        }

        .offre-info strong {
            color: #333;
        }

        .btn-postuler {
            margin-top: 18px;
            background: linear-gradient(135deg, rgb(128, 128, 255), rgb(128, 128, 255));
            color: white;
            padding: 10px 26px;
            border: none;
            border-radius: 22px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-postuler:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 20px rgb(128, 128, 255);
        }

        .btn-postuler:disabled {
            background: #ccc;
            cursor: not-allowed;
        }

        .no-offres {
            text-align: center;
            padding: 50px;
            background: white;
            border-radius: 16px;
            color: #777;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        }
    </style>
</head>

<body>

<div class="navbar">
    <h1>🎓 Espace Étudiant</h1>
    <div>
        <span>Bienvenue, ${sessionScope.user.prenom} ${sessionScope.user.nom}</span>
        <a href="${pageContext.request.contextPath}/logout">Déconnexion</a>
    </div>
</div>

<div class="container">

    <!-- NOTIFICATIONS -->
    <c:if test="${not empty mesCandidatures}">
        <div class="notifications">
            <h3 style="margin-bottom:15px;">📬 Mes Notifications</h3>

            <c:forEach items="${mesCandidatures}" var="cand">
                <c:choose>
                    <c:when test="${cand.statut == 'acceptee'}">
                        <div class="notification notification-acceptee">
                            <div class="notification-icon">✅</div>
                            <div>
                                <div class="notification-title">Candidature acceptée</div>
                                Votre candidature pour <b>${cand.titreOffre}</b> chez ${cand.entreprise} a été acceptée.
                            </div>
                        </div>
                    </c:when>

                    <c:when test="${cand.statut == 'refusee'}">
                        <div class="notification notification-refusee">
                            <div class="notification-icon">❌</div>
                            <div>
                                <div class="notification-title">Candidature refusée</div>
                                Votre candidature pour <b>${cand.titreOffre}</b> chez ${cand.entreprise} a été refusée.
                            </div>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="notification notification-en-attente">
                            <div class="notification-icon">⏳</div>
                            <div>
                                <div class="notification-title">En cours de traitement</div>
                                Votre candidature pour <b>${cand.titreOffre}</b> chez ${cand.entreprise} est en attente.
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </c:if>

    <h2 class="page-title">Offres de Stage Disponibles</h2>

    <c:if test="${not empty sessionScope.message}">
        <div class="message">${sessionScope.message}</div>
        <c:remove var="message" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.error}">
        <div class="error">${sessionScope.error}</div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <c:choose>
        <c:when test="${empty offres}">
            <div class="no-offres">
                <h3>Aucune offre disponible</h3>
                <p>Revenez plus tard 🌱</p>
            </div>
        </c:when>

        <c:otherwise>
            <div class="offres-grid">
                <c:forEach items="${offres}" var="offre">
                    <div class="offre-card">
                        <h3>${offre.titre}</h3>
                        <p class="offre-info"><strong>Entreprise :</strong> ${offre.entreprise}</p>
                        <p class="offre-info"><strong>Lieu :</strong> ${offre.lieu}</p>
                        <p class="offre-info"><strong>Durée :</strong> ${offre.duree}</p>
                        <p class="offre-info"><strong>Date début :</strong> ${offre.dateDebut}</p>
                        <p class="offre-info"><strong>Description :</strong> ${offre.description}</p>

                        <form action="${pageContext.request.contextPath}/etudiant/postuler" method="post">
                            <input type="hidden" name="offreId" value="${offre.id}">
                            <button type="submit" class="btn-postuler">📝 Postuler</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>
</body>
</html>

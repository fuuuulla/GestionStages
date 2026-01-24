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
            background: #f5f5f5;
        }
        
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .navbar h1 {
            font-size: 24px;
        }
        
        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            padding: 8px 15px;
            border-radius: 5px;
            background: rgba(255,255,255,0.2);
            transition: background 0.3s;
        }
        
        .navbar a:hover {
            background: rgba(255,255,255,0.3);
        }
        
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .page-title {
            color: #333;
            margin-bottom: 20px;
            font-size: 28px;
        }
        
        /* Notifications */
        .notifications {
            margin-bottom: 25px;
        }
        
        .notification {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            animation: slideIn 0.3s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        
        .notification-icon {
            font-size: 24px;
            margin-right: 15px;
        }
        
        .notification-content {
            flex: 1;
        }
        
        .notification-title {
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .notification-text {
            font-size: 14px;
        }
        
        .notification-acceptee {
            background: #d4edda;
            border-left: 4px solid #28a745;
            color: #155724;
        }
        
        .notification-refusee {
            background: #f8d7da;
            border-left: 4px solid #dc3545;
            color: #721c24;
        }
        
        .notification-en-attente {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            color: #856404;
        }
        
        .message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #28a745;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #dc3545;
        }
        
        .offre-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .offre-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }
        
        .offre-card h3 {
            color: #667eea;
            margin-bottom: 15px;
            font-size: 22px;
        }
        
        .offre-info {
            color: #666;
            margin: 8px 0;
            line-height: 1.6;
        }
        
        .offre-info strong {
            color: #333;
            display: inline-block;
            width: 120px;
        }
        
        .btn-postuler {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
            font-size: 15px;
            transition: transform 0.2s;
        }
        
        .btn-postuler:hover {
            transform: translateY(-2px);
        }
        
        .btn-postuler:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }
        
        .no-offres {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 10px;
            color: #666;
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
        <!-- NOTIFICATIONS DES CANDIDATURES -->
        <c:if test="${not empty mesCandidatures}">
            <div class="notifications">
                <h3 style="margin-bottom: 15px; color: #333;">📬 Mes Notifications</h3>
                
                <c:forEach items="${mesCandidatures}" var="cand">
                    <c:choose>
                        <c:when test="${cand.statut == 'acceptee'}">
                            <div class="notification notification-acceptee">
                                <div class="notification-icon">✅</div>
                                <div class="notification-content">
                                    <div class="notification-title">Félicitations ! Candidature acceptée</div>
                                    <div class="notification-text">
                                        Votre candidature pour "${cand.titreOffre}" chez ${cand.entreprise} a été acceptée !
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        
                        <c:when test="${cand.statut == 'refusee'}">
                            <div class="notification notification-refusee">
                                <div class="notification-icon">❌</div>
                                <div class="notification-content">
                                    <div class="notification-title">Candidature refusée</div>
                                    <div class="notification-text">
                                        Votre candidature pour "${cand.titreOffre}" chez ${cand.entreprise} n'a pas été retenue.
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        
                        <c:when test="${cand.statut == 'en_attente'}">
                            <div class="notification notification-en-attente">
                                <div class="notification-icon">⏳</div>
                                <div class="notification-content">
                                    <div class="notification-title">Candidature en cours d'examen</div>
                                    <div class="notification-text">
                                        Votre candidature pour "${cand.titreOffre}" chez ${cand.entreprise} est en cours d'examen.
                                    </div>
                                </div>
                            </div>
                        </c:when>
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
                    <h3>Aucune offre de stage disponible pour le moment</h3>
                    <p>Revenez plus tard pour découvrir de nouvelles opportunités !</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${offres}" var="offre">
                    <div class="offre-card">
                        <h3>${offre.titre}</h3>
                        <p class="offre-info"><strong>Entreprise :</strong> ${offre.entreprise}</p>
                        <p class="offre-info"><strong>Lieu :</strong> ${offre.lieu}</p>
                        <p class="offre-info"><strong>Durée :</strong> ${offre.duree}</p>
                        <p class="offre-info"><strong>Date de début :</strong> ${offre.dateDebut}</p>
                        <p class="offre-info"><strong>Description :</strong> ${offre.description}</p>
                        
                        <form action="${pageContext.request.contextPath}/etudiant/postuler" method="post" style="display: inline;">
                            <input type="hidden" name="offreId" value="${offre.id}">
                            <button type="submit" class="btn-postuler">📝 Postuler</button>
                        </form>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
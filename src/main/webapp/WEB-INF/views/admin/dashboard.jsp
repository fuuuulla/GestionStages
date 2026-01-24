<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin</title>
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
            padding: 8px 15px;
            border-radius: 5px;
            background: rgba(255,255,255,0.2);
            transition: background 0.3s;
        }
        
        .navbar a:hover {
            background: rgba(255,255,255,0.3);
        }
        
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .page-title {
            color: #333;
            margin-bottom: 20px;
            font-size: 28px;
        }
        
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .stat-card h3 {
            font-size: 32px;
            color: #667eea;
            margin-bottom: 10px;
        }
        
        .stat-card p {
            color: #666;
        }
        
        table {
            width: 100%;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            border-collapse: collapse;
        }
        
        thead {
            background: #667eea;
            color: white;
        }
        
        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }
        
        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        
        tr:hover {
            background: #f8f9fa;
        }
        
        .badge {
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }
        
        .badge-en_attente {
            background: #fff3cd;
            color: #856404;
        }
        
        .badge-acceptee {
            background: #d4edda;
            color: #155724;
        }
        
        .badge-refusee {
            background: #f8d7da;
            color: #721c24;
        }
        
        select {
            padding: 6px 12px;
            border-radius: 5px;
            border: 1px solid #ddd;
            margin-right: 8px;
        }
        
        .btn-update {
            padding: 6px 12px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
        }
        
        .btn-update:hover {
            background: #5568d3;
        }
        
        .no-candidatures {
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
        <h1>👨‍💼 Dashboard Administrateur</h1>
        <div>
            <span>Admin : ${sessionScope.user.prenom} ${sessionScope.user.nom}</span>
            <a href="${pageContext.request.contextPath}/logout">Déconnexion</a>
        </div>
    </div>
    
    <div class="container">
        <h2 class="page-title">Gestion des Candidatures</h2>
        
        <div class="stats">
            <div class="stat-card">
                <h3>${candidatures.size()}</h3>
                <p>Total Candidatures</p>
            </div>
            <div class="stat-card">
                <h3>
                    <c:set var="enAttente" value="0"/>
                    <c:forEach items="${candidatures}" var="c">
                        <c:if test="${c.statut == 'en_attente'}">
                            <c:set var="enAttente" value="${enAttente + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${enAttente}
                </h3>
                <p>En Attente</p>
            </div>
            <div class="stat-card">
                <h3>
                    <c:set var="acceptees" value="0"/>
                    <c:forEach items="${candidatures}" var="c">
                        <c:if test="${c.statut == 'acceptee'}">
                            <c:set var="acceptees" value="${acceptees + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${acceptees}
                </h3>
                <p>Acceptées</p>
            </div>
            <div class="stat-card">
                <h3>
                    <c:set var="refusees" value="0"/>
                    <c:forEach items="${candidatures}" var="c">
                        <c:if test="${c.statut == 'refusee'}">
                            <c:set var="refusees" value="${refusees + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${refusees}
                </h3>
                <p>Refusées</p>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${empty candidatures}">
                <div class="no-candidatures">
                    <h3>Aucune candidature pour le moment</h3>
                    <p>Les candidatures apparaîtront ici dès que les étudiants postuleront.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Étudiant</th>
                            <th>Offre</th>
                            <th>Entreprise</th>
                            <th>Date</th>
                            <th>Statut</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${candidatures}" var="cand">
                            <tr>
                                <td>${cand.prenomEtudiant} ${cand.nomEtudiant}</td>
                                <td>${cand.titreOffre}</td>
                                <td>${cand.entreprise}</td>
                                <td>${cand.dateCandidature}</td>
                                <td>
                                    <span class="badge badge-${cand.statut}">
                                        <c:choose>
                                            <c:when test="${cand.statut == 'en_attente'}">En attente</c:when>
                                            <c:when test="${cand.statut == 'acceptee'}">Acceptée</c:when>
                                            <c:when test="${cand.statut == 'refusee'}">Refusée</c:when>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/update-statut" method="post" style="display: inline;">
                                        <input type="hidden" name="candidatureId" value="${cand.id}">
                                        <select name="statut">
                                            <option value="en_attente" ${cand.statut == 'en_attente' ? 'selected' : ''}>En attente</option>
                                            <option value="acceptee" ${cand.statut == 'acceptee' ? 'selected' : ''}>Acceptée</option>
                                            <option value="refusee" ${cand.statut == 'refusee' ? 'selected' : ''}>Refusée</option>
                                        </select>
                                        <button type="submit" class="btn-update">✓ Mettre à jour</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
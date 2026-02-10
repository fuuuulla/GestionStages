<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard INSFP</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Inter','Segoe UI',sans-serif;
    background: #f1f3f6;
    color: #333;
}

/* ===== NAVBAR ===== */
.navbar {
    background: linear-gradient(135deg, #2F3C7E, #1E2761);
    color: white;
    padding: 16px 32px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 6px 20px rgba(0,0,0,0.12);
}

.navbar h1 {
    font-size: 22px;
    font-weight: 700;
}

.navbar span {
    margin-right: 15px;
}

.navbar a {
    color: white;
    text-decoration: none;
    padding: 8px 16px;
    border-radius: 20px;
    background: rgba(255,255,255,0.25);
    transition: 0.3s;
}

.navbar a:hover {
    background: rgba(255,255,255,0.4);
}

/* ===== CONTAINER ===== */
.container {
    max-width: 1400px;
    margin: 40px auto;
    padding: 0 25px;
}

.page-title {
    font-size: 30px;
    font-weight: 700;
    margin-bottom: 25px;
}

/* ===== STATS ===== */
.stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 25px;
    margin-bottom: 30px;
}

.stat-card {
    background: white;
    padding: 25px;
    border-radius: 16px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    text-align: center;
}

.stat-card h3 {
    font-size: 36px;
    color: #F96167;
}

.stat-card p {
    font-size: 14px;
    color: #777;
}

/* ===== FILTER ===== */
.filter-bar {
    display: flex;
    gap: 15px;
    margin-bottom: 20px;
}

.filter-bar input,
.filter-bar select {
    padding: 10px 15px;
    border-radius: 12px;
    border: 1px solid #ddd;
    font-size: 14px;
}

/* ===== TABLE ===== */
table {
    width: 100%;
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    border-collapse: collapse;
}

thead {
    background: linear-gradient(135deg, #2F3C7E, #1E2761);
    color: white;
}

th {
    padding: 18px;
    font-size: 14px;
    text-transform: uppercase;
}

td {
    padding: 16px;
    border-bottom: 1px solid #eee;
    font-size: 14px;
}

tbody tr:hover {
    background: #f9fafc;
}

/* ===== BADGES ===== */
.badge {
    padding: 6px 16px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
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

/* ===== EMPTY ===== */
.no-candidatures {
    text-align: center;
    padding: 60px;
    background: white;
    border-radius: 16px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
}
</style>
</head>

<body>

<div class="navbar">
    <h1>📚 Dashboard INSFP Rahmania</h1>
    <div>
        <span>INSFP : ${sessionScope.user.prenom} ${sessionScope.user.nom}</span>
        <a href="${pageContext.request.contextPath}/logout">Déconnexion</a>
    </div>
</div>

<div class="container">
    <h2 class="page-title">Consultation des Candidatures</h2>

    <!-- ===== STATS ===== -->
    <div class="stats">
        <div class="stat-card">
            <h3>${candidatures.size()}</h3>
            <p>Total Candidatures</p>
        </div>

        <div class="stat-card">
            <h3>
                <c:set var="att" value="0"/>
                <c:forEach items="${candidatures}" var="c">
                    <c:if test="${c.statut == 'en_attente'}">
                        <c:set var="att" value="${att + 1}"/>
                    </c:if>
                </c:forEach>
                ${att}
            </h3>
            <p>En attente</p>
        </div>

        <div class="stat-card">
            <h3>
                <c:set var="acc" value="0"/>
                <c:forEach items="${candidatures}" var="c">
                    <c:if test="${c.statut == 'acceptee'}">
                        <c:set var="acc" value="${acc + 1}"/>
                    </c:if>
                </c:forEach>
                ${acc}
            </h3>
            <p>Acceptées</p>
        </div>

        <div class="stat-card">
            <h3>
                <c:set var="ref" value="0"/>
                <c:forEach items="${candidatures}" var="c">
                    <c:if test="${c.statut == 'refusee'}">
                        <c:set var="ref" value="${ref + 1}"/>
                    </c:if>
                </c:forEach>
                ${ref}
            </h3>
            <p>Refusées</p>
        </div>
    </div>

    <!-- ===== FILTER ===== -->
    <div class="filter-bar">
        <input type="text" id="searchInput" placeholder="🔍 Rechercher...">
        <select id="filterStatus">
            <option value="">Tous les statuts</option>
            <option value="en_attente">En attente</option>
            <option value="acceptee">Acceptée</option>
            <option value="refusee">Refusée</option>
        </select>
    </div>

    <!-- ===== TABLE ===== -->
    <c:choose>
        <c:when test="${empty candidatures}">
            <div class="no-candidatures">
                <h3>Aucune candidature</h3>
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
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${candidatures}" var="cand">
                    <tr>
                        <td>${cand.prenomEtudiant} ${cand.nomEtudiant}</td>
                        <td>${cand.titreOffre}</td>
                        <td>${cand.entreprise}</td>
                        <td>
                            <fmt:formatDate value="${cand.dateCandidature}" pattern="dd/MM/yyyy HH:mm"/>
                        </td>
                        <td>
                            <span class="badge badge-${cand.statut}">
                                <c:choose>
                                    <c:when test="${cand.statut == 'en_attente'}">En attente</c:when>
                                    <c:when test="${cand.statut == 'acceptee'}">Acceptée</c:when>
                                    <c:otherwise>Refusée</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<!-- ===== JS FILTER ===== -->
<script>
const searchInput = document.getElementById("searchInput");
const filterStatus = document.getElementById("filterStatus");
const rows = document.querySelectorAll("tbody tr");

function filterTable(){
    const search = searchInput.value.toLowerCase();
    const status = filterStatus.value;

    rows.forEach(row=>{
        const text = row.innerText.toLowerCase();
        const badge = row.querySelector(".badge").className;
        const okSearch = text.includes(search);
        const okStatus = status === "" || badge.includes(status);
        row.style.display = okSearch && okStatus ? "" : "none";
    });
}

searchInput.addEventListener("keyup", filterTable);
filterStatus.addEventListener("change", filterTable);
</script>

</body>
</html>

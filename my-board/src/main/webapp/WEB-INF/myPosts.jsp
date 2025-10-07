<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html>
<head>
    <title>내가 쓴 글 목록</title>
    <style>
        .top-menu {
            background-color: #f0f0f0;
            padding: 10px;
            margin-bottom: 20px;
        }
        .top-menu a, .top-menu button {
            margin-right: 15px;
            text-decoration: none;
            font-weight: bold;
            color: #333;
        }
        .top-menu button {
            background-color: #fff;
            border: 1px solid #ccc;
            cursor: pointer;
            padding: 5px 10px;
        }
    </style>
</head>
<body>

<div class="top-bar">
    <c:if test="${not empty sessionScope.loginMember}">
        <form action="/posts/new" method="get">
            <button type="submit">글쓰기</button>
        </form>
        <form action="/logout" method="post">
            <button type="submit">로그아웃</button>
        </form>
    </c:if>
</div>

<h2>내가 쓴 글 목록</h2>

<jsp:useBean id="now" class="java.util.Date" scope="page" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayStr" />

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성일</th>
        <th>조회수</th>
    </tr>

    <c:forEach var="post" items="${posts}">
        <fmt:formatDate value="${post.createdAtDate}" pattern="yyyy-MM-dd" var="postDateStr"/>
        <tr>
            <td>${post.id}</td>
            <td><a href="/posts/${post.id}">${post.title}${post.comments}</a></td>
            <td>
                <c:choose>
                    <c:when test="${postDateStr eq todayStr}">
                        <fmt:formatDate value="${post.createdAtDate}" pattern="HH:mm" timeZone="Asia/Seoul"/>
                    </c:when>
                    <c:otherwise>
                        ${postDateStr}
                    </c:otherwise>
                </c:choose>
            </td>
            <td>${post.views}</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>

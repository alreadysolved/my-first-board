<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
  <meta charset="UTF-8">
  <title>전체 글 목록</title>

  <style>
    body {
      font-family: "Pretendard", sans-serif;
      margin: 30px auto;
      max-width: 900px;
      line-height: 1.6;
      color: #333;
    }

    .top-menu {
      text-align: right;
      margin-bottom: 20px;
    }

    .top-menu a, .top-menu button {
      margin-left: 8px;
      text-decoration: none;
      font-weight: bold;
      color: #333;
    }

    .top-menu button {
      padding: 6px 12px;
      border: none;
      border-radius: 5px;
      background-color: #007bff;
      color: white;
      cursor: pointer;
      font-size: 14px;
    }

    .top-menu button:hover {
      background-color: #0056b3;
    }

    h2 {
      text-align: center;
      margin-bottom: 25px;
      font-size: 22px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: #fafafa;
      border-radius: 10px;
      overflow: hidden;
    }

    th {
      background-color: #f0f0f0;
      padding: 10px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }

    td {
      padding: 10px;
      border-bottom: 1px solid #eee;
    }

    tr:hover {
      background-color: #f9f9f9;
    }

    a {
      color: #007bff;
      text-decoration: none;
    }

    a:hover {
      text-decoration: underline;
    }

    .empty {
      text-align: center;
      padding: 30px;
      color: #777;
      font-size: 15px;
    }
  </style>
</head>
<body>

<!-- 상단 메뉴 -->
<div class="top-menu">
  <c:choose>
    <c:when test="${not empty sessionScope.loginMember}">
      <a href="/posts/new">글쓰기</a>
      <a href="/posts/mine">내가 쓴 글</a>
      <a href="/logout">로그아웃</a>
    </c:when>
    <c:otherwise>
      <a href="/login">로그인</a>
      <a href="/join">회원가입</a>
    </c:otherwise>
  </c:choose>
</div>

<h2>전체 글 목록</h2>

<jsp:useBean id="now" class="java.util.Date" scope="page" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayStr" />

<table>
  <tr>
    <th>번호</th>
    <th>제목</th>
    <th>작성자</th>
    <th>작성일</th>
    <th>조회수</th>
  </tr>

  <c:choose>
    <c:when test="${empty posts}">
      <tr>
        <td colspan="5" class="empty">작성된 글이 없습니다.</td>
      </tr>
    </c:when>

    <c:otherwise>
      <c:forEach var="post" items="${posts}">
        <fmt:formatDate value="${post.createdAtDate}" pattern="yyyy-MM-dd" var="postDateStr"/>
        <tr>
          <td>${post.id}</td>
          <td>
            <a href="/posts/${post.id}">
                ${post.title}
              <c:if test="${not empty post.comments}">
                <span style="color:#777;">(${post.comments})</span>
              </c:if>
            </a>
          </td>
          <td>${post.authorNickname}</td>
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
    </c:otherwise>
  </c:choose>
</table>

</body>
</html>

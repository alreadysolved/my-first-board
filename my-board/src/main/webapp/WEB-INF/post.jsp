<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
  <meta charset="UTF-8">
  <title>글 상세보기</title>
</head>
<body>

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

<h2>글 상세보기</h2>

<table border="1" cellpadding="5" cellspacing="0">
  <tr>
    <th>제목</th>
    <td>${post.title}</td>
  </tr>
  <tr>
    <th>작성자</th>
    <td>${post.authorNickname}</td>
  </tr>
  <tr>
    <th>작성일</th>
    <td>
      <fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd HH:mm" timeZone="Asia/Seoul"/>
    </td>
  </tr>
  <tr>
    <th>조회수</th>
    <td>${post.views}</td>
  </tr>
  <tr>
    <th>내용</th>
    <td>${post.content}</td>
  </tr>
</table>

<br/>
<c:if test="${sessionScope.loginMember != null and sessionScope.loginMember.id == post.authorId}">
  <form action="/posts/${post.id}/edit" method="get" style="display:inline;">
    <button type="submit">수정</button>
  </form>

  <form action="/posts/${post.id}" method="post" style="display:inline;"
        onsubmit="return confirm('정말 삭제하시겠습니까?');">
    <input type="hidden" name="_method" value="delete"/>
    <button type="submit">삭제</button>
  </form>
</c:if>

<br/>
<form:form method="post" modelAttribute="commentForm" action="/posts/${post.id}/comments">

  <label for="content"></label>
  <form:textarea path="content" id="content" rows="10"/>
  <form:errors path="content" cssClass="error"/>

  <button type="submit">작성하기</button>

</form:form>

<table border="1">
  <c:if test="${!empty comments}">
    <c:forEach var="comment" items="${comments}">
      <tr>
        ${comment.authorNickname} | <fmt:formatDate value="${comment.createdAtDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
      </tr>
      <br/>
      <tr>
        ${comment.content}
      </tr>
    </c:forEach>
  </c:if>
</table>

<a href="/posts">목록으로</a>
</body>
</html>

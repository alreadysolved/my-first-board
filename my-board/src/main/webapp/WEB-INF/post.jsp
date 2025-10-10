<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
  <meta charset="UTF-8">
  <title>글 상세보기</title>

  <style>
    body {
      font-family: "Pretendard", sans-serif;
      margin: 30px auto;
      max-width: 800px;
      line-height: 1.6;
      color: #333;
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
    }

    table.post-detail {
      width: 100%;
      border-collapse: collapse;
      background: #fafafa;
      border: 1px solid #ccc;
      border-radius: 10px;
      overflow: hidden;
    }

    table.post-detail th {
      width: 100px;
      background: #f0f0f0;
      text-align: left;
      padding: 10px;
    }

    table.post-detail td {
      padding: 10px;
    }

    .top-menu {
      text-align: right;
      margin-bottom: 15px;
    }

    .top-menu a {
      text-decoration: none;
      color: #007bff;
      margin-left: 10px;
    }

    .top-menu a:hover {
      text-decoration: underline;
    }

    .comment-box {
      margin-top: 30px;
    }

    .comment-box textarea {
      width: 100%;
      height: 80px;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      resize: vertical;
    }

    .comment-box button {
      margin-top: 8px;
      padding: 6px 12px;
      border: none;
      background-color: #007bff;
      color: white;
      border-radius: 5px;
      cursor: pointer;
    }

    .comment-box button:hover {
      background-color: #0056b3;
    }

    /* 댓글 목록 */
    .comment-list {
      margin-top: 25px;
    }

    .comment {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 12px 16px;
      margin-bottom: 12px;
      background-color: #fafafa;
    }

    .comment-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 14px;
      color: #666;
      margin-bottom: 6px;
    }

    .comment-content {
      font-size: 15px;
      color: #333;
      white-space: pre-line;
      margin-bottom: 6px;
    }

    .comment-actions button {
      background: none;
      border: none;
      color: #007bff;
      cursor: pointer;
      font-size: 13px;
      margin-left: 5px;
    }

    .comment-actions button:hover {
      text-decoration: underline;
    }

    .edit-form {
      display: none;
      margin-top: 6px;
    }

    .edit-form textarea {
      width: 100%;
      height: 70px;
      padding: 8px;
      border-radius: 5px;
      border: 1px solid #ccc;
    }

    .edit-form .btns {
      margin-top: 5px;
    }

    .edit-form button {
      padding: 5px 10px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .save-btn {
      background-color: #007bff;
      color: white;
    }

    .cancel-btn {
      background-color: #ddd;
      margin-left: 5px;
    }

    .post-buttons {
      margin-top: 10px;
    }

    .post-buttons form {
      display: inline;
    }

    .post-buttons button {
      background-color: #eee;
      border: 1px solid #ccc;
      padding: 6px 10px;
      border-radius: 5px;
      cursor: pointer;
    }

    .post-buttons button:hover {
      background-color: #ddd;
    }

    a.back-link {
      display: inline-block;
      margin-top: 20px;
      text-decoration: none;
      color: #007bff;
    }

    a.back-link:hover {
      text-decoration: underline;
    }
  </style>
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

<table class="post-detail">
  <tr><th>제목</th><td>${post.title}</td></tr>
  <tr><th>작성자</th><td>${post.authorNickname}</td></tr>
  <tr><th>작성일</th>
    <td><fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd HH:mm" timeZone="Asia/Seoul"/></td></tr>
  <tr><th>조회수</th><td>${post.views}</td></tr>
  <tr><th>내용</th><td>${post.content}</td></tr>
</table>

<c:if test="${sessionScope.loginMember != null and sessionScope.loginMember.id == post.authorId}">
  <div class="post-buttons">
    <form action="/posts/${post.id}/edit" method="get">
      <button type="submit">수정</button>
    </form>
    <form action="/posts/${post.id}" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
      <input type="hidden" name="_method" value="delete"/>
      <button type="submit">삭제</button>
    </form>
  </div>
</c:if>

<!-- 댓글 작성 -->
<div class="comment-box">
  <form:form method="post" modelAttribute="commentForm" action="/posts/${post.id}/comments">
    <form:textarea path="content" id="content"/>
    <form:errors path="content" cssClass="error"/>
    <button type="submit">댓글 작성</button>
  </form:form>
</div>

<!-- 댓글 목록 -->
<div class="comment-list">
  <c:forEach var="comment" items="${commentsList}">
    <div class="comment" id="comment-${comment.id}">
      <div class="comment-header">
        <span><strong>${comment.authorNickname}</strong> |
              <fmt:formatDate value="${comment.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>

        <c:if test="${sessionScope.loginMember != null and sessionScope.loginMember.id == comment.authorId}">
          <span class="comment-actions">
            <button type="button" onclick="showEditForm(${comment.id})">수정</button>
            <form action="/posts/${post.id}/comments/${comment.id}" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
              <input type="hidden" name="_method" value="delete"/>
              <button type="submit">삭제</button>
            </form>
          </span>
        </c:if>
      </div>

      <div class="comment-content" id="view-${comment.id}">
          ${comment.content}
      </div>

      <!-- 수정 폼 -->
      <form class="edit-form" id="edit-${comment.id}" action="/posts/${post.id}/comments/${comment.id}" method="post">
        <input type="hidden" name="_method" value="patch"/>
        <textarea name="content">${comment.content}</textarea>
        <div class="btns">
          <button type="submit" class="save-btn">저장</button>
          <button type="button" class="cancel-btn" onclick="cancelEdit(${comment.id})">취소</button>
        </div>
      </form>
    </div>
  </c:forEach>
</div>

<a href="/posts" class="back-link">← 목록으로</a>

<script>
  function showEditForm(id) {
    document.getElementById('view-' + id).style.display = 'none';
    document.getElementById('edit-' + id).style.display = 'block';
  }

  function cancelEdit(id) {
    document.getElementById('edit-' + id).style.display = 'none';
    document.getElementById('view-' + id).style.display = 'block';
  }
</script>

</body>
</html>

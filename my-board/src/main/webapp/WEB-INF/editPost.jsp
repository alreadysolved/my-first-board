<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>글 수정</title>
    <style>
        .top-menu {
            background-color: #f0f0f0;
            padding: 10px;
            margin-bottom: 20px;
        }
        .top-menu a {
            margin-right: 15px;
            text-decoration: none;
            font-weight: bold;
            color: #333;
        }
        .form-container {
            width: 500px;
            margin: auto;
        }
        .form-container label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        .form-container input[type="text"], .form-container textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-container button {
            margin-top: 15px;
            padding: 8px 15px;
            font-weight: bold;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        .form-container button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            font-size: 0.9em;
        }
    </style>
</head>
<body>

<div class="top-menu">
    <a href="/posts/new">글쓰기</a>
    <a href="/posts/mine">내가 쓴 글</a>
    <a href="/logout">로그아웃</a>
</div>

<div class="form-container">
    <h2>글 수정</h2>

    <!-- PostForm을 모델 속성으로 사용 -->
    <form:form method="post" modelAttribute="editForm" action="/posts/${editForm.id}">
        <input type="hidden" name="_method" value="patch"/>

        <label for="title">제목</label>
        <form:input path="title" id="title"/>
        <form:errors path="title" cssClass="error"/>

        <label for="content">내용</label>
        <form:textarea path="content" id="content" rows="10"/>
        <form:errors path="content" cssClass="error"/>

        <button type="submit">수정하기</button>
    </form:form>
</div>

</body>
</html>

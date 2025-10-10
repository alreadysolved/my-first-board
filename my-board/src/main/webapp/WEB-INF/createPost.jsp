<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>글 작성</title>
    <style>
        body {
            font-family: "Pretendard", sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            color: #333;
        }

        .wrapper {
            max-width: 600px;
            margin: 40px auto 0 auto;
            padding: 0 20px;
        }

        .top-menu {
            text-align: right;
            margin-bottom: 20px;
        }

        .top-menu a {
            margin-left: 8px;
            text-decoration: none;
            font-weight: bold;
            color: #333;
        }

        .container {
            background-color: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            width: 100%;
            box-sizing: border-box;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 24px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            font-size: 14px;
        }

        input, textarea {
            width: 100%;
            padding: 8px 10px;
            margin-bottom: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .error {
            color: #d9534f;
            font-size: 13px;
            margin-top: -8px;
            margin-bottom: 10px;
            display: block;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 15px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="top-menu">
        <a href="/posts/new">글쓰기</a>
        <a href="/posts/mine">내가 쓴 글</a>
        <a href="/logout">로그아웃</a>
    </div>

    <div class="container">
        <h2>글 작성</h2>

        <form:form method="post" modelAttribute="postForm" action="/posts">
            <label for="title">제목</label>
            <form:input path="title" id="title"/>
            <form:errors path="title" cssClass="error"/>

            <label for="content">내용</label>
            <form:textarea path="content" id="content" rows="10"/>
            <form:errors path="content" cssClass="error"/>

            <button type="submit">작성하기</button>
        </form:form>
    </div>
</div>
</body>
</html>

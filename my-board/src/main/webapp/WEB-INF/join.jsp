<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>

  <style>
    body {
      font-family: "Pretendard", sans-serif;
      background-color: #f5f5f5;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      color: #333;
    }

    .container {
      background-color: white;
      padding: 30px 40px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      width: 100%;
      max-width: 400px;
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

    input, textarea, select {
      width: 100%;
      padding: 8px 10px;
      margin-bottom: 12px;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-sizing: border-box;
      font-size: 14px;
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

    p {
      text-align: center;
      margin-top: 15px;
      font-size: 14px;
    }

    p a {
      color: #007bff;
      text-decoration: none;
    }

    p a:hover {
      text-decoration: underline;
    }
  </style>
</head>

<body>
<div class="container">
  <h2>회원가입</h2>

  <form:form modelAttribute="joinForm" method="post">
    <label for="email">이메일</label>
    <form:input path="email" id="email"/>
    <form:errors path="email" cssClass="error"/>

    <label for="nickname">닉네임 (2~8자)</label>
    <form:input path="nickname" id="nickname"/>
    <form:errors path="nickname" cssClass="error"/>

    <label for="password">비밀번호</label>
    <form:password path="password" id="password"/>
    <form:errors path="password" cssClass="error"/>

    <label for="confirmPassword">비밀번호 확인</label>
    <form:password path="confirmPassword" id="confirmPassword"/>
    <form:errors path="confirmPassword" cssClass="error"/>

    <button type="submit">회원가입</button>
  </form:form>

  <p>
    이미 계정이 있으신가요? <a href="login">로그인</a>
  </p>
</div>
</body>
</html>

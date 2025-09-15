<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <style>
    body { font-family: Arial; background-color: #f5f5f5; }
    .container { max-width: 400px; margin: 50px auto; padding: 20px; background: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    label { display: block; margin-top: 10px; }
    input { width: 100%; padding: 8px; margin-top: 4px; border-radius: 4px; border: 1px solid #ccc; }
    .error { color: red; font-size: 0.9em; margin-top: 4px; }
    button { width: 100%; margin-top: 20px; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; }
    button:hover { background-color: #0056b3; }
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
</div>
</body>
</html>

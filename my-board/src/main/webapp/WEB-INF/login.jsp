<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container">
    <h2>로그인</h2>


    <form:form modelAttribute="loginForm" method="post" action="login">
        <label for="email">이메일</label>
        <form:input path="email" id="email"/>
        <form:errors path="email" cssClass="error"/>

        <label for="password">비밀번호</label>
        <form:password path="password" id="password"/>
        <form:errors path="password" cssClass="error"/>

        <button type="submit">로그인</button>
    </form:form>

    <p style="margin-top: 15px; text-align: center;">
        <a href="join">회원가입</a>
    </p>
</div>

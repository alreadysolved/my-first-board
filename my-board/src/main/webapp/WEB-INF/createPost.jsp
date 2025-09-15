<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>글 작성</title>
</head>
<body>
<h2>글 작성</h2>
<form action="${pageContext.request.contextPath}/posts" method="post">
    <table>
        <tr>
            <td>
                <label for="title">제목</label>
            </td>
            <td>
                <input type="text" id="title" name="title" required>
            </td>
        </tr>
        <tr>
            <td>
                <label for="content">내용</label>
            </td>
            <td>
                <textarea id="content" name="content" rows="10" cols="50" required></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <button type="submit">작성</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>

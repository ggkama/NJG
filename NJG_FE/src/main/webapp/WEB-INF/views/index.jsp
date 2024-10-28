<%--
  Created by IntelliJ IDEA.
  User: Playdata
  Date: 2024-02-05
  Time: 오전 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:if test="${userId eq null}">
    <a href="https://kauth.kakao.com/oauth/authorize?client_id=11e34e2fea3c23a1b6d1d5da3d7237fb&redirect_uri=http://localhost:8089/kakao&response_type=code">
        <img src="/img/kakao_account_login_btn_medium_wide_ov.png">
    </a>
</c:if>
<c:if test="${userId ne null}">
    <h1>로그인 성공입니다</h1>
    <input type="button" value="로그아웃" onclick="location.href='/kakaologout'">
</c:if>
</body>


</html>

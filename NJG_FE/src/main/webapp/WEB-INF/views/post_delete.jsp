<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // JDBC 드라이버 로드
    Class.forName("org.mariadb.jdbc.Driver");

    // 데이터베이스 연결 설정
    Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/recipe", "root", "1234");
    int postId = Integer.parseInt(request.getParameter("postId"));
    Statement statement = conn.createStatement();

    statement.executeQuery("DELETE FROM post_list WHERE idx = " + postId);
    response.sendRedirect("board_list.jsp");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/css.css">
</head>

<body>
<p>delete done?</p>
</body>
</html>

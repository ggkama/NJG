<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
    // JDBC 드라이버 로드
    Class.forName("org.mariadb.jdbc.Driver");

    // 데이터베이스 연결 설정
    Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/recipe", "root", "1234");
    int postId = Integer.parseInt(request.getParameter("postId"));
    Statement statement = conn.createStatement();

    ResultSet resultSet = statement.executeQuery("SELECT title, content, user_id, created_at, board_type FROM post_list WHERE idx = " + postId);
    while(resultSet.next()) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>냉잔고</title>
    <link href="./css/common.css" rel="stylesheet" type="text/css" />
    <link href="./css/board.css" rel="stylesheet" type="text/css" />

    <!-- fonts -->
    <script src="https://kit.fontawesome.com/aa3cf60179.js" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<section id="board">
    <article id="board_detail" class="board_wrap">
        <% if(resultSet.getString("board_type").equals("notice")) { %>
        <div class="board_tit">
            <strong>공지사항</strong>
        </div>
        <% } %>
        <% if(resultSet.getString("board_type").equals("free")) { %>
        <div class="board_tit">
            <strong>자유게시판</strong>
        </div>
        <% } %>
        <% if(resultSet.getString("board_type").equals("recipe")) { %>
        <div class="board_tit">
            <strong>레시피공유게시판</strong>
        </div>
        <% } %>
        <% if(resultSet.getString("board_type").equals("inquiry")) { %>
        <div class="board_tit">
            <strong>문의게시판</strong>
        </div>
        <% } %>
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="tit">
                    <dl>
                        <dt>제목</dt>
                        <dd><%= resultSet.getString("title") %></dd>
                    </dl>
                    <dl>
                        <dt>작성자</dt>
                        <dd><%= resultSet.getString("user_id") %></dd>
                    </dl>
                    <dl>
                        <dt>작성일</dt>
                        <dd><%= resultSet.getString("created_at") %></dd>
                    </dl>
                </div>
                <div class="cont">
                    <%= resultSet.getString("content") %>
                </div>
            </div>
            <div class="bt_wrap">
                <a href="/board_list" class="btn on">목록</a>
                <a href="edit.html" class="btn">수정</a>
                <a href="#" class="btn">삭제</a>
            </div>
        </div>
    </article>
</section>
<% } %>
<%
    resultSet.close();
    statement.close();
    conn.close();
%>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

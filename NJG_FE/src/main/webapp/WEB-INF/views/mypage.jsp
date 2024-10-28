<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.springboot.project4.data.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // JDBC 드라이버 로드
    Class.forName("org.mariadb.jdbc.Driver");

    // 데이터베이스 연결 설정
    Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/recipe", "root", "1234");
    Statement statement = conn.createStatement();
    ResultSet resultSet = statement.executeQuery("SELECT idx, title, created_at, image, board_type FROM post_list WHERE user_id = '" + ((User) session.getAttribute("loggedInUser")).getUserId() + "' ORDER BY idx DESC");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>냉잔고</title>
    <link href="./css/common.css" rel="stylesheet" type="text/css" />
    <link href="./css/mypage.css" rel="stylesheet" type="text/css" />

    <!-- fonts -->
    <script src="https://kit.fontawesome.com/aa3cf60179.js" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<!-- Main -->
<section id="mypage">
    <article>
        <div class="container">
            <div class="pageTop">
                <div class="info">
                    <div class="userImg">
                        <img src="" alt="등급이미지" />
                    </div>
                    <div class="userTxt">
                        <span class="userGrp">회원이름</span>
                        <span class="userName"><%= ((User) session.getAttribute("loggedInUser")).getUserId() %></span>
                        <a href="#" class="infoEdit">정보수정</a>
                    </div>
                </div>
            </div>
            <div class="pageBtm">
                <div class="mypage_title">
                    <strong>게시글 작성 내역</strong>
                    <p>작성했던 게시글들을 한곳에서 확인해보세요.</p>
                </div>
                <div class="mypage_list_wrap">
                    <table class="mypage_list">
                        <colgroup>
                            <col width="5%" />
                            <col width="20%" />
                            <col width="*" />
                            <col width="20%" />
                        </colgroup>
                        <thead>
                        <tr>
                            <td>번호</td>
                            <td>카테고리</td>
                            <td>제목</td>
                            <td>작성일</td>
                        </tr>
                        </thead>
                        <tbody>
                            <% while(resultSet.next()) { %>
                            <tr class="list">
                                <td class="num">
                                    <%= resultSet.getInt("idx") %>
                                </td>
                                <td class="cate">
                                    <% if(resultSet.getString("board_type").equals("notice")) { %>
                                    공지사항
                                    <% } %>
                                    <% if(resultSet.getString("board_type").equals("free")) { %>
                                    자유게시판
                                    <% } %>
                                    <% if(resultSet.getString("board_type").equals("recipe")) { %>
                                    레시피공유게시판
                                    <% } %>
                                    <% if(resultSet.getString("board_type").equals("inquiry")) { %>
                                    문의게시판
                                    <% } %>
                                </td>
                                <td class="tit">
                                    <a href="/post_detail?postId=<%= resultSet.getInt("idx") %>"><%= resultSet.getString("title") %></a>
                                </td>
                                <td class="date">
                                    <span><%= resultSet.getDate("created_at") %></span>
                                </td>
                            </tr>
                            <% } %>
                            <%
                                resultSet.close();
                                statement.close();
                                conn.close();
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </article>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
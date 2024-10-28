<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // JDBC 드라이버 로드
    Class.forName("org.mariadb.jdbc.Driver");

    // 데이터베이스 연결 설정
    Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/recipe", "root", "1234");

    // 게시판 종류에 따른 쿼리 및 타이틀 매핑
    HashMap<String, String> boardQueries = new HashMap<>();
    boardQueries.put("notice", "SELECT idx, title, content, user_id, created_at FROM post_list WHERE board_type='notice' ORDER BY idx DESC");
    boardQueries.put("inquiry", "SELECT idx, title, content, user_id, created_at FROM post_list WHERE board_type='inquiry' ORDER BY idx DESC");
    boardQueries.put("free", "SELECT idx, title, content, user_id, created_at FROM post_list WHERE board_type='free' ORDER BY idx DESC");
    boardQueries.put("recipe", "SELECT idx, title, content, user_id, created_at FROM post_list WHERE board_type='recipe' ORDER BY idx DESC");

    // 현재 게시판 종류를 파라미터로 받기 (예: boardType=food_question)
    String boardType = request.getParameter("boardType");

    // 유효한 boardType이 아니거나 null일 경우 기본값으로 notice를 사용
    if (boardType == null || !boardQueries.containsKey(boardType)) {
        boardType = "notice";
    }

    String query = boardQueries.get(boardType);

    Statement statement = conn.createStatement();
    ResultSet resultSet = statement.executeQuery(query);

    int num = 1;
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
    <article class="boardLt">
        <jsp:include page="board_left.jsp"></jsp:include>
    </article>
    <article class="boardRt">
        <% if(boardType.equals("notice")) { %>
        <div class="board_title">
            <strong>공지사항</strong>
            <p>냉잔고의 새로운 소식들과 유용한 정보들을 한곳에서 확인해보세요.</p>
        </div>
        <% } %>
        <% if(boardType.equals("inquiry")) { %>
        <div class="board_title">
            <strong>문의게시판</strong>
            <p>냉잔고의 문의하고 싶은점을 남겨주세요.</p>
        </div>
        <% } %>
        <% if(boardType.equals("free")) { %>
        <div class="board_title">
            <strong>자유게시판</strong>
            <p>냉잔고의 자유게시판.</p>
        </div>
        <% } %>
        <% if(boardType.equals("recipe")) { %>
        <div class="board_title">
            <strong>레시피공유게시판</strong>
            <p>냉잔고 이용자들의 레시피를 공유해보세요.</p>
        </div>
        <% } %>
        <div class="board_list_wrap">
            <table class="board_list">
                <colgroup>
                    <col width="5%" />
                    <col width="*" />
                    <col width="10%" />
                    <col width="20%" />
                </colgroup>
                <thead>
                <tr>
                    <td>번호</td>
                    <td>제목</td>
                    <td>작성자</td>
                    <td>작성일</td>
                </tr>
                </thead>
                <tbody>
                <% while(resultSet.next()) { %>
                <tr class="list">
                    <td class="num">
                        <%= num %>
                        <% num += 1; %>
                    </td>
                    <td class="tit">
                        <a href="post_detail?postId=<%= resultSet.getInt("idx") %>">
                            <%= resultSet.getString("title") %>
                        </a>
                    </td>
                    <td class="writer">
                        <%= resultSet.getString("user_id") %>
                    </td>
                    <td class="date">
                        <span><%= resultSet.getString("created_at") %></span>
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
            <% if (session.getAttribute("loggedInUser") != null) { %>
            <div class="bt_wrap">
                <a href="/board_write" class="on">등록</a>
            </div>
            <% } else { %>
            <div class="bt_wrap">
                <a href="#" class="on">로그인을 해주세요</a>
            </div>
            <% } %>
        </div>
        <script>
            var selectBox = document.querySelector('.boardLt .tit');

            selectBox.addEventListener('click', function() {
                var parentEl = document.querySelector('.boardLt')
                if (parentEl.classList.contains('on')) {
                    parentEl.classList.remove('on');
                } else {
                    parentEl.classList.add('on');
                }
            });
        </script>
    </article>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
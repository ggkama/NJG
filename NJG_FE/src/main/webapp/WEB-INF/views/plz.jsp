<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--<%--%>
<%--    // JDBC 드라이버 로드--%>
<%--    Class.forName("org.mariadb.jdbc.Driver");--%>

<%--    // 데이터베이스 연결 설정--%>
<%--    Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/recipe", "root", "1234");--%>

<%--    Statement statement = conn.createStatement();--%>
<%--    ResultSet resultSet = statement.executeQuery("SELECT similar_number FROM similarity_list ORDER BY id DESC LIMIT 1");--%>

<%--    while (resultSet.next()) {--%>
<%--        String similarNumber = resultSet.getString("similar_number");--%>
<%--        String[] values = similarNumber.split(" ");--%>

<%--        for (int i = 0; i < 3; i++) {--%>
<%--            Statement statement2 = conn.createStatement();--%>
<%--            ResultSet resultSet2 = statement2.executeQuery("SELECT title, ingredients, source, recipe, image FROM new_content WHERE id =" + values[i]);--%>
<%--            while (resultSet2.next()) {--%>
<%--                byte[] imageData = resultSet2.getBytes("image");--%>
<%--                String base64Image = java.util.Base64.getEncoder().encodeToString(imageData);--%>
<%--%>--%>
<%--<div>--%>
<%--    <p><%= resultSet2.getString("title") %></p>--%>
<%--</div>--%>
<%--<div>--%>
<%--    <p><%= resultSet2.getString("ingredients") %></p>--%>
<%--</div>--%>
<%--<div>--%>
<%--    <p><%= resultSet2.getString("source") %></p>--%>
<%--</div>--%>
<%--<div>--%>
<%--    <p><%= resultSet2.getString("recipe") %></p>--%>
<%--</div>--%>
<%--<div>--%>
<%--    <img src="data:image/jpeg;base64, <%= base64Image %>" />--%>
<%--</div>--%>
<%--<%--%>
<%--            };--%>
<%--        }--%>
<%--    }--%>
<%--    // 리소스 정리--%>
<%--    resultSet.close();--%>
<%--    statement.close();--%>
<%--    conn.close();--%>
<%--%>--%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결과</title>
    <link rel="stylesheet" href="css/css.css">
</head>
<body>
<div id="output"></div>
<script>
    // REST API에 GET 요청을 보내는 함수
    function fetchData(recipeId) {
        // REST API 엔드포인트 URL
        var apiUrl = "/show/" + recipeId; // 여기에 실제 엔드포인트 URL을 넣어야 합니다.

        // fetch 함수를 사용하여 GET 요청 보내기
        fetch(apiUrl)
            .then(response => response.json()) // JSON 형태로 변환
            .then(data => {
                // 응답 데이터를 이용하여 화면에 표시
                displayRecipe(data);
            })
            .catch(error => console.error('Error:', error));
    }

    // 응답 데이터를 이용하여 화면에 표시하는 함수
    function displayRecipe(recipeData) {
        var outputDiv = document.getElementById('output');

        if (outputDiv) {
            console.log(recipeData.title);
            console.log(recipeData.ingredients);
            console.log(recipeData.source);
            console.log(recipeData.recipe);
        } else {
            console.error("Element with ID 'output' not found.");
        }
    }

    // 페이지 로드 시 실행
    document.addEventListener("DOMContentLoaded", function () {
        // 페이지 로드 후 fetchData 함수를 호출하여 데이터를 가져옴
        fetchData(56); // 가져올 레시피의 ID를 전달
    });
</script>

</body>
</html>


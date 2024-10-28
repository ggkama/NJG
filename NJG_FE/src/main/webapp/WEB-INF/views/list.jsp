<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // JDBC 드라이버 로드
    Class.forName("org.mariadb.jdbc.Driver");

    // 데이터베이스 연결 설정
    Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/recipe", "root", "1234");
    Statement statement = conn.createStatement();
    ResultSet resultSet = statement.executeQuery("SELECT similar_number, predict_names FROM similarity_list ORDER BY id DESC LIMIT 1");
    ResultSet resultSet2 = statement.executeQuery("SELECT image_path FROM input_image ORDER BY id DESC LIMIT 1");

    resultSet2.next();
    byte[] imageData = resultSet2.getBytes("image_path");
    String base64Image = java.util.Base64.getEncoder().encodeToString(imageData);

    while(resultSet.next()) {
        String[] mobnum = resultSet.getString("similar_number").split(" ");

        // mobnum 배열에서 첫 번째부터 세 번째 요소를 복사하여 number 배열 생성
        String[] number = new String[3];
        System.arraycopy(mobnum, 0, number, 0, 3);

        // mobnum 배열에서 네 번째부터 여섯 번째 요소를 복사하여 re_number 배열 생성
        String[] re_number = new String[3];
        System.arraycopy(mobnum, 3, re_number, 0, 3);

        // 문자열을 리스트로 변환
        String[] predictNamesArray = resultSet.getString("predict_names").split(",");
        List<String> list = Arrays.asList(predictNamesArray);

        String result = String.join(",", list);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>냉잔고</title>
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <link href="css/list.css" rel="stylesheet" type="text/css" />

    <!-- fonts -->
    <script src="https://kit.fontawesome.com/aa3cf60179.js" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<section>
    <article class="share-photo">
        <div class="tit">전달받은 이미지</div>
        <div class="imgWrap">
            <img src="data:image/jpeg;base64, <%= base64Image %>" />
        </div>
        <p>인식한 재료 > <%= result %></p>
    </article>
    <article class="list-page">
        <div class="tit">딱 맞는 추천 레시피</div>
        <div class="cont">
            <ul class="list">
                <li class="item">
                    <a href="" id="list_a1">
                        <div class="imgWrap">
                            <img id="list_image1" src="" alt="Recipe Image">
                            <em class="badge lge-only">
                                <span class="blind">BEST</span>
                            </em>
                        </div>
                        <div class="info">
                            <div class="name" id="list_title1"></div>
                        </div>
                    </a>
                </li>
                <li class="item">
                    <a href="" id="list_a2">
                        <div class="imgWrap">
                            <img id="list_image2" src="" alt="Recipe Image">
                            <em class="badge lge-only">
                                <span class="blind">BEST</span>
                            </em>
                        </div>
                        <div class="info">
                            <div class="name" id="list_title2"></div>
                        </div>
                    </a>
                </li>
                <li class="item">
                    <a href="" id="list_a3">
                        <div class="imgWrap">
                            <img id="list_image3" src="" alt="Recipe Image">
                            <em class="badge lge-only">
                                <span class="blind">BEST</span>
                            </em>
                        </div>
                        <div class="info">
                            <div class="name" id="list_title3"></div>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
        <div class="btnWrap">
            <button type="button" onclick="reroll()"><i class="fa-solid fa-rotate-right"></i>다시 추천받기</button>
        </div>
    </article>
    <%--        <article id="slide" class="slide" style="display:none;">--%>
    <%--            <div class="slide-inner flex">--%>
    <%--                <div class="head">--%>
    <%--                    <div class="tit">추천 레시피</div>--%>
    <%--                </div>--%>
    <%--                <div class="cont">--%>
    <%--                    <div class="swiper mySwiper">--%>
    <%--                        <div class="list swiper-wrapper">--%>
    <%--                            <div class="item swiper-slide">--%>
    <%--                                <a href="#none" target="_self">--%>
    <%--                                    <div class="imgWrap">--%>
    <%--                                        <img alt="레시피 이미지" src="img/output_4055035569.jpg">--%>
    <%--                                    </div>--%>
    <%--                                    <div class="txtWrap">--%>
    <%--                                        <div class="item-tit">김밥</div>--%>
    <%--                                    </div>--%>
    <%--                                </a>--%>
    <%--                            </div>--%>
    <%--                            <div class="item swiper-slide">--%>
    <%--                                <a href="#none" target="_self">--%>
    <%--                                    <div class="imgWrap">--%>
    <%--                                        <img alt="레시피 이미지" src="img/output_4055035569.jpg">--%>
    <%--                                    </div>--%>
    <%--                                    <div class="txtWrap">--%>
    <%--                                        <div class="item-tit">김밥</div>--%>
    <%--                                    </div>--%>
    <%--                                </a>--%>
    <%--                            </div>--%>
    <%--                            <div class="item swiper-slide">--%>
    <%--                                <a href="#none" target="_self">--%>
    <%--                                    <div class="imgWrap">--%>
    <%--                                        <img alt="레시피 이미지" src="img/output_4055035569.jpg">--%>
    <%--                                    </div>--%>
    <%--                                    <div class="txtWrap">--%>
    <%--                                        <div class="item-tit">김밥</div>--%>
    <%--                                    </div>--%>
    <%--                                </a>--%>
    <%--                            </div>--%>
    <%--                            <div class="item swiper-slide">--%>
    <%--                                <a href="#none" target="_self">--%>
    <%--                                    <div class="imgWrap">--%>
    <%--                                        <img alt="레시피 이미지" src="img/output_4055035569.jpg">--%>
    <%--                                    </div>--%>
    <%--                                    <div class="txtWrap">--%>
    <%--                                        <div class="item-tit">김밥</div>--%>
    <%--                                    </div>--%>
    <%--                                </a>--%>
    <%--                            </div>--%>
    <%--                            <div class="item swiper-slide">--%>
    <%--                                <a href="#none" target="_self">--%>
    <%--                                    <div class="imgWrap">--%>
    <%--                                        <img alt="레시피 이미지" src="img/output_4055035569.jpg">--%>
    <%--                                    </div>--%>
    <%--                                    <div class="txtWrap">--%>
    <%--                                        <div class="item-tit">김밥</div>--%>
    <%--                                    </div>--%>
    <%--                                </a>--%>
    <%--                            </div>--%>
    <%--                        </div>--%>
    <%--                    </div>--%>
    <%--                    <div class="swiper-pagination"></div>--%>
    <%--                </div>--%>
    <%--                <!-- Initialize Swiper -->--%>
    <%--                <script>--%>
    <%--                    var swiper = new Swiper(".mySwiper", {--%>
    <%--                        slidesPerView: 3,--%>
    <%--                        spaceBetween: 30,--%>
    <%--                        pagination: {--%>
    <%--                            el: "#slide .swiper-pagination",--%>
    <%--                            type: "progressbar",--%>
    <%--                        },--%>
    <%--                    });--%>
    <%--                </script>--%>
    <%--            </div>--%>
    <%--        </article>--%>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
<script>
    function reroll() {
        // Java 배열을 JavaScript 배열로 변환
        var re_number = [
            <% for(int i = 0; i < re_number.length; i++) {
                out.print("\"" + re_number[i] + "\"");
                if (i < re_number.length - 1) out.print(", ");
            } %>
        ];

        // 페이지 로드 후 fetchData 함수를 호출하여 데이터를 가져옴
        for (var i = 0; i < re_number.length; i++) {
            fetchData(i + 1, re_number[i]); // 가져올 레시피의 ID를 전달
        }
    }

    // REST API에 GET 요청을 보내는 함수
    function fetchData(i, recipeId) {
        // REST API 엔드포인트 URL
        var apiUrl = "/show/" + recipeId; // 여기에 실제 엔드포인트 URL을 넣어야 합니다.

        // fetch 함수를 사용하여 GET 요청 보내기
        fetch(apiUrl)
            .then(response => response.json()) // JSON 형태로 변환
            .then(data => {
                if (data.image) {
                    var base64Image = data.image;
                    console.log(data.id);
                    document.getElementById("list_title"+i).innerText = data.title;
                    document.getElementById("list_image"+i).src = "data:image/jpeg;base64," + base64Image;
                    var post_num = document.getElementById("list_a"+i);
                    post_num.href = "detail?postId=" + data.id;
                    //
                    // var el = document.querySelectorAll('li.item > a');
                    // console.log(el)
                    // el.forEach(function(list){
                    //     var elId = data.id
                    //     var href = "detail.jsp?postId=" + elId;
                    //     console.log(list + "ASDF");
                    //
                    //     list.setAttribute('href', href);
                    // })
                }
            })
            .catch(error => console.error('Error:', error));
    }

    // 페이지 로드 시 실행
    document.addEventListener("DOMContentLoaded", function () {
        // Java 배열을 JavaScript 배열로 변환
        var number = [
            <% for(int i = 0; i < number.length; i++) {
                out.print("\"" + number[i] + "\"");
                if (i < number.length - 1) out.print(", ");
            } %>
        ];

        // 페이지 로드 후 fetchData 함수를 호출하여 데이터를 가져옴
        for (var i = 0; i < number.length; i++) {
            fetchData(i + 1, number[i]); // 가져올 레시피의 ID를 전달
        }
        <% } %>
    });
</script>
</html>
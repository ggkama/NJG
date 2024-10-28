<%@ page import="com.springboot.project4.data.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>냉잔고</title>
    <link href="./css/common.css" rel="stylesheet" type="text/css" />
    <link href="./css/detail.css" rel="stylesheet" type="text/css" />

    <!-- fonts -->
    <script src="https://kit.fontawesome.com/aa3cf60179.js" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<section>
    <article class="detail">
        <div class="detail-inner">
            <div class="thumbImg">
                <img id="detail_image" src="" alt="Recipe Image">
            </div>
            <div class="head">
                <div class="tit" id="detail_title"></div>
            </div>
            <div class="cont_ingre2">
                <div class="best_tit">
                    <b>재료</b><span>Ingredients</span>
                </div>
                <div class="ready_ingre3" id="divConfirmedMaterialArea">
                    <b class="ready_ingre3_tt" style="padding-bottom: 0px;">[재료]</b>
                    <ul>
                        <b class="ready_ingre3_tt">[소스]</b>
                        <li id="detail_ingredients" class="dn" style="display: none"></li>
                        <li id="detail_source" class="dn" style="display: none"></li>
                    </ul>
                    <ul id="out_ingredients"></ul>
                    <ul id="out_source"></ul>
                </div>
            </div>
            <div class="recipe-tit">조리방법</div>
            <div class="cont">
                <div class="">
                    <p id="detail_recipe" class="dn" style="display: none"></p>
                </div>
                <div id="out_recipe"></div>
            </div>
            <div class="cmt">
                <div class="view_reply st2">
                    <div class="reply_tit">요리 후기</div>
                    <div class="box_comment_list">
                        <ul>
                            <li class="comment_item rp_general">
                                <div class="comment">
                                    <!-- thumb_author -->
                                    <div class="thumb_author">
                                        <img src="#" alt="회원 프로필 사진">
                                    </div>
                                    <!-- comment_body -->
                                    <div class="comment_body">
                                        <div class="author_info">
                                            <% if (session.getAttribute("loggedInUser") != null) { %>
                                            <div class="author">
                                                <span><%= ((User) session.getAttribute("loggedInUser")).getUserId() %></span>
                                            </div>
                                            <% } else { %>
                                            <div class="author">
                                                <span>비로그인</span>
                                            </div>
                                            <% } %>
                                            <div class="details">
                                                <span class="date">작성시간</span>
                                                <!-- 신고 기능 없음 by osh -->
                                                <!--&lt;a href=&quot;#&quot; class=&quot;link_notify&quot;&gt;신고&lt;/a&gt;-->
                                            </div>
                                        </div>
                                        댓글 내용
                                        <div class="control">
                                            <a href="#">수정/삭제</a><a href="#">답글</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- reply -->
                                <!-- //reply -->
                            </li>
                        </ul>
                    </div>
                    <form method="post" action="" style="margin: 0">
                        <div class="box_comment_write">
                            <!-- register_area -->
                            <div class="register_area">
                                <!-- form_guest -->
                                <div class="form_guest">
                                    <!-- name -->
                                    <div class="box_inp">
                                        <div class="inner_inp">
                                            <input type="text" name="name" value="" title="이름" placeholder="이름" class="inp_comment inp_name">
                                        </div>
                                    </div>
                                    <!-- password -->
                                    <div class="box_inp">
                                        <div class="inner_inp">
                                            <input type="password" name="password" value="" title="비밀번호" maxlength="12" placeholder="비밀번호" class="inp_comment inp_password">
                                        </div>
                                    </div>
                                </div>
                                <!-- //form_guest -->
                                <!-- secret -->
                                <div class="form_secret">
                                    <input id="commentSecret" type="checkbox" name="secret">
                                    <label for="commentSecret" class="label_secret">비밀글 <i class="icon-check"></i></label>
                                </div>
                                <!-- form_cont -->
                                <div class="form_cont">
                                    <textarea id="comment" name="comment" placeholder="댓글을 입력해주세요."></textarea>
                                </div>
                                <!-- button-form -->
                                <button type="button" class="btn_register">댓글 남기기</button>
                            </div>
                            <!-- //register_area -->
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </article>
</section>
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
                processIngredients('detail_ingredients', 'out_ingredients', null, data.ingredients);
                processIngredients('detail_source', 'out_source', null, data.source);
                processIngredients('detail_recipe','out_recipe', true, data.recipe);
                if (data.image) {
                    var base64Image = data.image;
                    document.getElementById("detail_title").innerText = data.title;
                    document.getElementById("detail_image").src = "data:image/jpeg;base64," + base64Image;
                }
            })
            .catch(error => console.error('Error:', error));
    }

    function processIngredients(inputId, outputId, removeDot, recipeData) {
        document.getElementById(inputId).textContent = recipeData
        var ing = document.getElementById(inputId).textContent;
        var ingArray = ing.split(',');

        // 각 요소 양 끝의 공백과 작은따옴표 제거
        ingArray = ingArray.map(function(item) {
            // 양 끝의 작은따옴표와 대괄호를 제거
            item = item.trim().replace(/^['\[\]]+|['\[\]]+$/g, '');

            // 문자열에 #이 포함된 경우에만 #을 제거
            if (item.includes('#')) {
                item = item.replace(/#/g, '');
            }

            return item;
        });

        var ingOutPut = document.getElementById(outputId);

        if (ingOutPut) {
            // 기존 내용 비우기
            ingOutPut.innerHTML = '';

            for (var i = 0; i < ingArray.length; i++) {
                // removeDot 매개변수가 참일 때만 문자열에서 . 이후의 내용 제거
                if (removeDot) {
                    //ingArray[i] = ingArray[i].replace(/\..*$/, '');
                    var listItem = document.createElement('p');
                } else {
                    var listItem = document.createElement('li');
                }

                listItem.textContent = ingArray[i];
                ingOutPut.appendChild(listItem);
            }
        }
    }

    // 페이지 로드 시 실행
    document.addEventListener("DOMContentLoaded", function () {
        // 페이지 로드 후 fetchData 함수를 호출하여 데이터를 가져옴
        <% int postId = Integer.parseInt(request.getParameter("postId")); %>
        fetchData(<%= postId %>); // 가져올 레시피의 ID를 전달
    });
</script>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
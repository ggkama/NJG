<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // JDBC 드라이버 로드
    Class.forName("org.mariadb.jdbc.Driver");

    // 데이터베이스 연결 설정
    Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/recipe", "root", "1234");
    Statement statement = conn.createStatement();
    ResultSet resultSet = statement.executeQuery("SELECT idx, title, image FROM post_list WHERE board_type='notice' ORDER BY idx DESC LIMIT 5");
    ResultSet resultSet2 = statement.executeQuery("SELECT idx, title, image FROM post_list WHERE board_type='free' ORDER BY idx DESC LIMIT 5");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>냉잔고</title>
        <link href="css/common.css" rel="stylesheet" type="text/css" />
        <link href="css/main.css" rel="stylesheet" type="text/css" />

        <!-- fonts -->
        <script src="https://kit.fontawesome.com/aa3cf60179.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <!-- Main -->
        <section id="main">
            <article class="home-main-01">
                <div class="home-main-inner">
                    <div class="home-main-img">
                        <img class="home-main-image-right" alt="냉잔고, 레시피, 메뉴추천, 점메추, 저메추" src="img/home-main-img001-01.jpg">
                    </div>
                    <div class="home-main-desc">
                        <h1 class="home-main-title">집에 있는 재료로<br>뭘 만들 수 있을까?</h1>
                        <p class="service-desc">
                            색다른 레시피를 원한다면,<br> 냉잔고를 열어 간편하게 찰칵.
                        </p>
                        <ul class="home-btn">
                            <li id="fileImg" class="home-btn-item">
                                <a href="#none" onclick="openUploader(event);">이미지 업로드</a>
                            </li>
                            <li id="cameraImg" class="home-btn-item">
                                <a href="#" onclick="openCamera()">카메라 열기</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </article>
            <article class="board">
                <div class="inner flex">
                    <div class="board_lt">
                        <div class="board_head">
                            <h3 class="board_title">공지사항</h3>
                            <a href="/board_list?boardType=notice" class="btn_more">더보기</a>
                        </div>
                        <div class="board_list">
                            <% while(resultSet.next()) { %>
                            <div class="list">
                                <div class="list_item">
                                    <a href="/post_detail?postId=<%= resultSet.getInt("idx") %>">
                                        <div class="item_area">
                                            <strong class="tit"><span class="label"></span><%= resultSet.getString("title") %></strong>
                                            <div class="item_info">
                                                <div class="item_num">
                                                    <span class="count like">
                                                        <i class="fa-regular fa-heart"></i>좋아요 개수
                                                    </span>
                                                    <span class="count comment">
                                                        <i class="fa-regular fa-comment-dots"></i>댓글 개수
                                                    </span>
                                                </div>
                                                <span class="board_name"></span>
                                            </div>
                                        </div>
                                        <div class="thumb_area">
                                            <span class="thumb_image_item">
                                                <img src="img/thumb.jpg" alt="첨부파일 이미지" class="thumb_image">
                                            </span>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <% } %>
                            <%
                                resultSet.close();
                            %>
                        </div>
                    </div>
                    <div class="board_rt">
                        <div class="board_head">
                            <h3 class="board_title">자유게시판</h3>
                            <a href="/board_list?boardType=free" class="btn_more">더보기</a>
                        </div>
                        <div class="board_list">
                            <% while(resultSet2.next()) { %>
                            <div class="list">
                                <div class="list_item">
                                    <a href="post_detail?postId=<%= resultSet2.getInt("idx") %>">
                                        <div class="item_area">
                                            <strong class="tit"><span class="label"></span><%= resultSet2.getString("title") %></strong>
                                            <div class="item_info">
                                                <div class="item_num">
                                                    <span class="count like">
                                                        <i class="fa-regular fa-heart"></i>좋아요 개수
                                                    </span>
                                                    <span class="count comment">
                                                        <i class="fa-regular fa-comment-dots"></i>댓글 개수
                                                    </span>
                                                </div>
                                                <span class="board_name"></span>
                                            </div>
                                        </div>
                                        <div class="thumb_area">
                                            <span class="thumb_image_item">
                                                <img src="img/thumb.jpg" alt="첨부파일 이미지" class="thumb_image">
                                            </span>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <% } %>
                            <%
                                resultSet2.close();
                                statement.close();
                                conn.close();
                            %>
                        </div>
                    </div>
                </div>
            </article>
        </section>
        <div id="fileLoad" class="">
            <div class="inner">
                <form action="/upload" method="post" enctype="multipart/form-data">
                    <div class="head">
                        <div class="tit">
                            재료 이미지 업로드 
                        </div>
                        <div class="close">
                            <span class="ico_close" onclick="closeUploader();"><i class="fa-solid fa-xmark"></i></span>
                        </div>
                    </div>
                    <div class="cont">
                        <input type="file" id="fileInput" name="fileInput" accept="image/*" hidden="true">
                        <div class="uploadArea">
                            <label id="fileLabel" class="text-upload" for="fileInput">
                                <div id="fileInner" class="inner pc">사진을 <b>드래그</b>하거나 클릭해서 <b>업로드</b> 해주세요.</div>
                                <div id="fileInner" class="inner mo">이 곳을 클릭해서 사진을 <b>업로드</b> 해주세요.</div>
                            </label>
                        </div>
                        <div id="imagePreview" class="image-preview"></div>
                    </div>
                    <div class="submit">
                        <button type="submit" class="submit-btn" onclick="submitRecipe(event)">레시피 추천 받기</button>
                    </div>
                </form>
            </div>
        </div>
        <div id="loading">
            <div class="contianer">
                <div class="box">
                    <div class="loader1"></div>
                    <p>Loading...</p>
                </div>
            </div>
        </div>

        <script>
            var body = document.querySelector('body');
            var loadingModal = document.getElementById("loading"); // 로딩 모달 추가

            // 업로드 창 열림
            function openUploader(event){
                event.preventDefault();
                document.getElementById('fileLoad').style.display = 'block';
                if (body.classList.contains('mobile')) {
                    document.getElementById('wrap').style.display = 'block';
                }
            };

            // 닫기
            function closeUploader(){
                document.getElementById('fileLoad').style.display = 'none';
                document.getElementById('wrap').style.display = 'none';
            };

            // 이미지 업로드
            var input = document.getElementById("fileInput");
            var initLabel = document.getElementById("fileLabel");
            var inner = document.getElementById("fileInner");

            // 파일 목록 추출 후 미리보기 업데이트 함수 호출
            input.addEventListener("change", (event) => {
                const files = changeEvent(event);
                handleUpdate(files);
            });

            // mouseover 시 클래스 추가
            initLabel.addEventListener("mouseover", (event) => {
                event.preventDefault();
                const label = document.getElementById("fileLabel");
                label?.classList.add("label--hover");
            });

            // mouseout 시 클래스 제거
            initLabel.addEventListener("mouseout", (event) => {
                event.preventDefault();
                const label = document.getElementById("fileLabel");
                label?.classList.remove("label--hover");
            });

            // 드래그 이벤트 처리
            initLabel.addEventListener("dragover", (event) => {
                event.preventDefault();
                console.log("dragover");
                const label = document.getElementById("fileLabel");
                label?.classList.add("label--hover");
            });

            initLabel.addEventListener("dragleave", (event) => {
                event.preventDefault();
                console.log("dragleave");
                const label = document.getElementById("fileLabel");
                label?.classList.remove("label--hover");
            });

            initLabel.addEventListener("drop", (event) => {
                event.preventDefault();
                console.log("drop");
                const label = document.getElementById("fileLabel");
                label?.classList.remove("label--hover");

                const files = event.dataTransfer?.files;
                handleUpdate([...files]);
            });

            // 파일 목록을 추출하여 처리할 수 있도록
            function changeEvent(event) {
                const { target } = event;
                return [...target.files];
            }

            var maxImageCount = 1; // 최대 이미지 개수
            var uploadedImageCount = 0;

            function handleUpdate(fileList) {
                const preview = document.getElementById("imagePreview");

                fileList.forEach((file) => {
                    if (uploadedImageCount < maxImageCount) {
                        const reader = new FileReader();
                        reader.addEventListener("load", (event) => {
                            const img = document.createElement("img");
                            img.className = "embed-img";
                            img.src = event.target?.result;

                            const imgContainer = document.createElement("div");
                            imgContainer.className = "container-img";
                            imgContainer.appendChild(img);

                            // 삭제 버튼 추가
                            const deleteButton = document.createElement("button");
                            deleteButton.innerText = "삭제";
                            deleteButton.addEventListener("click", () => {
                                deleteImage(imgContainer);
                            });

                            imgContainer.appendChild(deleteButton);
                            preview.innerHTML = ""; // 이미지 미리보기 영역 비우기
                            preview.appendChild(imgContainer);
                            uploadedImageCount = 1; // 업로드된 이미지 개수 초기화
                        });
                        reader.readAsDataURL(file);
                    } else {
                        alert("이미지를 더 이상 업로드할 수 없습니다. 최대 이미지 개수 초과.");
                    }
                });
            }

            function deleteImage(container) {
                const preview = document.getElementById("imagePreview");
                // 삭제 버튼이 클릭되었을 때 호출되는 함수
                container.parentNode.removeChild(container);
                preview.innerHTML = ""; // 이미지 미리보기 영역 비우기
                uploadedImageCount = 0; // 업로드된 이미지 개수 초기화
            }

            function openCamera() {
                // input 요소 생성
                var cameraInput = document.createElement("input");
                cameraInput.type = "file";
                cameraInput.accept = "image/*";
                cameraInput.capture = "environment"; // 카메라 사용

                // input을 숨겨진 상태로 body에 추가
                cameraInput.style.display = "none";
                document.body.appendChild(cameraInput);

                // input에 대한 change 이벤트를 수신하여 파일 선택 또는 촬영 후의 처리
                cameraInput.addEventListener("change", function (event) {
                    handleFileSelection(event);
                    // 사용이 끝난 input 요소를 제거
                    document.body.removeChild(cameraInput);
                });

                // input 요소를 클릭하여 카메라를 열도록 함
                cameraInput.click();


                openUploader(event);
            }

            function handleFileSelection(event) {
                const files = changeEvent(event);
                handleUpdate(files);
            }


            // 추천받기 버튼을 눌렀을 때
            function submitRecipe(event) {
                const preview = document.getElementById("imagePreview");
                const uploadedImages = preview.querySelectorAll(".container-img");

                if (uploadedImages.length === 0) {
                    event.preventDefault()
                    alert('사진을 선택해주세요.');

                } else {
                    document.getElementById('loading').style.display = 'block';
                }
            }
        </script>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
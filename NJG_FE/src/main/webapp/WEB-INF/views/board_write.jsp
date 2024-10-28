<%@ page import="com.springboot.project4.data.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <div class="board_title">
            <strong>게시글 작성</strong>
        </div>
        <div class="board_write">
            <form action="/post" method="post">
                <div class="input-group">
                    <div class="input-tit">카테고리</div>
                    <div class="input-info">
                        <div id="selectBox">
                            <div class="cateName"><span>공지사항</span><i class="fa-solid fa-caret-down"></i></div>
                            <ul class="cateSel">
                                <li id="sel1" class="active">공지사항</li>
                                <li id="sel2">문의사항</li>
                                <li id="sel3">자유게시판</li>
                                <li id="sel4">레시피공유게시판</li>
                            </ul>
                            <script>
                                var cateBox = document.querySelector('.boardLt .tit');

                                cateBox.addEventListener('click', function() {
                                    var parentEl = document.querySelector('.boardLt');
                                    if (parentEl.classList.contains('on')) {
                                        parentEl.classList.remove('on');
                                    } else {
                                        parentEl.classList.add('on');
                                    }
                                });

                                //select dropdown
                                var selectBox = document.getElementById('selectBox');

                                selectBox.addEventListener('click', function(){
                                    if(selectBox.classList.contains('on')){
                                        selectBox.classList.remove('on');
                                    } else {
                                        selectBox.classList.add('on');
                                    }
                                });

                                //active된 li 제목영역에 추가
                                var cateList = document.querySelectorAll("ul.cateSel > li");
                                cateList.forEach(function(item) {
                                    item.addEventListener('click', function(e) {
                                        // 모든 li 요소에서 'active' 클래스 제거
                                        cateList.forEach(function(li) {
                                            li.classList.remove('active');
                                        });

                                        // 클릭된 li 요소에 'active' 클래스 추가
                                        e.target.classList.add('active');

                                        // 클릭된 li 요소의 텍스트 내용을 가져와서 출력
                                        var val = e.target.textContent;

                                        // div.cateName 요소의 텍스트 내용을 클릭된 li의 텍스트로 설정
                                        document.querySelector('div.cateName > span').textContent = val;
                                    });
                                });
                            </script>
                        </div>
                    </div>
                </div>
                <div class="input-group">
                    <div class="input-tit">제목</div>
                    <div class="input-info">
                        <label for="title">제목</label>
                        <input type="text" id="title" name="title" placeholder="게시글 제목을 작성해주세요." required>
                        <span class="focus-border">
                            <i></i>
                          </span>
                    </div>
                </div>
                <div class="input-group">
                    <div class="input-tit">글쓴이</div>
                    <div class="input-info">
                        <label for="userId">글쓴이</label>
                        <input type="text" id="userId" name="userId" value="<%= ((User) session.getAttribute("loggedInUser")).getUserId() %>" readonly>
                        <span class="focus-border">
                            <i></i>
                          </span>
                    </div>
                </div>
                <div class="input-group">
                    <div class="input-tit">내용</div>
                    <div class="input-info">
                        <label for="content">내용</label>
                        <textarea name="content" id="content" rows="20" cols="10" placeholder="내용을 입력해주세요" style="width:100%"></textarea>
                        <span class="focus-border">
                            <i></i>
                          </span>
                    </div>
                </div>
                <%--                  <div class="input-group">--%>
                <%--                      <div class="input-tit">내용</div>--%>
                <%--                      <div class="input-info">--%>
                <%--                          <body>--%>
                <%--                              <h3>Naver Smart Editor 2.0</h3>--%>
                <%--                              <form action="insertStudentInfoForm" method="post">--%>
                <%--                                  <div id="smarteditor">--%>
                <%--                                      <textarea name="editorTxt" id="editorTxt" rows="20" cols="10" placeholder="내용을 입력해주세요" style="width:100%"></textarea>--%>
                <%--                                  </div>--%>
                <%--                              </form>--%>
                <%--                          </body>--%>
                <%--                          <script>--%>
                <%--                              let oEditors = []--%>
                <%--                              smartEditor = function(){--%>
                <%--                                  console.log("Naver SmartEditor")--%>
                <%--                                  nhn.husky.EZCreator.createInIFrame({--%>
                <%--                                      oAppRef: oEditors,--%>
                <%--                                      elPlaceHolder: "editorTxt",--%>
                <%--                                      sSkinURI: "./smarteditor/SmartEditor2Skin.html",--%>
                <%--                                      fCreator: "createSEditor2"--%>
                <%--                                  })--%>
                <%--                              }--%>

                <%--                              document.addEventListener("DOMContentLoaded", function(){--%>
                <%--                                  smartEditor()--%>
                <%--                              });--%>
                <%--                          </script>--%>
                <%--                      </div>--%>
                <%--                  </div>--%>
                <div class="bt_wrap">
                    <button type="submit">등록</button>
                    <a href="/board_list">목록</a>
                </div>
            </form>
        </div>
    </article>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
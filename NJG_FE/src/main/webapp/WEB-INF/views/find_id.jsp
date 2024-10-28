<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>냉잔고</title>
    <link href="./css/common.css" rel="stylesheet" type="text/css" />
    <link href="./css/login.css" rel="stylesheet" type="text/css" />

    <!-- fonts -->
    <script src="https://kit.fontawesome.com/aa3cf60179.js" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<!-- Main -->
<section>
    <article id="login">
        <div class="titWrap">
            <h2>아이디 찾기</h2>
        </div>
        <div id="tabWrap" class="tab">
            <ul>
                <li id="tab1" class="active">휴대폰 인증</li>
                <li id="tab2">이메일 인증</li>
            </ul>
        </div>
        <div class="container">
            <form action="" method="post">
                <div class="input-group" style="margin-bottom: 30px">
                    <label for="userName">이름</label>
                    <input type="text" id="userName" name="userName" placeholder="이름을 입력해주세요" required>
                    <span class="focus-border">
                        <i></i>
                    </span>
                </div>
                <div id="tabContent1" class="input-group tabContent" style="display:block; margin-bottom: 50px">
                    <label for="userPhone">전화번호</label>
                    <input type="text" id="userPhone" name="userPhone" placeholder="전화번호를 입력해주세요" required>
                    <span class="focus-border">
                        <i></i>
                    </span>
                </div>
                <div id="tabContent2" class="input-group tabContent" style="margin-bottom: 50px;">
                    <label for="userEmail">이메일</label>
                    <input type="text" id="userEmail" name="userEmail" placeholder="이메일을 입력해주세요" required>
                    <span class="focus-border">
                        <i></i>
                    </span>
                </div>
                <button type="submit">인증번호 받기</button> <!-- 제출 버튼 생성하는 코드 -->
            </form>
        </div>
    </article>
</section>
<script>
    var tabWrap = document.getElementById('tabWrap');
    var lis = document.querySelectorAll('#tabWrap li');

    tabWrap.addEventListener('click', function(event) {
        var target = event.target;

        // 클릭된 요소가 li인지 확인
        if (target.tagName === 'LI') {
            // 모든 탭 컨텐츠를 감춤
            document.querySelectorAll('div.tabContent').forEach(function(content) {
                content.style.display = 'none';
            });

            // 모든 탭에서 'active' 클래스 제거
            lis.forEach(function(li) {
                li.classList.remove('active');
            });

            // 클릭된 탭에 'active' 클래스 추가
            target.classList.add('active');

            // 클릭된 탭에 해당하는 컨텐츠를 보이게 함
            var tabId = target.getAttribute('id');
            var contentId = 'tabContent' + tabId.substring(3);  // tab1, tab2 등에서 숫자 부분 추출
            document.getElementById(contentId).style.display = 'block';
        }
    });
</script>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>냉잔고</title>
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <link href="css/login.css" rel="stylesheet" type="text/css" />

    <!-- fonts -->
    <script src="https://kit.fontawesome.com/aa3cf60179.js" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<!-- Main -->
<section>
    <article id="login">
        <div class="titWrap">
            <h2>로그인</h2>
        </div>
        <div class="container">
            <form action="/loginConfirm" method="post"> <!--다음 사이트 주소 코드-->
                <div class="input-group" style="margin-bottom: 30px">
                    <label for="userId">ID</label>
                    <input type="text" id="userId" name="userId" placeholder="아이디를 입력해주세요" required>
                    <span class="focus-border">
                        <i></i>
                    </span>
                </div>
                <div class="input-group" style="margin-bottom: 50px">
                    <label for="userPwd">PW</label>
                    <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력해주세요" required>
                    <span class="focus-border">
                        <i></i>
                    </span>
                </div>
                <div class="findInfo">
                    <a href="/findId">아이디 찾기</a>
                    <a href="/findPw">비밀번호 찾기</a>
                </div>
                <button type="submit">로그인</button> <!-- 제출 버튼 생성하는 코드 -->
            </form>
            <a href="/register" class="btn">회원가입</a> <!-- 제출 버튼 생성하는 코드 -->
            <div class="line">OR</div>
            <a href="http://kauth.kakao.com/oauth/authorize?client_id=d20a874ebfe9582adbe9ca8c7e26fc4d&amp;redirect_uri=http://localhost:8089/oauth/kakao&amp;response_type=code&amp;prompt=login" class="kakao">
                <img src="./img/kakao_login_medium_wide.png" alt="카카오톡으로 로그인하기" class="">카카오 로그인</a>
        </div>
    </article>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
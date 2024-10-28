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
            <article id="register">
                <div class="titWrap">
                    <h2>회원가입</h2>
                    <div><span class="point">*</span>필수입력사항</div>
                </div>

                <div class="container">
                    <form action="/registerConfirm" method="post"> <!--다음 사이트 주소 코드-->
                        <div class="input-group">
                            <div class="input-tit">아이디<span class="point">*</span></div>
                            <div class="input-info">
                                <label for="userId">아이디</label>
                                <input type="text" id="userId" name="userId" placeholder="아이디를 입력해주세요." required>
                                <span class="focus-border">
                                    <i></i>
                                </span>
                            </div>
                            <div class="input-check">
                                <button type="button" class="btn">중복확인</button>
                            </div>
                        </div>
                        <div class="input-group">
                            <div class="input-tit">비밀번호<span class="point">*</span></div>
                            <div class="input-info">
                                <label for="userPwd">비밀번호</label>
                                <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력해주세요." required>
                                <span class="focus-border">
                                    <i></i>
                                </span>
                            </div>
                            <div class="input-check"></div>
                        </div>
                        <div class="input-group">
                            <div class="input-tit">비밀번호 확인<span class="point">*</span></div>
                            <div class="input-info">
                                <label for="userPwdCheck">비밀번호 확인</label>
                                <input type="password" id="userPwdCheck" name="userPwdCheck" placeholder="비밀번호를 입력해주세요." required>
                                <span class="focus-border">
                                    <i></i>
                                </span>
                            </div>
                            <div class="input-check"></div>
                        </div>
                        <div class="input-group">
                            <div class="input-tit">이름<span class="point">*</span></div>
                            <div class="input-info">
                                <label for="userName">이름</label>
                                <input type="text" id="userName" name="userName" placeholder="이름을 입력해주세요." required>
                                <span class="focus-border">
                                    <i></i>
                                </span>
                            </div>
                            <div class="input-check"></div>
                        </div>
                        <div class="input-group">
                            <div class="input-tit">이메일<span class="point">*</span></div>
                            <div class="input-info">
                                <label for="userEmail">이메일</label>
                                <input type="text" id="userEmail" name="userEmail" placeholder="예:naengjango@jango.com" required>
                                <span class="focus-border">
                                    <i></i>
                                </span>
                            </div>
                            <div class="input-check"></div>
                        </div>
                        <div class="input-group">
                            <div class="input-tit">휴대폰번호<span class="point">*</span></div>
                            <div class="input-info">
                                <label for="userPhone">휴대폰번호</label>
                                <input type="text" id="userPhone" name="userPhone" placeholder="숫자만 입력해주세요." required>
                                <span class="focus-border">
                                    <i></i>
                                </span>
                            </div>
                            <div class="input-check"></div>
                        </div>
<%--                        <div class="input-group address">--%>
<%--                            <div class="input-tit">주소</div>--%>
<%--                            <div class="input-info">--%>
<%--                                <label for="addNum">우편번호</label>--%>
<%--                                <input type="text" id="addNum" name="addNum" placeholder="우편번호" readonly="readonly" disabled>--%>
<%--                                <button type="button" class="btn" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>--%>
<%--                            </div>--%>
<%--                            <div class="input-check"></div>--%>
<%--                        </div>--%>
<%--                        <div class="input-group">--%>
<%--                            <div class="input-tit"></div>--%>
<%--                            <div class="input-info">--%>
<%--                                <label for="userAdd">주소</label>--%>
<%--                                <input type="text" id="userAdd" name="userAdd" placeholder="주소" readonly="readonly" disabled>--%>
<%--                            </div>--%>
<%--                            <div class="input-check"></div>--%>
<%--                        </div>--%>
<%--                        <div class="input-group">--%>
<%--                            <div class="input-tit"></div>--%>
<%--                            <div class="input-info">--%>
<%--                                <label for="userAddDetail">상세주소</label>--%>
<%--                                <input type="text" id="userAddDetail" name="userAddDetail" placeholder="상세주소를 입력해주세요.">--%>
<%--                                <span class="focus-border">--%>
<%--                                    <i></i>--%>
<%--                                </span>--%>
<%--                            </div>--%>
<%--                            <div class="input-check"></div>--%>
<%--                        </div>--%>
                        <div class="input-group gender">
                            <div class="input-tit">성별</div>
                            <div class="input-info">
                                <input type="radio" id="genderMan" name="userGender" value="male">
                                <label for="genderMan">남자</label>
                                <input type="radio" id="genderWoman" name="userGender" value="female">
                                <label for="genderWoman">여자</label>
                                <input type="radio" id="genderNoChk" name="userGender" value="noCheck" checked>
                                <label for="genderNoChk">선택안함</label>
                            </div>
                            <div class="input-check"></div>
                        </div>
                        <div class="input-group birth">
                            <div class="input-tit">생년월일</div>
                            <div class="input-info">
                                <div class="birthWrap">
                                    <input type="text" id="userYear" name="userYear" placeholder="YYYY">/
                                    <input type="text" id="userMonth" name="userMonth" placeholder="MM">/
                                    <input type="text" id="userDay" name="userDay" placeholder="DD">
                                </div>
                            </div>
                            <div class="input-check"></div>
                        </div>
                        <button type="submit" class="btn">가입하기</button> <!-- 제출 버튼 생성하는 코드 -->
                    </form>
                </div>
            </article>
        </section>
        <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
        <script src="/resources/js/addressapi.js"></script>
        <script>
            function execPostCode() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                        // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                        var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraRoadAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraRoadAddr !== ''){
                            extraRoadAddr = ' (' + extraRoadAddr + ')';
                        }
                        // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                        if(fullRoadAddr !== ''){
                            fullRoadAddr += extraRoadAddr;
                        }

                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.getElementById('addNum').value = data.zonecode; //5자리 새우편번호 사용
                        document.getElementById('userAdd').value = fullRoadAddr;
                    }
                }).open();
            }
        </script>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer>
    <div class="footer-inner">
        <div class="footer">
            <div class="company-info">
                <span><b>대표</b></span><span>김성훈, 김유준, 박혜민, 백민호, 지용욱</span><br />
                <span><b>주소</b></span><span>서울특별시 금천구 가산디지털1로 25 대륭테크노타운 17차 18층 플레이데이터</span><br />
                <span><b>고객문의</b></span><span>phyemii@naver.com</span>
            </div>
            <div class="service-qa" style="display:none;">
                <ul>
                    <li><a href="#none">FAQ</a></li>
                </ul>
            </div>
        </div>
    </div>
</footer>
<div id="wrap" style="display:none;"></div>
<script>
    // 접속 환경 PC/mo 구분
    window.onload = function deviceCheck() {
        const user = navigator.userAgent;
        if ( user.indexOf("iPhone") > -1 || user.indexOf("Android") > -1 ) {
            //Mobile접속
            document.querySelector('body').className = 'mobile';
        }else{
            //PC접속
            document.querySelector('body').className = 'pc';
        }
    }

    //모바일 메뉴창 토글
    function openMenu(){
        document.querySelector('.mobile-menu-area').classList.toggle('toggle');
    }
</script>
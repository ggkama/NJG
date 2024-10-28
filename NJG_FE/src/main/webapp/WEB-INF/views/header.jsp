<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header>
    <div>
        <div class="header-inner">
            <div class="home-top-logo">
                <a href="/">
                    <img src="img/logo_no_text.png" alt="냉잔고 로고">
                    <span class="txt">냉잔고</span>
                </a>
            </div>
            <nav class="home-top-menu">
                <ul>
                    <li><a href="/board_list?boardType=notice" class="active">공지사항</a></li>
                    <li><a href="/board_list?boardType=inquiry">문의게시판</a></li>
                    <li><a href="/board_list?boardType=free">자유게시판</a></li>
                    <li><a href="/board_list?boardType=recipe">레시피공유게시판</a></li>
                </ul>
            </nav>
            <% if (session.getAttribute("userId") != null) { %>
            <ul class="home-top-login logout">
                <li><a href="/klogout">로그아웃</a></li>
                <li><a href="/mypage">회원정보</a></li>
            </ul>
            <% } else { %>
            <% if (session.getAttribute("loggedInUser") != null) { %>
            <ul class="home-top-login logout">
                <li><a href="/logout_do">로그아웃</a></li>
                <li><a href="/mypage">회원정보</a></li>
            </ul>
            <% } else { %>
            <ul class="home-top-login">
                <li><a href="/login">로그인</a></li>
                <li><a href="/register">회원가입</a></li>
            </ul>
            <% } %>
            <% } %>
            <div id="srchWrap" style="display:none;">
                <input type="text" placeholder="재료를 입력해 보세요.">
                <a href="#none">채팅하기</a>
            </div>
            <div class="mobile-menu">
                <% if (session.getAttribute("userId") != null) { %>
                <div class="login logout">
                    <ul>
                        <li>
                            <a href="/logout_do">
                                <span class="blind">로그아웃</span>
                                <i class="fa-solid fa-arrow-right-from-bracket"></i>
                            </a>
                        </li>
                        <li>
                            <a href="/mypage">
                                <span class="blind">회원정보</span>
                                <i class="fa-regular fa-user"></i>
                            </a>
                        </li>
                    </ul>
                </div>
                <% } else { %>
                <% if (session.getAttribute("loggedInUser") != null) { %>
                <div class="login logout">
                    <ul>
                        <li>
                            <a href="/logout_do">
                                <span class="blind">로그아웃</span>
                                <i class="fa-solid fa-arrow-right-from-bracket"></i>
                            </a>
                        </li>
                        <li>
                            <a href="/mypage">
                                <span class="blind">회원정보</span>
                                <i class="fa-regular fa-user"></i>
                            </a>
                        </li>
                    </ul>
                </div>
                <% } else { %>
                <div class="login">
                    <ul>
                        <li>
                            <a href="/login">
                                <span class="blind">로그인</span>
                                <i class="fa-solid fa-user-plus"></i>
                            </a>
                        </li>
                    </ul>
                </div>
                <% } %>
                <% } %>
                <div id="moMenu" onclick="openMenu()">
                    <i class="fa-solid fa-bars"></i>
                </div>
            </div>
        </div>
    </div>
    <nav class="mobile-menu-area">
        <ul>
            <li><a href="/board_list?boardType=notice" class="active">공지사항</a></li>
            <li><a href="/board_list?boardType=inquiry">문의게시판</a></li>
            <li><a href="/board_list?boardType=free">자유게시판</a></li>
            <li><a href="/board_list?boardType=recipe">레시피공유게시판</a></li>
        </ul>
    </nav>
</header>

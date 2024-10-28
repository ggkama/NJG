<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="tit">고객센터</div>
<ul>
    <li><a href="/board_list?boardType=notice" class="active">공지사항</a></li>
    <li><a href="/board_list?boardType=inquiry">문의게시판</a></li>
    <li><a href="/board_list?boardType=free">자유게시판</a></li>
    <li><a href="/board_list?boardType=recipe">레시피공유게시판</a></li>
</ul>
<script>
    var links = document.querySelectorAll('.boardLt li a');

    links.forEach(function(link){
        var current = window.location.pathname + window.location.search;
        var linkHref = link.getAttribute('href');  // Use getAttribute() instead of attribute()

        link.classList.remove('active');

        if (current === linkHref) {
            link.classList.add('active');
        }
    });
</script>
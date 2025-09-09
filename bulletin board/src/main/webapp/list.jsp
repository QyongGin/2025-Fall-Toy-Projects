<%--
  Created by IntelliJ IDEA.
  User: gim-yongjin
  Date: 2025. 9. 4.
  Time: 오후 8:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.bulletinboard.dao.BoardDAO" %>
<%@ page import="com.example.bulletinboard.dto.BoardDTO" %>
<%@ page import="java.util.ArrayList" %>

<%--
     이 부분은 스크립틀릿(Scriptlet)이다. JSP 파일 안에서 Java 코드를 실행하는 영역.
     여기서 BoardDAO를 사용해 DB에서 게시글 목록을 가져온다.
--%>
<%
    // BoardDAO 객체 생성
    BoardDAO dao = new BoardDAO();
    // getList() 메소드를 호출하여 모든 게시글 목록을 ArrayList<BoardDTO> 형태로 받아옴
    ArrayList<BoardDTO> list = dao.getList();
%>
<html>
<head>
    <title>게시판 목록</title>
    <%-- CSS 스타일 정의 --%>
    <link rel="stylesheet" href="board.css"></link>
</head>
<body>
    <div class="board-container">
    <h1>게시판</h1>
    <table class="board-table">
        <thead>
            <tr>
                <th class="col-bno">번호</th>
                <th class="col-title">제목</th>
                <th class="col-writer">작성자</th>
                <th class="col-regdate">작성일</th>
            </tr>
        </thead>
        <tbody>
            <% for (BoardDTO dto : list) { %>
                <tr>
                    <td class="col-bno"><%= dto.getBno() %></td>
                    <td class="col-title"><%= dto.getTitle() %></td>
                    <td class="col-writer"><%= dto.getWriter()%></td>
                    <td class="col-regdate"><%= dto.getRegdate()%></td>
                </tr>
            <% } %>
        </tbody>
    </table>
        <div class="btn-container">
            <a href="write.jsp" class="write-btn">글작성</a>
        </div>
    </div>
</body>
</html>

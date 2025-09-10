<%--
  Created by IntelliJ IDEA.
  User: gim-yongjin
  Date: 2025. 9. 10.
  Time: 오전 7:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>write.jsp 처리</title>
</head>
<body>
    <%@ page import="java.sql.*" %>
    <%
        // POST 요청의 한글 처리
        request.setCharacterEncoding("UTF-8");

        // 폼에서 전송된 데이터 받기
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String writer = request.getParameter("writer");

        // DB 연결 정보
        String url = "jdbc:mysql://localhost:3306/jsp_board";
        String username = "board_user";
        String password = "ritepa64";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);

            String sql = "INSERT INTO board (title, content, writer) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setString(3, writer);

            pstmt.executeUpdate();

            pstmt.close();
            conn.close();
    %>

            <script>
                alert("글이 등록되었습니다.");
                location.href = "list.jsp";
            </script>
    <%
        } catch(Exception e) {
            e.printStackTrace(); // 서버 로그에 에러 출력
    %>
            <script>
                alert("글 등록에 실패했습니다: " + "<%=e.getMessage()%>");
                history.back();
            </script>
    <%
        }
    %>
</body>
</html>


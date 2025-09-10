<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 수정 처리</title>
</head>
<body>
    <%@ page import="java.sql.*" %>
    <%
        // POST 요청의 한글 처리
        request.setCharacterEncoding("UTF-8");

        // 폼에서 전송된 데이터 받기
        int bno = Integer.parseInt(request.getParameter("bno"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        // DB 연결 정보
        String url = "jdbc:mysql://localhost:3306/jsp_board";
        String username = "board_user";
        String password = "ritepa64";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);

            String sql = "UPDATE board SET title = ?, content = ? WHERE bno = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setInt(3, bno);

            pstmt.executeUpdate();

            pstmt.close();
            conn.close();
    %>
            <script>
                alert("게시글이 수정되었습니다.");
                location.href = "view.jsp?bno=<%= bno %>";
            </script>
    <%
        } catch(Exception e) {
    %>
            <script>
                alert("게시글 수정에 실패했습니다.");
                history.back();
            </script>
    <%
        }
    %>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 삭제 처리</title>
</head>
<body>
    <%@ page import="java.sql.*" %>
    <%
        // GET으로 전달된 게시글 번호
        int bno = Integer.parseInt(request.getParameter("bno"));

        // DB 연결 정보
        String url = "jdbc:mysql://localhost:3306/jsp_board";
        String username = "board_user";
        String password = "ritepa64";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);

            String sql = "DELETE FROM board WHERE bno = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bno);

            pstmt.executeUpdate();

            pstmt.close();
            conn.close();
    %>
            <script>
                alert("게시글이 삭제되었습니다.");
                location.href = "list.jsp";
            </script>
    <%
        } catch(Exception e) {
    %>
            <script>
                alert("게시글 삭제에 실패했습니다.");
                history.back();
            </script>
    <%
        }
    %>
</body>
</html>

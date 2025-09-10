<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 상세보기</title>
    <link rel="stylesheet" href="board.css">
</head>
<body>
    <%@ page import="java.sql.*" %>
    <%
        // GET 방식으로 전달된 게시글 번호(bno) 받기
        int bno = Integer.parseInt(request.getParameter("bno"));

        // DB 연결 정보
        String url = "jdbc:mysql://localhost:3306/jsp_board";
        String username = "board_user";
        String password = "ritepa64";

        // 게시글 정보를 담을 변수들
        String title = "";
        String content = "";
        String writer = "";
        String regDate = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);

            // 해당 게시글 조회
            String sql = "SELECT * FROM board WHERE bno = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bno);

            ResultSet rs = pstmt.executeQuery();

            if(rs.next()) {
                title = rs.getString("title");
                content = rs.getString("content");
                writer = rs.getString("writer");
                regDate = rs.getString("reg_date");
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    %>

    <div class="container">
        <h2>게시글 상세보기</h2>
        <div class="board-view">
            <div class="view-header">
                <h3><%=title%></h3>
                <div class="view-info">
                    <span>작성자: <%=writer%></span>
                    <span>작성일: <%=regDate%></span>
                </div>
            </div>
            <div class="view-content">
                <%=content%>
            </div>
            <div class="button-group">
                <button onclick="location.href='list.jsp'">목록</button>
                <button onclick="location.href='modify.jsp?bno=<%=bno%>'">수정</button>
                <button onclick="deletePost(<%=bno%>)">삭제</button>
            </div>
        </div>
    </div>

    <script>
        function deletePost(bno) {
            if(confirm('정말로 삭제하시겠습니까?')) {
                location.href = 'deleteAction.jsp?bno=' + bno;
            }
        }
    </script>
</body>
</html>

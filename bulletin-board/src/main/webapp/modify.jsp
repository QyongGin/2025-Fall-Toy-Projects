<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 수정</title>
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

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);

            String sql = "SELECT * FROM board WHERE bno = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bno);

            ResultSet rs = pstmt.executeQuery();

            if(rs.next()) {
                title = rs.getString("title");
                content = rs.getString("content");
                writer = rs.getString("writer");
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    %>

    <div class="container">
        <h2>게시글 수정</h2>
        <form action="modifyAction.jsp" method="post">
            <input type="hidden" name="bno" value="<%=bno%>">
            <div class="form-group">
                <label>제목</label>
                <input type="text" name="title" value="<%=title%>" required>
            </div>
            <div class="form-group">
                <label>작성자</label>
                <input type="text" name="writer" value="<%=writer%>" readonly>
            </div>
            <div class="form-group">
                <label>내용</label>
                <textarea name="content" required><%=content%></textarea>
            </div>
            <div class="button-group">
                <button type="submit">수정</button>
                <button type="button" onclick="history.back()">취소</button>
            </div>
        </form>
    </div>
</body>
</html>


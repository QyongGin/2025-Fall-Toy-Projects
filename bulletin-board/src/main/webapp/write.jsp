<%--
  Created by IntelliJ IDEA.
  User: gim-yongjin
  Date: 2025. 9. 9.
  Time: 오후 7:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>글 작성</title>
    <link rel="stylesheet" href="board.css">
</head>
<body>
    <div class="board-container">
        <h1>글 작성</h1>
        <form action="writeAction.jsp" method="POST">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" class="form-input" required placeholder="제목을 입력하세요.">
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content"
                          name="content"
                          class="form-input"
                          required
                          placeholder="내용을 입력하세요"></textarea>
            </div>

            <div class="form-group">
                <label for="writer">작성자</label>
                <input type="text"
                       id="writer"
                       name="writer"
                       class="form-input"
                       required
                       placeholder="작성자명을 입력해 주세요.">
            </div>

            <div class="btn-group">
                <button type="submit" class="btn-submit" >등록</button>
                <button type="button"
                        class="btn-cancel"
                        onclick="location.href='list.jsp'">취소</button>
            </div>
        </form>
    </div>
</body>
</html>

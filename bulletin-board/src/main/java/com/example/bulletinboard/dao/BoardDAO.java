package com.example.bulletinboard.dao;

// 다른 패키지에 있는 클래스 가져오기 위해 import 사용
import com.example.bulletinboard.dto.BoardDTO;
// import java.sql.*; 로 축약 가능
import java.sql.Connection;                      // 데이터베이스 연결을 위한 클래스
import java.sql.DriverManager;                  // JDBC 드라이버를 관리하는 클래스
import java.sql.PreparedStatement;              // SQL 쿼리를 실행하기 위한 클래스
import java.sql.ResultSet;                      // SQL 쿼리 결과를 담는 클래스
import java.util.ArrayList;                     // 여러 개의 DTO 객체를 담기 위한 리스트 클래스


public class BoardDAO {

    // --- 멤버 변수 ---
    // 데이터베이스 연결에 필요한 정보들을 상수(final)로 선언
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver"; // mySQL JDBC 드라이버
    private static final String URL = "jdbc:mysql://localhost:3306/jsp_board"; // DB URL
    private static final String USER = "board_user"; // DB 접속 사용자 ID
    private static final String PASS = "ritepa64"; // DB 접속 비밀번호

    /**
     * DB에 연결하고, 연결된 Connection 객체를 반환하는 메서드
     * @return Connection 객체
     */
    public Connection getConnection() {
        try {
            // MySQL 드라이버를 메모리에 로드
            Class.forName(DRIVER);
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (Exception e) {
            // 예외 발생 시 콘솔에 내용 출력
            e.printStackTrace();
            return null;
        }
    }

    /**
     * board 테이블의 모든 게시글 조회하여 ArrayList<BoardDTO> 형태로 반환하는 메소드
     * @return 게시글 목록
     */

    // ArrayList는 자바에서 가장 많이 쓰는 동적 배열 자료구조로서, 요소가 추가될 때 자동으로 크기가 늘어난다.
    // 인덱스 기반 접근이며 <BoardDTO>처럼 특정 타입만 저장하도록 하는 제네릭을 지원한다.
    // 순차적으로 저장되어 요소들이 삽입된 순서대로 저장됨
    public ArrayList<BoardDTO> getList() {
        // DB 연결, SQL 실행 등에 필요한 객체들 미리 선언
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 여러 개의 BoardDTO 객체를 담을 리스트 생성
        ArrayList<BoardDTO> list = new ArrayList<>();

        try {
            // DB 연결
            conn = getConnection();

            // 실행할 SQL 쿼리 준비
            // bno(게시글 번호)를 기준으로 내림차순(DESC) 정렬하여 최신 글이 위로 오도록 함
            String sql = "SELECT * FROM board ORDER BY bno DESC";
            pstmt = conn.prepareStatement(sql);

            // SQL 쿼리 실행 후 결과를 ResultSet 객체에 담는다.
            rs = pstmt.executeQuery();

            // ResultSet에 데이터가 있는 동안(rs.next()가 true인 동안) 반복
            while (rs.next()) {
                // 한 행(게시글 하나)의 정보를 담을 BoardDTO 객체를 생성
                BoardDTO dto = new BoardDTO();

                // ResultSet에서 각 컬럼의 값을 가져와 DTO 객체의 필드(변수)에 저장
                dto.setBno(rs.getInt("bno")); // bno 컬럼의 int 값 가져옴
                dto.setTitle(rs.getString("title")); // title 컬럼의 String 값 가져옴
                dto.setContent(rs.getString("content")); // content 컬럼의 String 값 가져옴
                dto.setWriter(rs.getString("writer")); // writer 컬럼의 String 값 가져옴
                dto.setRegdate(rs.getString("regdate")); // regdate 컬럼의 String 값 가져옴

                // 완성된 DTO 객체를 ArrayList에 추가
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // finally : 예외 발생 여부와 상관없이 마지막에 반드시 실행되는 블록
            // 사용한 자원 반드시 닫기 (자원 누수 방지)
            // 연 순서의 역순으로 닫는게 일반적 (ResultSet -> PreparedStatement -> Connection)
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // 게시글 정보가 담긴 리스트 반환
        return list;
    }
}

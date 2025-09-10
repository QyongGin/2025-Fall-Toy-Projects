// com.example.bulletinboard.dto 패키지에 속했음을 알림.
package com.example.bulletinboard.dto;

// 밑은 JavaDoc 주석이다.
// 사용 시점
// - 클래스, 메서드, 변수 등에 대한 설명을 제공.
// - JavaDoc 도구를 사용해 HTML 문서로 변환 가능.
// - 코드의 가독성과 유지보수성을 높이기 위해 사용.

//  API 문서 생성: 라이브러리나 프레임워크를 개발할 때 다른 개발자들이 사용할 수 있도록 문서화
//  팀 협업: 팀원들이 코드를 이해하기 쉽도록 클래스와 메소드의 목적, 사용법 설명
//  유지보수: 미래의 개발자(본인 포함)가 코드를 이해하기 쉽게 함
//  주로 설명하는 내용
//  클래스 수준: 클래스의 전반적인 목적과 용도
//  메소드 수준:
//  메소드가 하는 일
//  매개변수 설명(@param)
//  반환값 설명(@return)
//  발생 가능한 예외(@throws)
//  필드 수준: 중요 변수의 의미와 역할
//  이런 문서화는 IDE에서 코드 작성 시 팝업 도움말로 표시되고, 공식 API 문서로 변환되어 개발자들의 이해를 돕습니다.
/**
 * DTO(Data Transfer Object)란?
 * - 계층 간 데이터 교환을 위한 객체.
 * - 주로 데이터베이스에서 데이터를 가져오거나, 클라이언트로부터 데이터를 받을 때 사용.
 * - 일반적으로 getter와 setter 메서드만 포함하며 비즈니스 로직은 포함하지 않음.
 * - DB의 board 테이블에 있는 한 행의 데이터를
 * - Java 객체 형태로 옮겨 담기 위한 '데이터 상자' 역할을 한다.
*/
public class BoardDTO { // 객체를 생성하기 위한 설계도(class)

    // 멤버 변수 (Fields)
    // 'board' 테이블의 각 컬럼과 1:1로 대응
    // private 접근 제어자를 사용해 외부 클래스에서 직접 이 변수들에 대한 접근을 막는다. (캡슐화)

    private int bno;            // 게시글 번호 (Primary Key)
    private String title;      // 게시글 제목
    private String content;    // 게시글 내용
    private String writer;     // 게시글 작성자
    private String regdate;    // 게시글 작성일자

    // 메소드 (Methods)
    // private로 선언된 멤버 변수에 값을 넣거나(setter), 값을 가져오기(getter) 위한 '통로' 역할

    /**
     * bno 변수의 값을 반환하는 Getter 메소드
     * @return 게시글 번호
     */
    public int getBno() {
        return bno;
    }

    /**
     * bno 변수의 값을 설정하는 Setter 메소드
     * @param bno 저장할 게시글 번호
     */
    public void setBno(int bno) {
        this.bno = bno;
    }

    public String getTitle() {
        return title;
    }

    public void  setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }
}

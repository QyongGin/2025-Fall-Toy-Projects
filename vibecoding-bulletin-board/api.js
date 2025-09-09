
// 브라우저가 보내는 요청을 UI에서 받고 -> MySQL에 질의한다. -> 결과를 JSON으로 돌려주는 '작은 웹서버(Express)'

// 필수 라이브러리 불러오기 
const express = require('express'); // 웹 서버 프레임워크. express 모듈을 가져오고 반환값은 함수.
const mysql = require('mysql2'); // MySQL과 대화하는 드라이버 객체를 가져옴.(여러 함수가 든 객체)
const app = express(); // express()함수를 호출해 앱 인스턴스 생성. 요청을 처리하는 함수로 메서드(use/get...)를 가진 객체.

// JSON 형식의 요청 본문을 파싱할 수 있도록 설정
// 프론트엔드에서 데이터를 보낼 때 json 형식으로 보내면 서버가 읽는다.
app.use(express.json());
// 정적 파일(public 폴더)을 웹으로 제공
app.use(express.static('public'));

// 데이터베이스 연결 
const db = mysql.createConnection({
  host: 'localhost',       // DB 서버 주소 (내 컴퓨터에서 돌리니 localhost)
  user: 'root',            
  password: 'ritepa64', 
  database: 'bulletin_board' 
});

// 데이터베이스 연결 시도
db.connect(err => {
  if (err) {
    console.error('연결 오류:', err);
    return;
  }
  console.log('데이터베이스에 성공적으로 연결되었습니다.');
});


/*
 * ========================================
 * 게시판 API 엔드포인트 (Endpoints)
 * ========================================
 */

// [GET] /posts - 모든 게시글 목록 조회
app.get('/posts', (req, res) => {
  const sql = 'SELECT * FROM posts ORDER BY created_at DESC';
  db.query(sql, (err, rows) => {
    if (err) return res.status(500).send(err);
    res.json(rows);
  });
});

// [POST] /posts - 새 게시글 작성
app.post('/posts', (req, res) => {
  const { title, content } = req.body;
  const user_id = Number(req.body.user_id) || 1; // 임시 사용자
  if (!title || !content) return res.status(400).send('title, content가 필요합니다.');

  const sql = 'INSERT INTO posts (title, content, user_id) VALUES (?, ?, ?)';
  db.query(sql, [title, content, user_id], (err, result) => {
    if (err) return res.status(500).send(err);
    res.status(201).json({ id: result.insertId, title, content, user_id });
  });
});

// [GET] /posts/:id - 특정 게시글 상세 조회
app.get('/posts/:id', (req, res) => {
  const id = Number(req.params.id);
  if (!Number.isInteger(id)) return res.status(400).send('잘못된 id');

  const sql = 'SELECT * FROM posts WHERE id = ?';
  db.query(sql, [id], (err, rows) => {
    if (err) return res.status(500).send(err);
    if (!rows || rows.length === 0) return res.status(404).send('게시글을 찾을 수 없습니다.');
    res.json(rows[0]);
  });
});

// [PUT] /posts/:id - 특정 게시글 수정
app.put('/posts/:id', (req, res) => {
  const id = Number(req.params.id);
  const { title, content } = req.body;
  if (!Number.isInteger(id)) return res.status(400).send('잘못된 id');
  if (!title || !content) return res.status(400).send('title, content가 필요합니다.');

  const sql = 'UPDATE posts SET title = ?, content = ? WHERE id = ?';
  db.query(sql, [title, content, id], (err, result) => {
    if (err) return res.status(500).send(err);
    if (result.affectedRows === 0) return res.status(404).send('게시글을 찾을 수 없습니다.');
    res.send('게시글이 성공적으로 수정되었습니다.');
  });
});

// [DELETE] /posts/:id - 특정 게시글 삭제
app.delete('/posts/:id', (req, res) => {
  const id = Number(req.params.id);
  if (!Number.isInteger(id)) return res.status(400).send('잘못된 id');

  const sql = 'DELETE FROM posts WHERE id = ?';
  db.query(sql, [id], (err, result) => {
    if (err) return res.status(500).send(err);
    if (result.affectedRows === 0) return res.status(404).send('게시글을 찾을 수 없습니다.');
    res.send('게시글이 성공적으로 삭제되었습니다.');
  });
});

// 서버 시작
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`서버가 http://localhost:${PORT} 에서 실행 중입니다.`);
});


// CREATE TABLE `posts` (
//   `id` int NOT NULL AUTO_INCREMENT,
//   `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
//   `content` text COLLATE utf8mb4_unicode_ci,
//   `user_id` int NOT NULL,
//   `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
//   PRIMARY KEY (`id`),
//   KEY `user_id` (`user_id`),
//   CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
// ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
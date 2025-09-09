// filepath: /Users/gim-yongjin/Project/Todo/public/app.js
document.addEventListener('DOMContentLoaded', () => {
  let editingId = null; // null이면 새 글, 숫자면 수정
  const listBody = document.getElementById('listBody');
  const vList = document.getElementById('view-list');
  const vDetail = document.getElementById('view-detail');
  const vForm = document.getElementById('view-form');
  const postForm = document.getElementById('postForm');

  // 네비게이션
  document.getElementById('btnList').onclick = () => { editingId = null; showList(); };
  document.getElementById('btnWrite').onclick = () => { editingId = null; showForm(); };
  document.getElementById('d-back').onclick = () => showList();

  document.getElementById('d-edit').onclick = async () => {
    const id = vDetail.dataset.id;
    if (!id) return;
    const p = await fetchJson(`/posts/${id}`);
    editingId = Number(id);
    showForm(p);
  };

  document.getElementById('d-delete').onclick = async () => {
    const id = vDetail.dataset.id;
    if (!id) return;
    if (!confirm('정말 삭제하시겠습니까?')) return;
    const res = await fetch(`/posts/${id}`, { method: 'DELETE' });
    if (!res.ok) return alert('삭제 실패');
    showList();
  };

  // 작성/수정 제출
  postForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const fd = new FormData(postForm);
    const body = { title: fd.get('title'), content: fd.get('content') };

    let ok = false;
    if (editingId == null) {
      body.user_id = 1; // 임시 사용자
      const res = await fetch('/posts', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body)
      });
      ok = res.ok;
    } else {
      const res = await fetch(`/posts/${editingId}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body)
      });
      ok = res.ok;
    }

    if (!ok) return alert('저장 실패');
    editingId = null;
    showList();
  });

  document.getElementById('form-cancel').onclick = () => { editingId = null; showList(); };

  // 목록 로드/표시
  async function loadPosts() {
    const items = await fetchJson('/posts');
    listBody.innerHTML = items.map(p => {
      const d = formatDate(p.created_at);
      return `<tr>
        <td>${p.id}</td>
        <td><a href="#" data-id="${p.id}" class="lnk-view">${escapeHtml(p.title)}</a></td>
        <td>${d}</td>
        <td class="actions">
          <button data-id="${p.id}" class="btn btn-ghost btn-view">열람</button>
          <button data-id="${p.id}" class="btn btn-view btn-edit">수정</button>
          <button data-id="${p.id}" class="btn btn-danger btn-del">삭제</button>
        </td>
      </tr>`;
    }).join('');

    listBody.querySelectorAll('.lnk-view,.btn-view').forEach(el => el.onclick = (e) => {
      e.preventDefault();
      const id = e.currentTarget.dataset.id;
      showDetail(id);
    });
    listBody.querySelectorAll('.btn-edit').forEach(el => el.onclick = async (e) => {
      const id = e.currentTarget.dataset.id;
      const p = await fetchJson(`/posts/${id}`);
      editingId = Number(id);
      showForm(p);
    });
    listBody.querySelectorAll('.btn-del').forEach(el => el.onclick = async (e) => {
      const id = e.currentTarget.dataset.id;
      if (!confirm('정말 삭제하시겠습니까?')) return;
      const res = await fetch(`/posts/${id}`, { method: 'DELETE' });
      if (!res.ok) return alert('삭제 실패');
      loadPosts();
    });
  }

  function showList() {
    showOnly(vList); loadPosts();
  }

  async function showDetail(id) {
    const p = await fetchJson(`/posts/${id}`);
    vDetail.dataset.id = id;
    document.getElementById('d-title').textContent = p.title;
    document.getElementById('d-meta').textContent = `번호 ${p.id} · ${formatDate(p.created_at)}`;
    document.getElementById('d-content').textContent = p.content || '';
    showOnly(vDetail);
  }

  function showForm(p = { title:'', content:'' }) {
    postForm.title.value = p.title || '';
    postForm.content.value = p.content || '';
    document.getElementById('form-title').textContent = editingId == null ? '글쓰기' : `글 수정 (#${editingId})`;
    showOnly(vForm);
  }

  function showOnly(section) {
    [vList, vDetail, vForm].forEach(el => el.classList.add('hidden'));
    section.classList.remove('hidden');
  }

  // 유틸
  async function fetchJson(url, opts) {
    const res = await fetch(url, opts);
    if (!res.ok) throw new Error('요청 실패');
    return res.json();
  }
  function escapeHtml(s='') {
    return String(s).replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
  }
  function formatDate(v) {
    try { return new Date(v).toLocaleString('ko-KR'); } catch { return v ?? ''; }
  }

  // 초기 진입
  showList();
});
// Student Information Management System Client Controller
// Author: Albar Rahman A

function switchTab(tab) {
  const loginTab = document.getElementById('tabLogin');
  const registerTab = document.getElementById('tabRegister');
  const roleGroup = document.getElementById('roleGroup');
  const submitBtn = document.getElementById('submitBtn');

  if (tab === 'register') {
    loginTab.classList.remove('active');
    registerTab.classList.add('active');
    roleGroup.style.display = 'block';
    submitBtn.innerText = 'Register for Portal';
  } else {
    registerTab.classList.remove('active');
    loginTab.classList.add('active');
    roleGroup.style.display = 'none';
    submitBtn.innerText = 'Login to Portal';
  }
}

function handleAuth(e) {
  e.preventDefault();
  const username = document.getElementById('username').value.trim();

  if (username.toLowerCase().includes('staff')) {
    window.location.href = 'staff-dashboard.html';
  } else {
    window.location.href = 'student-dashboard.html';
  }
}

function openModal(modalId) {
  alert('Action opened: ' + modalId + '\nConnect to backend REST API or MySQL to manage live data.');
}

function editStudent(id) {
  alert('Editing student record for: ' + id);
}
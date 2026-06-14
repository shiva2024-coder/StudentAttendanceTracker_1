/* ============================================================
   Student Attendance Tracker – Main JavaScript
   ============================================================ */

// ── Auto-dismiss alert messages after 4 seconds ────────────
document.addEventListener('DOMContentLoaded', function () {

    // Auto hide alerts
    const alerts = document.querySelectorAll('.alert[data-auto-hide]');
    alerts.forEach(function (alert) {
        setTimeout(function () {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity    = '0';
            setTimeout(function () { alert.remove(); }, 500);
        }, 4000);
    });

    // Mark active nav link
    const currentPage = window.location.pathname.split('/').pop();
    document.querySelectorAll('nav a').forEach(function (link) {
        if (link.getAttribute('href') === currentPage) {
            link.classList.add('active');
        }
    });

    // Animate progress bars on report page
    document.querySelectorAll('.progress-bar-fill').forEach(function (bar) {
        const target = bar.getAttribute('data-width') || '0';
        bar.style.width = '0%';
        requestAnimationFrame(function () {
            requestAnimationFrame(function () {
                bar.style.width = target + '%';
            });
        });
    });
});

// ── Confirm before deleting a student ──────────────────────
function confirmDelete(studentId, studentName) {
    return confirm('Are you sure you want to delete student "' + studentName + '" (ID: ' + studentId + ')?\n\nThis will also delete all attendance records for this student.');
}

// ── Select All Present / Absent on Mark Attendance page ────
function selectAll(status) {
    const radios = document.querySelectorAll('input[type="radio"][value="' + status + '"]');
    radios.forEach(function (r) { r.checked = true; });
}

// ── Form validation for Add / Edit Student ─────────────────
function validateStudentForm() {
    const id   = document.getElementById('studentId');
    const name = document.getElementById('studentName');
    const dept = document.getElementById('department');

    if (id && id.value.trim() === '') {
        showInlineError(id, 'Student ID is required.');
        return false;
    }
    if (name && name.value.trim() === '') {
        showInlineError(name, 'Student Name is required.');
        return false;
    }
    if (dept && dept.value.trim() === '') {
        showInlineError(dept, 'Department is required.');
        return false;
    }
    return true;
}

function showInlineError(input, message) {
    input.focus();
    input.style.borderColor = '#ea4335';
    let err = input.parentElement.querySelector('.inline-error');
    if (!err) {
        err = document.createElement('p');
        err.className = 'inline-error';
        err.style.cssText = 'color:#ea4335;font-size:0.8rem;margin-top:4px;';
        input.parentElement.appendChild(err);
    }
    err.textContent = message;
    input.addEventListener('input', function () {
        input.style.borderColor = '';
        if (err) err.remove();
    }, { once: true });
}

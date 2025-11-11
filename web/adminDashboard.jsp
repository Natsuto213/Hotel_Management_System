<%@page import="model.Staff"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard Preview</title>
        <link rel="stylesheet" href="css/adminDashboardStyle.css"/>

        <style>
            /* --- CSS cho Toolbar B?ng --- */
            /* --- CSS cho Toolbar B?ng (?? c?p nh?t) --- */
            .table-toolbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .search-form {
                display: flex;
            }

            .search-form input[type="text"] {
                padding: 14px 18px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 4px;
                outline: none;
                /* --- C?P NH?T: T?ng ?? r?ng ? ??y --- */
                min-width: 650px;
                margin-right: 10px;
            }

            .search-form button {
                padding: 8px 12px;
                font-size: 14px;
                /* --- C?P NH?T: ??i sang m?u t?m --- */
                border: 1px solid #6f42c1;
                background-color: #6f42c1; /* M? m?u t?m */
                color: white;
                cursor: pointer;
                border-radius: 4px;
                margin-left: -1px;
            }

            .search-form button:hover {
                /* --- C?P NH?T: ??i sang m?u t?m ??m h?n --- */
                background-color: #59369a;
                border-color: #59369a;
            }

            .table-toolbar .add-button {
                margin: 0;
            }

            /* * =========================================
             * MODIFIED: Th?m style cho n?t "Add New Staff"
             * =========================================
            */
            .add-button {
                display: inline-block;
                padding: 8px 16px;
                font-size: 14px;
                font-weight: 600;
                color: #fff;
                background-color: #198754; /* M?u xanh l? cho "Add" */
                border: 1px solid #198754;
                border-radius: 4px;
                text-decoration: none;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            .add-button:hover {
                background-color: #157347; /* M?u xanh l? ??m h?n khi hover */
            }

            /* === CSS C?P NH?T CHO PH?N TAX === */

            /* S?a l?i .tax c? th?nh m?t card ri?ng bi?t */
            .tax {
                text-align: center;
                max-width: 500px; /* Gi?i h?n chi?u r?ng */
                margin: 20px auto 25px auto; /* C?n gi?a v? t?o kho?ng c?ch */
                padding: 25px 30px; /* T?ng kho?ng c?ch b?n trong */
                background-color: #fff; /* N?n tr?ng */
                border-radius: 8px; /* Bo g?c */
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); /* Th?m b?ng ?? nh? */
            }

            /* Style cho H2 b?n trong tax */
            .tax h2 {
                color: #6f42c1; /* M?u t?m ch? ??o (gi?ng search) */
                margin-top: 0;
                margin-bottom: 20px;
                font-size: 1.5rem; /* 24px */
            }

            /* Style cho form b?n trong tax (d?ng flexbox ?? c?n ch?nh) */
            .tax form {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px; /* Kho?ng c?ch gi?a input v? button */
            }

            /* Style cho input b?n trong tax */
            .tax input[type="number"] {
                padding: 10px 15px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-family: inherit;
                width: 200px; /* Cho chi?u r?ng c? ??nh */
            }

            /* Style cho button b?n trong tax (gi?ng n?t .add-button) */
            .tax button {
                padding: 10px 18px;
                font-size: 14px;
                font-weight: 600;
                color: #fff;
                background-color: #198754; /* M?u xanh l? (Update) */
                border: 1px solid #198754;
                border-radius: 4px;
                text-decoration: none;
                cursor: pointer;
                transition: background-color 0.2s ease;
                text-transform: capitalize; /* Vi?t hoa ch? ??u: "Update tax" */
            }

            /* Hi?u ?ng hover cho button */
            .tax button:hover {
                background-color: #157347; /* M?u xanh l? ??m h?n */
            }

        </style>
    </head>
    <body>
        <%
            Staff admin = (Staff) request.getAttribute("admin");
        %>
        <div class="header">
            <div class="admin-info">
                <% if (admin != null) {%>
                Welcome, <strong><%= admin.getFullname()%></strong> (<%= admin.getRole()%>)
                <% } else { %>
                Welcome, Admin
                <% }%>
            </div>
            <div class="header-actions">

                <a href="MainController?action=logoutUser">Logout</a>
            </div>
        </div>

        <div class="tax">
            <h2>Current tax: <fmt:formatNumber value="${requestScope.tax * 100}" type="number" groupingUsed="true" maxFractionDigits="0"/>%</h2>
            <form action="MainController" method="post">
                <input type="number" name="newTax" min="0" placeholder="Enter new tax (%)">
                <button type="submit" name="action" value="updateTax">update tax</button>
            </form>
        </div>

        <div class="container">
            <div class="card">
                <h2>Staff Management</h2>

                <div class="table-toolbar">
                    <form action="SearchStaffController" method="GET" class="search-form">
                        <input type="text" 
                               name="txtSearch" 
                               placeholder="Search staff by name ..." 
                               value="<%= (request.getAttribute("lastSearch") != null) ? (String) request.getAttribute("lastSearch") : ""%>"
                               >                        <button type="submit">Search</button>
                    </form>
                    <a class="add-button" id="addStaffBtn">Add New Staff</a>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Staff> staffs = (ArrayList<Staff>) request.getAttribute("staffs");
                            if (staffs != null && !staffs.isEmpty()) {
                                for (Staff staff : staffs) {
                        %>
                        <tr>
                            <td><%= staff.getStaffID()%></td>
                            <td><%= staff.getFullname()%></td>
                            <td><%= staff.getUsername()%></td>
                            <td><%= staff.getEmail()%></td>
                            <td><%= staff.getPhone()%></td>
                            <td><%= staff.getRole()%></td>
                            <td class="action-links">
                                <a class="edit-link" 
                                   data-id="<%= staff.getStaffID()%>"
                                   data-fullname="<%= staff.getFullname()%>"
                                   data-username="<%= staff.getUsername()%>"
                                   data-email="<%= staff.getEmail()%>"
                                   data-phone="<%= staff.getPhone()%>"
                                   data-role="<%= staff.getRole()%>">Edit</a>
                                <a class="delete-link" data-id="<%= staff.getStaffID()%>" data-name="<%= staff.getFullname()%>">Delete</a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="7" style="text-align: center;">No staff members found.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="staffModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="close">&times;</span>
                    <h2 id="modalTitle">Add Staff</h2>
                </div>
                <form id="staffForm" method="POST">
                    <div class="modal-body">
                        <input type="hidden" id="staffId" name="staffId">
                        <div class="form-group">
                            <label for="fullName">Full Name</label>
                            <input type="text" id="fullName" name="fullName" required>
                        </div>
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <input type="text" id="phone" name="phone" required>
                        </div>
                        <div class="form-group">
                            <label for="role">Role</label>
                            <input type="text" id="role" name="role" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>

        <div id="deleteModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="close" id="closeDelete">&times;</span>
                    <h2>Confirm Deletion</h2>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete staff member <strong id="staffNameToDelete"></strong>?</p>
                </div>
                <div class="modal-footer">
                    <a href="#" class="btn btn-danger" id="confirmDeleteLink">Delete</a>
                    <a class="btn btn-secondary" id="cancelDelete">Cancel</a>
                </div>
            </div>
        </div>

        <script>
            // Get modals
            var staffModal = document.getElementById("staffModal");
            var deleteModal = document.getElementById("deleteModal");

            // Get close buttons
            var closeButtons = document.getElementsByClassName("close");

            // Get form and elements
            var staffForm = document.getElementById("staffForm");
            var modalTitle = document.getElementById("modalTitle");
            var staffIdInput = document.getElementById("staffId");
            var fullNameInput = document.getElementById("fullName");
            var usernameInput = document.getElementById("username");
            var passwordInput = document.getElementById("password");
            var emailInput = document.getElementById("email");
            var phoneInput = document.getElementById("phone");
            var roleInput = document.getElementById("role");

            // --- Event Listeners ---

            // Open Add modal
            document.getElementById("addStaffBtn").onclick = function () {
                staffForm.reset();
                staffForm.action = './AddStaffController';
                modalTitle.textContent = "Add New Staff";
                passwordInput.required = true;
                staffIdInput.value = "";
                staffModal.style.display = "block";
            }

            // Open Edit modal
            document.querySelectorAll('.edit-link').forEach(function (button) {
                button.onclick = function () {
                    staffForm.reset();
                    staffForm.action = './EditStaffController';
                    modalTitle.textContent = "Update Staff";

                    // Populate form
                    staffIdInput.value = this.dataset.id;
                    fullNameInput.value = this.dataset.fullname;
                    usernameInput.value = this.dataset.username;
                    emailInput.value = this.dataset.email;
                    phoneInput.value = this.dataset.phone;
                    roleInput.value = this.dataset.role;

                    // Password is not pre-filled for security, but can be updated.
                    passwordInput.placeholder = "Leave blank to keep current password";
                    passwordInput.required = false;

                    staffModal.style.display = "block";
                }
            });

            // Open Delete modal
            document.querySelectorAll('.delete-link').forEach(function (button) {
                button.onclick = function () {
                    var staffId = this.dataset.id;
                    var staffName = this.dataset.name;
                    document.getElementById('staffNameToDelete').textContent = staffName;
                    document.getElementById('confirmDeleteLink').href = '<%= request.getContextPath()%>/DeleteController?staffId=' + staffId;
                    deleteModal.style.display = "block";
                }
            });

            // Cancel delete
            document.getElementById('cancelDelete').onclick = function () {
                deleteModal.style.display = "none";
            }

            // Close modals with close button
            for (var i = 0; i < closeButtons.length; i++) {
                closeButtons[i].onclick = function () {
                    this.closest('.modal').style.display = "none";
                }
            }

            // Close modals when clicking outside
            window.onclick = function (event) {
                if (event.target == staffModal) {
                    staffModal.style.display = "none";
                }
                if (event.target == deleteModal) {
                    deleteModal.style.display = "none";
                }
            }
        </script>

    </body>
</html>


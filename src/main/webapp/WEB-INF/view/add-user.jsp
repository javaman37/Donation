<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add User </title>
</head>
<body>

	<!-- ------------------------------------------------------------------ Modal add --------------------------------------------------------- -->
	<div class="modal fade" id="exampleModalAdd" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="exampleModalLabelll">Thêm mới</h3>
				</div>
				<div class="modal-body">
					<form:form action="saveUser" modelAttribute="user" method="post">
						<div class="row">
							<div class="col-6">
								<label for="addname" class="col-form-label">Họ và tên:</label> <input
									type="text" class="form-control" id="addname" name="fullName"
									required>
							</div>
							<div class="col-6">
								<label for="addcost" class="col-form-label">Email:</label> <input
									type="email" class="form-control" id="addcost" name="email"
									required>
							</div>
						</div>
						<div class="row">
							<div class="col-6">
								<label for="addname" class="col-form-label">Số điện
									thoại:</label> <input type="number" class="form-control" id="addname"
									name="phoneNumber" required>
							</div>
							<div class="col-6">
								<label for="addcost" class="col-form-label">Địa chỉ:</label> <input
									type="text" class="form-control" id="addcost" name="address"
									required>
							</div>
						</div>
						<div class="row">
							<div class="col-6">
								<label for="addname" class="col-form-label">Tài khoản:</label> <input
									type="text" class="form-control" id="addname" name="userName"
									required>
							</div>
							<div class="col-6">
								<label for="addcost" class="col-form-label">Mật khẩu:</label> <input
									type="password" class="form-control" id="addcost"
									name="password" required>
							</div>
							<div class="col-6">
								<label for="addcost" class="col-form-label">Ghi chú:</label> <input
									type="text" class="form-control" id="addcost" name="note"
									required>
							</div>
							<div class="col-6">
								<label for="ct_id" class="col-form-label">Vai trò:</label> <select
									class="form-control" id="role" name="role" required>
									<option value="1" selected>ADMIN</option>
									<option value="2">USER</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Đóng</button>
							<button type="submit" class="btn btn-primary">Thêm</button>
						</div>
					</form:form>
				</div>

			</div>
		</div>
	</div>
	<!-- ------------------------------------------------------------------ End Modal Add ------------------------------------------------------------------ -->

</body>
</html>
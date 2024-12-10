<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Insert title here</title>
</head>
<body>

	<!-- ------------------------------------------------------------------ Modal Update ------------------------------------------------------------------ -->
	<div class="modal fade" id="exampleModal${tempUser.id}" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg ">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="exampleModalLabell">Cập nhật</h3>
					
				</div>
				<div class="modal-body">
					<form:form modelAttribute="user" action="saveUpdateUser" method="POST">
						<input type="hidden" class="form-control" id="id" name="id"
							value="${tempUser.id}">
						<div class="row">
							<div class="col-6">
								<label for="addname" class="col-form-label">Họ và tên:</label> <input
									type="text" class="form-control" id="addname" name="fullName"
									value="${tempUser.fullName}" required>
							</div>
							
							<div class="col-6">
								<label for="addcost" class="col-form-label">Email:</label> 
								<input readonly type="email" class="form-control" id="addcost"
									name="email" value="${tempUser.email}" required>
							</div>
							
						</div>
						<div class="row">
							<div class="col-6">
								<label for="addname" class="col-form-label">Số điện
									thoại:</label> <input type="number" class="form-control" id="addname"
									name="phoneNumber" value="${tempUser.phoneNumber}" required>
							</div>
							<div class="col-6">
								<label for="addcost" class="col-form-label">Địa chỉ:</label> <input
									type="text" class="form-control" id="addcost" name="address"
									value="${tempUser.address}" required>
							</div>
						</div>
						<div class="row">
							<div class="col-6">
								<label for="addname" class="col-form-label">Tài khoản:</label> <input
									readonly type="text" class="form-control" id="addname"
									name="userName" value="${tempUser.userName}" required>
								<input readonly type="hidden" class="form-control" id="addname"
									name="idUser" value="${tempUser.id}" required> <input
									readonly type="hidden" class="form-control" id="addname"
									name="password" value="${tempUser.password}" required>
								<input readonly type="hidden" class="form-control" id="addname"
									name="status" value="${tempUser.status}" required>
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
							<button type="submit" class="btn btn-primary">Lưu</button>
						</div>
					</form:form>
				</div>

			</div>
		</div>
	</div>
	<!-- Modal Update-->

</body>
</html>
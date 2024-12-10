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
	<!-- ------------------------------------------------------------------ Modal chi tiết --------------------------------------------------------- -->
	<div class="modal fade" id="idModelDetail${tempUser.id}" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">
						Chi tiết : <span>${tempUser.fullName}</span>
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-6">
							<h5>Họ tên :</h5>
							<p>${tempUser.fullName}</p>
							<h5>Email:</h5>
							<p>${tempUser.email}</p>
							<h5>Số điện thoại:</h5>
							<p>${tempUser.phoneNumber}</p>
							<h5>Tài khoản:</h5>
							<p>${tempUser.userName}</p>
						</div>
						<div class="col-6">
							<h5>Địa chỉ :</h5>
							<p th:text="${tempUser.address}">${tempUser.address}</p>
							<h5>Vai trò:</h5>
							<p>${tempUser.role.roleName}</p>
							<h5>Lần đăng nhập gần nhất:</h5>
							<p>${tempUser.created}</p>
							<h5>Note:</h5>
							<p>${tempUser.note}</p>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
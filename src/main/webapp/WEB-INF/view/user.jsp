<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Quản trị</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link type="text/css"
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />

<link type="text/css"
	href="${pageContext.request.contextPath}/static/admin1/assets/css/styles.css"
	rel="stylesheet" />

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>

<script
	src="${pageContext.request.contextPath}/static/admin1/assets/js/scripts.js"></script>

<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
	crossorigin="anonymous"></script>

<script
	src="${pageContext.request.contextPath}/static/admin1/assets/js/datatables-simple-demo.js"></script>

<script
	src="https://cdn.ckeditor.com/ckeditor5/29.0.0/classic/ckeditor.js"></script>

</head>

<body class="sb-nav-fixed">
<%@include file='menu_header.jsp'%>

	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<div th:fragment="html_menu" id="layoutSidenav_nav">
				<jsp:include page="sidenave-menu.jsp"></jsp:include>
			</div>
		</div>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">Danh sách người dùng</h1>
					<div class="card mb-4">
						<div class="card-header">
							<form:form action="addUser" modelAttribute="user" method="post">
								<button type="submit" class="btn btn-success"
									data-bs-toggle="modal" data-bs-target="#exampleModalAdd">
									Thêm mới</button>
							</form:form>


						</div>
						<div class="card-body">
						<div class="datatable-top datatable-top-top">
							<div class="datatable-dropdown">
							            <label>
							                <select class="datatable-selector" name="per-page" onchange="sendData()" id="numRecords">
							                <option value="5" selected>5</option>
							                <option value="2" >2</option>
							                <option value="10">10</option>
							                
							                </select> entries per page
							            </label>
							 </div>
							 <div class="datatable-search">
							    <input class="datatable-input" placeholder="Search..." type="search" id="search-user" name="search" title="Search within table" aria-controls="datatablesSimple">
							  </div>
							</div>
							<table id="datatablesSimple">
								<thead>
									<tr style="background-color: gray !important;">
										<th>Họ tên</th>
										<th>Email</th>
										<th>Số điện thoại</th>
										<th>Tài khoản</th>
										<th>Vai trò</th>
										<th>Trạng thái</th>
										<th style="width: 220px">Hành động</th>
									</tr>
								</thead>
								<tfoot>
									<tr>

									</tr>
								</tfoot>
								<tbody>
									<c:forEach var="tempUser" items="${users}">

										<tr>
											<td>${tempUser.fullName}</td>
											<td>${tempUser.email}</td>
											<td>${tempUser.phoneNumber}</td>
											<td>${tempUser.userName}</td>
											<td>${tempUser.role.roleName}</td>
											<td><c:choose>
													<c:when test="${tempUser.status == 1}">
														<p style="color: #1c7430; font-weight: bold">Hoạt động</p>
													</c:when>
													<c:when test="${tempUser.status == 0}">
														<p style="color: red; font-weight: bold">Đã khóa</p>
													</c:when>
												</c:choose></td>
											<td style="width: 270px">

												<button type="button" style="width: 80px"
													class="btn btn-success" data-bs-toggle="modal"
													data-bs-target="#idModelMail${tempUser.id}">Gửi</button> <form:form
													modelAttribute="user"
													action="updateUser?userId=${tempUser.id}" method="post">
													<button type="submit" style="width: 80px"
														class="btn btn-primary" data-bs-toggle="modal"
														data-bs-target="#exampleModal${tempUser.id}">Sửa</button>

												</form:form>


												<button type="button" style="width: 80px"
													class="btn btn-warning" data-bs-toggle="modal"
													data-bs-target="#idModelDetail${tempUser.id}">Chi
													tiết</button>

												<button type="button" style="width: 80px"
													class="btn btn-danger mt-1 deleteButton"
													onclick="deleteUser('${tempUser.id}','${tempUser.userName}')">Xóa</button>
												<c:choose>

													<c:when test="${tempUser.status == 1}">
														<form:form modelAttribute="user"
															action="changeUserStatus?userId=${tempUser.id}&flag=lock&status=0"
															method="POST">
															<input type="hidden" class="form-control" id="id"
																name="id" value="${tempUser.id}">
															<button type="submit" style="width: 80px"
																class="btn btn-danger">Khóa</button>
														</form:form>
													</c:when>
													<c:when test="${tempUser.status == 0}">
														<form
															action="changeUserStatus?userId=${tempUser.id}&flag=unlock&status=1"
															method="POST">
															<input type="hidden" class="form-control" id="id"
																name="id" value="${tempUser.id}">
															<button type="submit" style="width: 80px"
																class="btn btn-success">Mở</button>
														</form>
													</c:when>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				

				
				<nav aria-label="Page navigation example">
				  <ul class="pagination justify-content-center">
				    <c:forEach begin="1" end="${totalPages}" var="i">
						<li class="page-item"><a class="page-link" onclick="getUsers(event, this)" href="#"
							data-href="${pageContext.request.contextPath}/admin/listUsers?page=${i}">${i}</a>
						</li>
					</c:forEach>
				  </ul>
				</nav>

				<!-- ------------------------------------------------------------------ Modal Xóa --------------------------------------------------------- -->
				<div class="modal fade" id="idModelDel" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h3 class="modal-title" id="exampleModalLabel">Bạn chắc
									chắn muốn xóa ?</h3>
							</div>

							<div class="modal-body">
								<span class="name"></span>
								<form action="deleteUser" modelAttribute="user">
									<input type="hidden" class="form-control" id="delete-user-id"
										name="userID">

									<div class="modal-footer" style="margin-top: 20px">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">Close</button>
										<button type="submit" class="btn btn-danger"">Xóa</button>
									</div>
								</form>
							</div>

						</div>
					</div>
				</div>
				<!-- ------------------------------------------------------------------End Modal Xóa --------------------------------------------------------- -->


			</main>

			<script>

      ClassicEditor.create(document.querySelector('#editor')).then(eidt => {
        console.log("da" + edit);
      })
              .catch(error => {
                console.error(error);
              });

    </script>

			<script>
    $(document).ready(function(){
        $('.modal').modal('hide');
    });
    
    function deleteUser(id, name){
    	const myModal = new bootstrap.Modal('#idModelDel', {
    		  keyboard: false
    	})
    	
    	 document.querySelector('#idModelDel .name').innerHTML = name;
    	 document.querySelector('#delete-user-id').value = id;
    	 myModal.show();   	 
    }
    </script>


			<script>

      var dodai = document.getElementById("dodai").value;
      var a = parseInt(dodai);
      for(var i = 1;i<=a+10;i++){
        var name = "#editor"  + i
        ClassicEditor.create(document.querySelector(name)).then(eidt => {
          console.log("da" + eidt);
        })
                .catch(error => {
                  console.error(error);
                });
      }
    </script>

			<footer th:replace="admin/fragments :: footer"
				class="py-4 bg-light mt-auto"> </footer>
		</div>
	</div>


	<script
		src="${pageContext.request.contextPath}/static/admin1/assets/js/JQuery3.3.1.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>

	<script
		src="${pageContext.request.contextPath}/static/admin1/assets/js/scripts.js"></script>

	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
		crossorigin="anonymous"></script>

	<script
		src="${pageContext.request.contextPath}/static/admin1/assets/js/datatables-simple-demo.js">
		</script>
		<script>
		var numRecords = localStorage.getItem("numRecords");
		if(numRecords != null) {
			document.getElementById("numRecords").value = numRecords;
		}
			function getUsers(e, t){
				e.preventDefault();
				var url = t.getAttribute("data-href")+"&numRecords="+numRecords;
				window.location.href=url;
			}
			$("#search-user").on("keydown", function(e){
				
				if(e.keyCode==13) {
					var searchValue = $("#search-user").val();
					var numRecords = document.getElementById("numRecords").value;
					var url = "${pageContext.request.contextPath}/admin/listUsers?page=1&numRecords="+numRecords+"&search="+searchValue;
					window.location.href=url;
				}
			})
		function sendData(){
			var numRecords = document.getElementById("numRecords").value;
			localStorage.setItem("numRecords", numRecords);
			var url = "${pageContext.request.contextPath}/admin/listUsers?page=1&numRecords="+numRecords;
			window.location.href=url;
		}
		</script>
</body>
</html>
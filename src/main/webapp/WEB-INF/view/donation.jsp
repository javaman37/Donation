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
      <%@include file="sidenave-menu.jsp"%>
  </div>
  </div>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">Danh sách đợt quyên góp</h1>
					<div class="card mb-4">
						<div class="card-header">
							<form:form action="addDonation" modelAttribute="donation">
								<input type="submit" value="Thêm mới" />

							</form:form>
						</div>
						
						 
							
						<div class="card-body">
						
						<div class="datatable-dropdown">
							            <label>
							                <select class="datatable-selector" name="per-page" onchange="sendData()" id="numRecords">
							                <option value="5" selected>5</option>
							                <option value="2">2</option>
							                <option value="10">10</option>
							                <option value="20">20</option>
							                
							                </select> entries per page
							            </label>
						</div>
						 <div class="datatable-search">
							    <input class="datatable-input" placeholder="Search..." type="search" id="search-donation" name="search" title="Search within table" aria-controls="datatablesSimple">
							  </div>
							 
							</div>
							
							</div>
							 
							<table id="datatablesSimple">
								<thead>
									<tr style="background-color: gray !important;">
										<th>Mã</th>
										<th>Tên</th>
										<th>Ngày bắt đầu</th>
										<th>Ngày kết thúc</th>
										<th>Tổ chức</th>
										<th>Số điện thoại</th>
										<th>Tổng tiền</th>
										<th>Trạng thái</th>
										<th style="width: 14%;">Hành động</th>
									</tr>
								</thead>
								<tfoot>
									<tr>

									</tr>
								</tfoot>
								<tbody>
									<c:forEach var="tempDonation" items="${donation}">
										<tr>
											<td>${tempDonation.code}</td>
											<td>${tempDonation.name}</td>
											<td>${tempDonation.startDate}</td>
											<td>${tempDonation.endDate}</td>
											<td>${tempDonation.organizationName}</td>
											<td>${tempDonation.phoneNumber}</td>
											<td>${tempDonation.money}</td>
											<!-- ----------------------------------------------- Status ----------------------------------------------- -->
											<td><c:choose>
													<c:when test="${tempDonation.status == 1}">
														<p style="color: #1c7430; font-weight: bold">Mới tạo</p>
													</c:when>
													<c:when test="${tempDonation.status == 2}">
														<p style="color: #1c7430; font-weight: bold">Đang
															quyên góp</p> 
													</c:when>
													<c:when test="${tempDonation.status == 3}">
														<p style="color: #1c7430; font-weight: bold">Kết thúc</p>
													</c:when>
													<c:when test="${tempDonation.status == 0 }">
														<p style="color: red; font-weight: bold">Đóng</p>
													</c:when>
												</c:choose></td>
											<!-- --------------------------------------------- End Status --------------------------------------------- -->

											<!-- ----------------------------------------------- Action ----------------------------------------------- -->
											<td style="">
											<%-- <form:form modelAttribute="donation"
													action="updateDonation?donationId=${tempDonation.id}&currentPage=${currentPage}"
													method="post"> --%>
													<button type="submit"
											        style="width: 80px; margin-bottom: 17px;"
														class="btn btn-primary" data-bs-toggle="modal" 
														onclick="updateDonation('${tempDonation.id}')"
														>
														Cập nhật</button>
											<%-- 	</form:form> --%>
												
												
												
												
												<form action="detailDonation"
													style="margin-left: 90px; margin-top: -38px;">
													<input type="hidden" class="form-control" id="id"
														name="donationID" value="${tempDonation.id}">
													<button type="submit" style="width: 80px;"
														class="btn btn-warning">Chi tiết</button>
												</form>

												<button type="button" style="width: 80px;"
													class="btn btn-danger mt-1 deleteButton"
													onclick="deleteDonation('${tempDonation.id}','${tempDonation.name}')">Xóa
												</button> <c:choose>
													<c:when test="${tempDonation.status == 1}">
														<form:form modelAttribute="donation"
															action="activeDonation" method="post"
															style="margin-left: 110px;margin-top: -38px">
															<input type="hidden" class="form-control" id="id"
																name="id" value="${tempDonation.id}">
															<button type="submit" style="width: 110px"
																class="btn btn-success">Quyên góp</button>
														</form:form>
													</c:when>
													<c:when test="${tempDonation.status == 2}">
														<form:form modelAttribute="donation"
															action="endDonation?currentPage=${currentPage}"
															method="post"
															style="margin-left: 115px;margin-top: -38px">
															<input type="hidden" class="form-control" id="id"
																name="id" value="${tempDonation.id}">
															<button type="submit" style="width: 80px"
																class="btn btn-success">Kết thúc</button>
														</form:form>
													</c:when>
													<c:when test="${tempDonation.status == 3}">
														<form:form modelAttribute="donation"
															action="closeDonation?currentPage=${currentPage}"
															method="post"
															style="margin-left: 110px;margin-top: -38px">
															<input type="hidden" class="form-control" id="id"
																name="id" value="${tempDonation.id}">
															<button type="submit" style="width: 80px"
																class="btn btn-danger">Đóng</button>
														</form:form>
													</c:when>

												</c:choose></td>
											<!-- --------------------------------------------- End Action --------------------------------------------- -->
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
							<li class="page-item"><a class="page-link"
								onclick="getUsers(event, this)" href="#"
								data-href="${pageContext.request.contextPath}/admin/listDonation?page=${i}">${i}</a>
							</li>
						</c:forEach>
					</ul>
				</nav>
				<!-- ------------------------------------------------------------------- Modal Xóa ----------------------------------------------------------- -->
				<div class="modal fade" id="idModelDel" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h3 class="modal-title" id="exampleModalLabel">Bạn chắc
									chắn muốn xóa ?</h3>

							</div>
							<div class="modal-body">
								Đợt quyên góp : <span class="name"></span>
								<form action="deleteDonation" modelAttribute="donation">
									<input type="hidden" class="form-control"
										id="delete-donation-id" name="donationID">

									<div class="modal-footer" style="margin-top: 20px">

										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">Close</button>
										<button type="submit" class="btn btn-danger">Xóa</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- ----------------------------------------------------------------- End Modal Xóa --------------------------------------------------------- -->

				<!-- Model update -->
				<div class="modal fade" tabindex="-1"
						id="idModalUpdate"
						aria-labelledby="idModalUpdate" aria-hidden="true">
						<div class="modal-dialog modal-lg ">
							<div class="modal-content">
								<div class="modal-header">
									<h3 class="modal-title" id="idModalUpdate_">Cập nhật</h3>
									
								</div>
								<div class="modal-body">
									<form:form id="formUpdate" modelAttribute="donation" action="saveUpdateDonation?currentPage=${currentPage}"
										method="post">
										<input type="hidden" name="id" value="${tempDonation.id}" id="id">
										<div class="row">
											<div class="col-6">
												<label for="addname" class="col-form-label">Mã đợt quyên
													góp:</label> <input type="text" class="form-control" id="code"
													name="code" value="${tempDonation.code}" required>
											</div>
											<div class="col-6">
												<label for="addcost" class="col-form-label">Tên đợt
													quyên góp:</label> <input type="text" class="form-control" id="name"
													name="name" value="${tempDonation.name}" required>
											</div>
										</div>
										<div class="row">
											<div class="col-6">
												<label for="addname" class="col-form-label">Ngày bắt
													đầu:</label> <input type="date" class="form-control" id="startDate"
													name="startDate" value="${tempDonation.startDate}" required>
											</div>
											<div class="col-6">
												<label for="addcost" class="col-form-label">Ngày kết
													thúc:</label> <input type="date" class="form-control" id="endDate"
													name="endDate" value="${tempDonation.endDate}" required>
											</div>
										</div>
										<div class="row">
											<div class="col-6">
												<label for="addname" class="col-form-label">Tổ chức:</label> <input
													type="text" class="form-control" id="organizationName"
													name="organizationName"
													value="${tempDonation.organizationName}" required>
											</div>
											<div class="col-6">
												<label for="addcost" class="col-form-label">Số điện
													thoại:</label> <input type="number" class="form-control" id="phoneNumber"
													name="phoneNumber" value="${tempDonation.phoneNumber}" required>
											</div>
											<div class="col-12">
												<label for="ct_id" class="col-form-label">Nội dung:</label>
												<textarea name="description" class="form-control" cols="50" id="description"
													rows="5">${tempDonation.description}</textarea>
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
												
			</main>

			<script>
    $(document).ready(function(){
        $('.modal').modal('hide');
    });
    
    function deleteDonation(id, name){
    	const myModal = new bootstrap.Modal('#idModelDel', {
    		  keyboard: false
    	})
    	
    	// The nay khong ton tai trong phan html phia tren
    	 document.querySelector('#idModelDel .name').innerHTML = name;
    	 document.querySelector('#delete-donation-id').value = id;
    	 myModal.show();   	 
    }
    
    </script>

			<script>
      ClassicEditor.create(document.querySelector('#editor')).then(eidt => {
        console.log("da" + eidt);
      })
              .catch(error => {
                console.error(error);
              });
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
		src="${pageContext.request.contextPath}/static/admin1/assets/js/datatables-simple-demo.js"></script>
		
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
			$("#search-donation").on("keydown", function(e){
				
				if(e.keyCode==13) {
					var searchValue = $("#search-donation").val();
					var numRecords = document.getElementById("numRecords").value;
					var url = "${pageContext.request.contextPath}/admin/listDonation?page=1&numRecords="+numRecords+"&search="+searchValue;
					window.location.href=url;
				}
			})
		function sendData(){
			var numRecords = document.getElementById("numRecords").value;
			localStorage.setItem("numRecords", numRecords);
			var url = "${pageContext.request.contextPath}/admin/listDonation?page=1&numRecords="+numRecords;
			window.location.href=url;
		}
			function formatDateToYYYYMMDD(date) {
		        const year = date.getFullYear();
		        const month = String(date.getMonth() + 1).padStart(2, '0'); // Tháng tính từ 0 nên cần +1
		        const day = String(date.getDate()).padStart(2, '0');
		        return year+"-"+month+"-"+day;
		    }
			function updateDonation(id) {
				
		    	$.ajax({
		    		type:"GET",
		    		url : "updateDonation",
		    		data : {donationId : id},
		   		   	success: function(json){
		   		   	const myModal = new bootstrap.Modal('#idModalUpdate', {
				  		  keyboard: false
				  		});
		   		   	myModal.show(); 
		   		   	const jsonObject = JSON.parse(json);
		   		 	const startDateObj = new Date(jsonObject.endDate);
		   		  	const endDateObj = new Date(jsonObject.endDate);
		   			const endDate = formatDateToYYYYMMDD(endDateObj);
		   			const startDate = formatDateToYYYYMMDD(startDateObj);
		   		   	 console.log(jsonObject)
			 			$("#formUpdate #id").val(jsonObject.id);
		   		  		$("#code").val(jsonObject.code);
			   		  	$("#name").val(jsonObject.name);
			   		 	$("#endDate").val(endDate);
			   		 	$("#startDate").val(startDate);
				   		$("#organizationName").val(jsonObject.organizationName);
				   		$("#phoneNumber").val(jsonObject.phoneNumber);
			   			$("#description").val(jsonObject.description);
		   			 }

		    	});
  
		    }
		</script>
</body>
</html>
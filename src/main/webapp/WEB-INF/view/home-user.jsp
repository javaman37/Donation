<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" lang="en">
<head>
<title>Donation website &mdash; Website Donation</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="author" content="Free-Template.co" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">


<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/static/user/assets/css/custom-bs.css">
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/static/user/assets/css/jquery.fancybox.min.css">
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/static/user/assets/css/bootstrap-select.min.css">
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/static/user/assets/fonts/icomoon/style.css">
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/static/user/assets/fonts/line-icons/style.css">
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/static/user/assets/css/owl.carousel.min.css">
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/static/user/assets/css/animate.min.css">

<!-- MAIN CSS -->
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/static/user/assets/css/style.css">



</head>
<body id="top">
	<div id="overlayer"></div>
	<div class="loader">
		<div class="spinner-border text-primary" role="status">
			<span class="sr-only">Loading...</span>
		</div>
	</div>
	<div th:if="${msg eq 'ss'}" class="toast" data-delay="1000"
		style="position: fixed; top: 100PX; left: 40PX; z-index: 2000; width: 300px">

	</div>

	<div class="site-wrap">

		<div class="site-mobile-menu site-navbar-target">
			<div class="site-mobile-menu-header">
				<div class="site-mobile-menu-close mt-3">
					<span class="icon-close2 js-menu-toggle"></span>
				</div>
			</div>
			<div class="site-mobile-menu-body"></div>
		</div>
		<!-- .site-mobile-menu -->


		<!-- NAVBAR -->
		<header class="site-navbar mt-3">
			<div class="container-fluid">
				<div class="row align-items-center">
					<div class="site-logo col-4">
						<a href="${pageContext.request.contextPath}"><h2>Website
								Quyên Góp</h2> </a>
					</div>
					<div
						class="right-cta-menu text-right d-flex aligin-items-center col-3">
						<div class="ml-auto">
							<c:if test="${loggedinUser != null}">
								<a href="${pageContext.request.contextPath}/logout"
									class="btn btn-primary border-width-2 d-none d-lg-inline-block">Log
									Out</a>
							</c:if>
							<c:if test="${loggedinUser == null}">
								<a href="${pageContext.request.contextPath}/login"
									class="btn btn-primary border-width-2 d-none d-lg-inline-block"><span
									class="mr-2 icon-lock_outline"></span>Log In</a>
							</c:if>
						</div>
						<a href="#"
							class="site-menu-toggle js-menu-toggle d-inline-block d-xl-none mt-lg-2 ml-3"><span
							class="icon-menu h3 m-0 p-0 mt-2"></span></a>
					</div>
				</div>
			</div>
			<c:if test="${loggedinUser != null}">
				<div style="margin-top: 20px;" class="site-logo col-4">
					<h3 style="color: white;">Welcome ${loggedinUser.fullName}</h3>
				</div>
				<br>
			</c:if>
		</header>

		<!-- HOME -->
		<section class="section-hero overlay inner-page bg-image"
			style="background-image: url('${pageContext.request.contextPath}/static/user/assets/images/hero_1.jpg');"
			id="home-section">
			<div class="container">
				<div class="row">
					<div class="col-md-7">
						<h1 class="text-white font-weight-bold">Danh sách các đợt
							quyên góp</h1>

					</div>
				</div>
			</div>
		</section>
		<section class="site-section">
			<div class="container">
				<div class="row mb-5 justify-content-center">
					<div class="col-md-7 text-center">
						<h2 class="section-title mb-2">Các đợt quyên góp</h2>
					</div>
				</div>
					<div class="datatable-dropdown">
							            <label>
							                <select class="datatable-selector" name="per-page" onchange="sendData()" id="numRecords_s">
							                <option value="5" selected>5</option>
							                <option value="2">2</option>
							                <option value="10">10</option>
							                <option value="20">20</option>
							                
							                </select> entries per page
							            </label>
						</div>

				<ul class="job-listings mb-5">
					<c:forEach var="tempDonation" items="${donations}">
						<li style="margin-top: 20px"
							class="job-listing d-block d-sm-flex pb-3 pb-sm-0 align-items-center ">

							<div
								class="job-listing-about d-sm-flex custom-width w-100 justify-content-between mx-4">
								<div
									class="job-listing-position custom-width  mb-3 mb-sm-0 custom-width w-25">
									<form action="user/detail" method="GET" style="">
										<input type="hidden" class="form-control" id="id"
											name="donationID" value="${tempDonation.id}">
										<button type="submit"
											style="border: none; background-color: white;">
											<h2>${tempDonation.name}</h2>
										</button>
									</form>
									<strong> <c:choose>
											<c:when test="${tempDonation.status == 1}">
												<p style="color: #1c7430; padding: 10px; font-weight: bold">Mới
													tạo</p>
											</c:when>
											<c:when test="${tempDonation.status == 2}">
												<p style="color: #1c7430; padding: 10px; font-weight: bold">Đang
													quyên góp</p>
											</c:when>
											<c:when test="${tempDonation.status == 3}">
												<p style="color: #1c7430; padding: 10px; font-weight: bold">Kết
													thúc</p>
											</c:when>
											<c:when test="${tempDonation.status == 0}">
												<p style="color: red; padding: 10px; font-weight: bold">Đóng</p>
											</c:when>
										</c:choose>
									</strong>


								</div>
								<div class="job-listing-location mb-3 mb-sm-0 custom-width w-10"
									style="padding: 10px;">
									Ngày bắt đầu<br>
									<p>${tempDonation.startDate}</p>
									<br>
								</div>
								<div class="job-listing-location mb-3 mb-sm-0 custom-width w-10"
									style="padding: 10px;">
									Ngày kết thúc<br> <strong>${tempDonation.endDate}</strong><br>
								</div>
								<div class="job-listing-location mb-3 mb-sm-0 custom-width w-25"
									style="padding: 10px;">
									<span class="icon-room"></span> <span>${tempDonation.organizationName}</span><br>
									<strong>${tempDonation.phoneNumber}</strong><br>
								</div>
								<c:choose>
									<c:when
										test="${tempDonation.status == 2 and loggedinUser != null}">
										<div class="job-listing-meta custom-width w-20"
										
											style="margin-top: 20px; margin-right: 50px; background-color: white !important;">
											<button type="button" 
											        class="btn btn-primary py-2"
												    data-bs-toggle="modal"
												    data-bs-target="#exampleModal${tempDonation.id}">
												Quyên góp</button>
										</div>
									</c:when>
									<c:otherwise>
										<p
											style="margin-top: 20px; margin-right: 50px; background-color: white !important;"
											class="btn py-2">
											<span style="color: white"
												>Quyên góp</span>
										</p>
									</c:otherwise>
								</c:choose>

							</div>

						</li>
						<!-- ----------------------------------------------------- Modal ----------------------------------------------------- -->
						<div style="margin-top: 50px;" id="exampleModal${tempDonation.id}" class="modal fade" tabindex="-1"
							role="dialog" aria-labelledby="exampleModalLabel${tempDonation.id}"
							id="exampleModalLabel${tempDonation.id}" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalLabel-">
											Quyên góp: <span></span>
										</h5>
										<button type="button" class="close" data-bs-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true" data-bs-dismiss="modal">&times;</span>
										</button>
									</div>
									<form action="user/saveUserDonation" modelAttribute="userDonation" method="POST">
										<input type="hidden" class="form-control" id="donation"
											name="donation" value="${tempDonation.id}">
										<input type="hidden" class="form-control" id="user"
											name="user" value="${loggedinUser.id}">
										<div class="modal-body">
											<div class="row">
												<div class="col-12">
													<label for="addname" class="col-form-label">111Họ tên:</label>
													<input type="text" class="form-control" id="addname"
														name="name" placeholder=""
														value="${loggedinUser.fullName}" required> <label
														for="addname" class="col-form-label">Số tiền quyên
														góp:</label> <input type="number" class="form-control"
														placeholder="" id="addname" name="money" required>
													<label for="addname" class="col-form-label">222Lời
														nhắn:</label>
													<textarea rows="10" cols="3" class="form-control"
														name="text">
                                                </textarea>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Đóng</button>
												<button type="submit" data-toggle="modal"
													data-target="#exampleModal" class="btn btn-primary">
													Quyên góp</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
						<!-- ----------------------------------------------------- End Modal ----------------------------------------------------- -->
						
					</c:forEach>
					
					
				</ul>
						
					<ul class="pagination pagination-sm">
						<c:forEach var="pageNumber" begin="1" end="${totalPage}" step="1">
							<li class="page-item"><a class="page-link"
								href="?page=${pageNumber}">${pageNumber}</a></li>
						</c:forEach>
					</ul>
				
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<c:forEach begin="1" end="${totalPages}" var="i">
							<li class="page-item"><a class="page-link"
								onclick="getDonation(event, ${i})" href="#"
								>${i}</a>
							</li>
						</c:forEach>
					</ul>
				</nav>
				<form action="${pageContext.request.contextPath}/doLogin" method="POST" id="f_donation">
					<input type="hidden" name="page" id="page" >
					<input type="hidden" name="numRecords" id="numRecords" >
				</form>
			</div>
			
		</section>
	</div>
	<script>
							function detail(id) {
								window.location = '/donation/detail/' + id;
							}
	</script>
	
	
	<script
	src="${pageContext.request.contextPath}/static/user/assets/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/user/assets/js/bootstrap.bundle.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/user/assets/js/isotope.pkgd.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/user/assets/js/stickyfill.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/user/assets/js/jquery.fancybox.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/user/assets/js/jquery.easing.1.3.js"></script>

<script
	src="${pageContext.request.contextPath}/static/user/assets/js/jquery.waypoints.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/user/assets/js/jquery.animateNumber.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/user/assets/js/owl.carousel.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/user/assets/js/bootstrap-select.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/user/assets/js/custom.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	var numRecords = localStorage.getItem("numRecords");
	
	if(numRecords != null) {
		document.getElementById("numRecords").value = numRecords;
	} 
		function getDonation(e, i){
			e.preventDefault();
			$("#page").val(i);
			$("#numRecords").val(numRecords);
			$("#f_donation").submit();
		}
	function sendData(){
		var numRecords = $("#numRecords_s").val();
		localStorage.setItem("numRecords", numRecords);
		$("#page").val(1);
		$("#numRecords").val(numRecords);
		$("#f_donation").submit();
	}
	
	</script>
</body>
</html>
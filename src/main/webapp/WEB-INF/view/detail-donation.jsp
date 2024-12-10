<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <title>Quản trị</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  
  <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
  
  <link href="${pageContext.request.contextPath}/static/admin1/assets/css/styles.css" rel="stylesheet" />
  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
          
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
          
  <script src="${pageContext.request.contextPath}/static/admin1/assets/js/scripts.js"></script>
  
  <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>

  <script src="${pageContext.request.contextPath}/static/admin1/assets/js/datatables-simple-demo.js"></script>

  <script src="https://cdn.ckeditor.com/ckeditor5/29.0.0/classic/ckeditor.js"></script>
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
<%--     <c:forEach var="tempDonation" items="${donation}"> --%>
      <div class="container-fluid px-4">
        <h1 class="mt-4">Chi tiết đợt quyên góp</h1>
        <div class="card mb-4">
			<input type="hidden" name="id" value="${donation.id}">
          <div class="card-body">
          
            <!-- ---------------------------------- Detail ---------------------------------- -->
            <div class="row">
              <div class="col-6">
                <label for="addname" class="col-form-label">Mã đợt quyên góp:</label>
                <input type="text" class="form-control" id="addname" name="code" value="${donation.code}" readonly="readonly">
              </div>
              <div class="col-6">
                <label for="addcost" class="col-form-label">Tên đợt quyên góp:</label>
                <input type="text" class="form-control" id="addcost" name="name" value="${donation.name}" readonly="readonly">
              </div>
            </div>
            <div class="row">
              <div class="col-6">
                <label for="addname" class="col-form-label">Ngày bắt đầu:</label>
                <input type="datetime" class="form-control" id="addname" name="startDate" value="${donation.startDate}" readonly="readonly">
              </div>
              <div class="col-6">
                <label for="addcost" class="col-form-label">Ngày kết thúc:</label>
                <input type="datetime" class="form-control" id="addcost" name="endDate" value="${donation.endDate}"readonly="readonly">
              </div>
            </div>
            <div class="row">
              <div class="col-6">
                <label for="addname" class="col-form-label">Tổng tiền quyên góp:</label>
                <input type="text" class="form-control" id="addname" name="sumMoneyUserDonation" value="${sumMoneyUserDonation}" readonly="readonly">
              </div>
              <div class="col-6">
                <label for="addcost" class="col-form-label">Trạng thái:</label>
                <c:choose>
					<c:when test="${donation.status == 1}">
						<input type="text" class="form-control" id="addcost" name="end" value="Mới tạo" readonly="readonly">
					</c:when>
					<c:when test="${donation.status == 2}">
						<input type="text" class="form-control" id="addcost" name="end" value="Đang quyên góp" readonly="readonly">
					</c:when>
					<c:when test="${donation.status == 3}">
						<input type="text" class="form-control" id="addcost" name="end" value="Kết thúc quyên góp" readonly="readonly">
						</c:when>
					<c:when test="${donation.status == 0}">
						<input type="text" class="form-control" id="addcost" name="end" value="Đóng quyên góp" readonly="readonly">
					</c:when>
				</c:choose>                                                            
              </div>
            </div>
            
            <div class="row">
              <div class="col-6">
                <label for="addname" class="col-form-label">Tổ chức:</label>
                <input type="text" class="form-control" id="addname" name="organizationName" value="${donation.organizationName}" readonly="readonly">
              </div>
              <div class="col-6">
                <label for="addcost" class="col-form-label">Số điện thoại:</label>
                <input type="number" class="form-control" id="addcost" name="phoneNumber" value="${donation.phoneNumber}" readonly="readonly">
              </div>
              <div class="col-12">
                <label for="ct_id" class="col-form-label">Nội dung:</label>
                <textarea name="description" class="form-control" cols="50" readonly="readonly">${donation.description}</textarea>
              </div>
            </div>
            <!-- ---------------------------------- Detail ---------------------------------- 	-->
            <h3 class="mt-4">Danh sách những người quyên góp</h3>
            <table id="datatablesSimple">
            
              <thead>
              <tr style="background-color: gray !important;">
                <th>Họ Tên</th>
                <th>Tiền quyên góp</th>
                <th>Ngày quyên góp</th>
                <th>Nội dung</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
              </tr>
              </thead>
              <tfoot>
              <tr>

              </tr>
              </tfoot>
              <tbody>
              <input type="hidden" th:value="${userDonationList.size()}" id="dodai" />

<!--               ----------------------------------------------------------------------------------------------------- -->
			<c:forEach var="tempUserDonation" items="${userDonations}">
                <tr>
                  <td>${tempUserDonation.name}</td>
                  <td>${tempUserDonation.money}</td>
                  <td>${tempUserDonation.created}</td>
                  <td>${tempUserDonation.text}</td>
                  <td>
                  	<c:if test="${tempUserDonation.status == 0}"><p style="color: #DAA520;">Chờ xác nhận</p></c:if>
                  	<c:if test="${tempUserDonation.status == 1}"><p style="color: #008000;">Đã xác nhận</p></c:if>
                  	<c:if test="${tempUserDonation.status == 2}"><p style="color: red;">Từ chối</p></c:if>
                  </td>
                  <td style="display: flex;justify-content: space-between">                 
					<c:if test="${tempUserDonation.status == 0}">
						<table>
							<tr>
								<td>
									<form:form style="width: 150px;" modelAttribute="userDonation" action="acceptUserDonation" method="POST">
										<input type="hidden" class="form-control" id="id" name="id" value="${tempUserDonation.id}">
										<input type="hidden" class="form-control" id="id" name="donationID" value="${donation.id}">
										<button  type="submit" style="width: 150px"  class="btn btn-success">Xác nhận</button>
									</form:form>
								</td>
								<td>
									<form:form style="width: 150px" modelAttribute="userDonation" action="refuseUserDonation" method="POST">
										<input type="hidden" class="form-control" id="id" name="id" value="${tempUserDonation.id}">
										<input type="hidden" class="form-control" id="id" name="donationID" value="${donation.id}">
										<button type="submit" style="width: 150px" class="btn btn-danger">Hủy xác nhận</button>
									</form:form>  
								</td>   
							</tr>  
						</table>  	
					</c:if>                  
                  </td>
                </tr>  
             </c:forEach>                                                                             
<!--               ----------------------------------------------------------------------------------------------------- -->
              </tbody>
            </table>
          </div>
        </div>
      </div>
<%-- 	</c:forEach> --%>
    </main>

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
    <footer class="py-4 bg-light mt-auto">
      <div class="container-fluid px-4">

      </div>
    </footer>
  </div>
</div>

<script src="${pageContext.request.contextPath}/static/admin1/assets/js/JQuery3.3.1.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

<script src="${pageContext.request.contextPath}/static/admin1/assets/js/scripts.js"></script>

<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>

<script src="${pageContext.request.contextPath}/static/admin1/assets/js/datatables-simple-demo.js"></script>
</body>
</html>
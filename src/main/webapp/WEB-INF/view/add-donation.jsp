<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản lý Quyên góp</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"></link>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap');
  </style>
</head>
<body>
  <div class="bg-white">
    <div class="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
      <div class="max-w-3xl mx-auto">
        <h1 class="text-2xl font-bold text-gray-900">Thêm mới</h1>
        <div class="mt-6">
          <form action="saveDonation" method="POST" modelAttribute="donation">
          <input type="hidden" name="numRecords" id="numRecords" value="" >
               
            <div class="grid grid-cols-1 gap-y-6 sm:grid-cols-2 sm:gap-x-8">
              <div>
                <label for="code" class="block text-sm font-medium text-gray-700">Mã </label>
                <div class="mt-1">
                  <input type="text" name="code" id="ma-su-co" class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" placeholder="">
                </div>
              </div>

              <div>
                <label for="name" class="block text-sm font-medium text-gray-700">Tên </label>
                <div class="mt-1">
                  <input type="text" name="name" id="ten-su-co" class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" placeholder="">
                </div>
              </div>

              <div class="sm:col-span-2">
                <label for="description" class="block text-sm font-medium text-gray-700">Nội dung</label>
                <div class="mt-1">
                  <textarea id="noi-dung" name="description" rows="3" class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"></textarea>
                </div>
              </div>

              <div>
                <label for="ngay-bat-dau" class="block text-sm font-medium text-gray-700">Ngày bắt đầu</label>
                <div class="mt-1">
                  <input type="date" name="startDate" id="ngay-bat-dau" class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                </div>
              </div>

              <div>
                <label for="ngay-ket-thuc" class="block text-sm font-medium text-gray-700">Ngày kết thúc</label>
                <div class="mt-1">
                  <input type="date" name="endDate" id="ngay-ket-thuc" class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                </div>
              </div>

              <div>
                <label for="to-chuc" class="block text-sm font-medium text-gray-700">Tổ chức</label>
                <div class="mt-1">
                  <input type="text" name="organizationName" id="to-chuc" class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" placeholder="">
                </div>
              </div>

              <div>
                <label for="so-dien-thoai" class="block text-sm font-medium text-gray-700">Số điện thoại</label>
                <div class="mt-1">
                  <input type="text" name="phoneNumber" id="so-dien-thoai" class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" placeholder="">
                </div>
              </div>
            </div>

            <div class="mt-8 border-t border-gray-200 pt-5">
              <div class="flex justify-end">

								<button type="submit"
									class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Thêm</button>


								<button type="button" class="ml-3 inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Đóng</button>
              </div>
            </div>
          </form>
          <script>
          var numRecords = localStorage.getItem("numRecords");
  		document.getElementById("numRecords").value = numRecords != null ? numRecords : 5;
  		 </script>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
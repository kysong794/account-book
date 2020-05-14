<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지출 등록</title>
</head>
<body>

	<br>
	<div class="jumbotron jumbotron-fluid">
	  <div class="container">
	    <h1 class="display-4">지출 등록</h1>
	  </div>
	</div>
	
	<form id="form" action="/history/RegSave" method="post">
		
		<div>
			<label>사용 카드 :</label>
			<select name="cardNo">
				<option value="">카드선택</option>
				<c:forEach items="${ findAll }" var="CardVo">
					<option value="${CardVo.cardNo }">${CardVo.cardName }</option>
				</c:forEach>
			</select>
		</div>
		<div>
			<label>번호 :</label>
			<input type="number" name="historyNo" value="${historyNo }">
		</div>
		<div>
			<label>날짜 :</label>
			<input type="date" name="regDate" />
		</div>
		<div>
			<label>사용처 :</label>
			<input type="text" name="shopName" />
		</div>
		<div>
			<label>상품명 :</label>
			<input type="text" name="productName" />
		</div>
		<div>
			<label>갯수 :</label>
			<input type="number" name="amount" />
		</div>
		<div>
			<label>개당가격 :</label>
			<input type="number" name="price" />
		</div>
		<div>
			<input type="submit" value="등록"/>
			<input type="reset" value="다시쓰기"/>
		</div>
	</form>
</body>
</html>
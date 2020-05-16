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
		<label>사용 카드 :</label>
		<select name="cardNo">
			<option value="">카드선택</option>
			<c:forEach items="${ findAll }" var="CardVo">
				<option value="${CardVo.cardNo }">${CardVo.cardName }</option>
			</c:forEach>
		</select>
		<label>번호 : </label>
		<input type="number" name="historyNo" value="${ historyNo }">
		<label>날짜 : </label>
		<input type="date" name="regDate" />
		<button type="button" id="addRow" class="btn btn-primary">추가</button>
		<table class="table table-hover">
			<tbody id="row">
				<tr>	
					<td>사용처 :
						<input type="text" name="shopName" />
					</td>
					<td>상품명 :
						<input type="text" name="productName" />
					</td>
					<td>갯수 :
						<input type="number" name="amount" />
					</td>
					<td>개당가격 :
						<input type="number" name="price" />
					</td>
				</tr>
			</tbody>
			<tr>
				<td>
				<input type="submit" value="등록"/>
				<input type="reset" value="다시쓰기"/>
				</td>
			</tr>
		</table>
	</form>
	
	<script type="text/javascript">
		$("#addRow").on("click", function() {
			
			var html = '<tr>';
				html += 	'<td>사용처 : ';
				html += 		'<input type="text" name="shopName" />';
				html += 	'</td>';
				html += 	'<td>상품명 : ';
				html += 		'<input type="text" name="productName" />';
				html += 	'</td>';
				html += 	'<td>갯수 : ';
				html += 		'<input type="number" name="amount" />';
				html += 	'</td>';
				html += 	'<td>개당가격 : ';
				html += 		'<input type="number" name="price" />';
				html += 	'</td>';
				html += '</tr>';

			$("#row").append(html);
		});
		
		// submit 이벤트를 바인딩
		$("#form").on("submit", function(e) {
			e.preventDefault();
			console.log($(e.target).serialize());
		});
	</script>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>카드 사용 내역</title>
</head>
<body>

	<div class="container">

		<select class="form-control">
			<c:forEach items="${ cards }" var="card">
				<option value="${ card.cardNo }">${ card.cardName }</option>
			</c:forEach>
		</select>

		<!-- Row(행)을 추가 -->
		<button id="addRow" class="btn btn-primary">추가</button>
		<form id="form" action="/history/delete" method="post">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>날짜</th>
						<th>사용처</th>
						<th>내역</th>
						<th>갯수</th>
						<th>가격</th>
						<th>지출액</th>
						<th>잔액</th>
						<th>수정/삭제</th>
					</tr>

				</thead>
				<tbody id="rows">
					<c:forEach items="${ historyList }" var="history">
						<tr>
							<td>${ history.historyNo }</td>
							<td><fmt:formatDate pattern="yyyy/MM/dd"
									value="${ history.regDate }" /></td>
							<td>${ history.shopName }</td>
							<td>${ history.productName }</td>
							<td>${ history.amount }개</td>
							<td><fmt:formatNumber pattern="#,###"
									value="${ history.price }" />원</td>
							<td></td>
							<td></td>
							<td>
								<button class="btn btn-primary">수정</button>
								<button id="deleteBtn"type="button" class="btn btn-danger"
									onclick="javascript:historyDelete(${history.historyNo})">삭제</button>
								<input type="hidden" id="historyDelete"/>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="6"></td>
						<td>토탈 지출 : <fmt:formatNumber pattern="#,###" value="${ totalPrice }" />원</td>
						<td>잔액 : <fmt:formatNumber pattern="#,###" value="${ totalBalance }" />원</td>
						<td>&nbsp;</td>
					</tr>
					<!-- 추가 row가 여기에 들어가게 한다 -->
				</tbody>
			</table>
		</form>
	</div>

	<script>
		$("#addRow").on("click", function() {
			$("#rows").append("<tr><td><input type='text'/></td></tr>");
		});
		
		function historyDelete(historyNo){
			var result = confirm("정말로 삭제 하시겠습니까?");
				
			if(result == true){
				$('#historyDelete').val(historyNo);
				
				$('#from').submit;
			}else{
					
			}
		}
		
	</script>
</body>
</html>
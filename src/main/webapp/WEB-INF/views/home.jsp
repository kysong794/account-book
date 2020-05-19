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
			<c:forEach items="${ findAll }" var="card">
				<option value="${ card.cardNo }">${ card.cardName }</option>
			</c:forEach>
		</select>

		<!-- Row(행)을 추가 -->
		<button id="addRow" class="btn btn-primary">추가</button>
		
		<div>
			<c:forEach items="${ findAll }" var="findAll">
			카드 유효기간 = <fmt:formatDate pattern="yyyy-MM-dd" value="${ findAll.cardUseLimit }"/>
			</c:forEach>
		</div>
		
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
					<c:forEach items="${ historyList }" var="history" >
						<tr>
							<td>${ history.historyNo }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${ history.regDate }" /></td>
							<td>${ history.shopName }</td>
							<td>${ history.productName }</td>
							<td>${ history.amount }개</td>
							<td><fmt:formatNumber pattern="#,###" value="${ history.price }" />원</td>
							<c:if test="${ history.eachBalance ne null }" >
								<td><fmt:formatNumber pattern="#,###" value="${ history.eachBalance }" />원</td>
							</c:if>
							<c:if test="${ history.eachBalance eq null }" >
								<td></td>
							</c:if>
							<td></td>
							<td>
								<button class="btn btn-primary">수정</button>
								<button name="deleteBtn" data-no="${ history.historyNo }" type="button" class="btn btn-danger">삭제</button>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="6"></td>
						<td>토탈 지출 : <fmt:formatNumber pattern="#,###" value="${ totalPrice }" />원</td>
						<td>잔액 : <fmt:formatNumber pattern="#,###" value="${ totalBalance }" />원</td>
						<td>&nbsp;</td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" name="historyNo" id="historyDelete"/>
		</form>
	</div>
	<script>
		$("#addRow").on("click", function(e) {
			var html = '<c:forEach items="${ historyList }" var="history">'
				html +=	'<tr>';
				html +=		'<td><input type="number" value="${history.historyNo}"</td>';
				html +=		'<td><input type="date" value="${ history.regDate }" /></td>';
				html +=		'<td><input type="text" value="${ history.shopName }"></td>';
				html +=		'<td><input type="text" value="${ history.productName }"</td>';
				html +=		'<td><input type="text" value="${ history.amount }개"/></td>';
				html +=		'<td><fmt:formatNumber pattern="#,###" value="${ history.price }" />원</td>';
				html +=		'<c:if test="${ history.eachBalance ne null }" >';
				html +=		'	<td><fmt:formatNumber pattern="#,###" value="${ history.eachBalance }" />원</td>';
				html +=		'</c:if>';
				html +=		'<c:if test="${ history.eachBalance eq null }" >';
				html +=		'	<td></td>';
				html +=		'</c:if>';
				html +=		'<td></td>';
				html +=		'</tr>';
				html +='</c:forEach>';
			
			$("#rows").append(html);
		});
		
		$("button[name=deleteBtn]").on("click", function(event) {
			
			var deleteBtn = event.target;
			
			var result = confirm("정말로 삭제 하시겠습니까?");
			
			if(result == true){
				var historyNo = $(deleteBtn).attr("data-no");
				$('#historyDelete').val(historyNo);
				
				$('#form').submit();
			} else {
					
			}
		})


	</script>

</body>
</html>
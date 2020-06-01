<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>카드 사용 내역</title>
</head>
<body>

	<select class="form-control col-3" id="cardList">
		<option value="">카드를 선택해 주세요</option>
		<c:forEach items="${ findAll }" var="card">
			<option value="${ card.cardNo }" data-dayleft="${ card.dayLeft }">${ card.cardName }</option>
		</c:forEach>
	</select>

	<!-- Row(행)을 추가 -->
<!-- 	<button id="addRow" class="btn btn-primary">추가</button> -->
	
	<div>
		<c:forEach items="${ findAll }" var="findAll">
		카드 유효기간 : <fmt:formatDate pattern="yyyy-MM-dd" value="${ findAll.cardUseLimit }"/> 까지
		</c:forEach>
	</div>
	<div>
		오늘 날짜 : <fmt:formatDate pattern="yyyy-MM-dd" value="${ now }"/>
	</div>
	<div>
		남은 기간 : <span id="dayLeft">-</span>일 남았습니다.
	</div>

	
	<form id="form" action="/history/delete" method="post">
		<table class="table table-hover">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="20%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>날짜</th>
					<th>사용처</th>
					<th>내역</th>
					<th>갯수</th>
					<th>개당 가격</th>
					<th>합계</th>
					<th>지출액</th>
					<th>수정/삭제</th>
				</tr>
			</thead>
			<tbody id="rows">
				<c:forEach items="${ historyList }" var="history" varStatus="status">
					<tr data-rownum="${ status.count }">
						<td>
							<input type="hidden" value="0" name="isModify">
							<input type="hidden" name="_historyNo" value="${ history.historyNo }">
							${ history.historyNo }
						</td>
						<td>
							<fmt:formatDate pattern="yyyy-MM-dd" value="${ history.regDate }" />
						</td>
						<td>
							${ history.shopName }
						</td>
						<td>
							<input type="hidden" name="_productName" value="${ history.productName }">
							${ history.productName }
						</td>
						<td>
							<span name="originTag">
								${ history.amount }
							</span>
							<input data-origin-type="number"
								data-attr-name="amount"
								name="hiddenTag"
								type="hidden"
								value="${ history.amount }"/>개
						</td>
						<td>
							<span name="originTag">
								<fmt:formatNumber pattern="#,###" value="${ history.price }" />
							</span>
							<input data-origin-type="number"
								data-attr-name="price"
								name="hiddenTag"
								type="hidden"
								value='${ history.price }'/>원
						</td>
						<td>
							<fmt:formatNumber pattern="#,###" value="${ history.totalPrice }"/>원
						</td>
						<c:if test="${ history.eachBalance ne null }" >
							<td><fmt:formatNumber pattern="#,###" value="${ history.eachBalance }" />원</td>
						</c:if>
						<c:if test="${ history.eachBalance eq null }" >
							<td></td>
						</c:if>
						<td>
							<button name="mend"
								type="button"
								class="btn btn-primary">수정</button>
							<button name="cancel"
								type="button"
								style="display: none;"
								class="btn btn-warning">
								취소
							</button>
							<button name="deleteBtn"
								data-no="${ history.historyNo }"
								data-product-name="${ history.productName }"
								type="button"
								class="btn btn-danger">삭제</button>
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
		<input type="hidden" name="historyNo"/>
		<input type="hidden" name="productName"/>
	</form>
	
	<form id="modifyForm" method="post" action="/history/modify">
		<input type="hidden" name="historyNo"/>
		<input type="hidden" name="productName"/>
		<input type="hidden" name="price"/>
		<input type="hidden" name="amount"/>
	</form>
		
	<script>
		//수정
		$("button[name=mend]").on("click", function() {
			// 현재 tr을 가져오기
			var tr = $(this).parent().parent();
			
			// 현재 상태가 수정 모드인지 판별
			var isModify = tr.find("input[name=isModify]");
			if (isModify.val() == 0) {
				// 수정모드가 아니면 수정모드로 변경
				isModify.val("1");
			} else {
				// 수정 모드임 -> 실제 수정 작업
				var formData = $("#modifyForm");
				
				tr.find("input[name=hiddenTag]").each(function(_, elem) {
					var attrName = $(elem).data("attrName");
					var value = $(elem).val();
					formData.find("input[name=" + attrName + "]").val(value);
				});
				formData.find("input[name=historyNo]").val(tr.find("input[name=_historyNo]").val());
				formData.find("input[name=productName]").val(tr.find("input[name=_productName]").val());
				
				console.log($(formData).serialize());
				
				formData.submit();
				
				return;
			}
			
			// 취소 버튼 표시하기
			var cancelBtn = $(this).parent().find("button[name=cancel]");
			$(cancelBtn).show();
			
			// original 숨기기
			var originTags = tr.find("span[name=originTag]");
			originTags.each(function(_, elem) {
				$(elem).attr("style", "display: none;");
			});
			
			// hidden 표시하기
			var hiddenTags = tr.find("input[name=hiddenTag]");
			hiddenTags.each(function(_, elem) {
				var originType = $(elem).data("originType");
				elem.type = originType;
			});
		});
		
		// 취소 버튼
		$("button[name=cancel]").on("click", function() {
			var tr = $(this).parent().parent();
			
			var isModify = tr.find("input[name=isModify]");
			if (isModify.val() == 1) {
				isModify.val("0");
			}
			
			// original 표시하기
			var originTags = tr.find("span[name=originTag]");
			originTags.each(function(_, elem) {
				$(elem).show();
			});
			
			// hidden 숨기기
			var hiddenTags = tr.find("input[name=hiddenTag]");
			hiddenTags.each(function(_, elem) {
				elem.type = "hidden";
			});
			
			$(this).hide();
		});
		
		//삭제
		$("button[name=deleteBtn]").on("click", function(event) {
			
			var deleteBtn = event.target;
			
			var result = confirm("정말로 삭제 하시겠습니까?");
			
			if(result == true){
				var historyNo = $(deleteBtn).data("no");
				$('input[name=historyNo]').val(historyNo);
				var productName = $(deleteBtn).data("productName");
				$('input[name=productName]').val(productName);
				
				$('#form').submit();
			} else {
					
			}
		});
		
		//D-day 
		$("#cardList").on("change", function() {
			var option = $("#cardList option:selected").get()[0];
			var dayLeft = option.dataset["dayleft"];
			
			if (!dayLeft) {
				$("#dayLeft").text("-");
			} else {
				$("#dayLeft").text(dayLeft);
			}
		});

	</script>

</body>
</html>
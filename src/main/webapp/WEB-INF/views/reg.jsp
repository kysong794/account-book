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
		<select id="cardNo">
			<option value="">카드선택</option>
			<c:forEach items="${ findAll }" var="CardVo">
				<option value="${CardVo.cardNo }">${CardVo.cardName }</option>
			</c:forEach>
		</select>
		<label>번호 : </label>
		<input type="number" id="historyNo" value="${ historyNo }">
		<label>날짜 : </label>
		<input type="date" id="regDate" />
		<label>사용처 : </label>
		<input type="text" id="shopName" />
		<button type="button" id="addRow" class="btn btn-primary">추가</button>
		<table class="table table-hover">
			<colgroup>
				<col style="width: auto;"/>
				<col style="width: auto;"/>
				<col style="width: auto;"/>
				<col style="width: 15%;"/>
			</colgroup>
			<tbody id="row">
				<tr>	
					<td>상품명 :
						<input type="text" name="productName" />
					</td>
					<td>갯수 :
						<input type="number" name="amount" min="0" />
					</td>
					<td>개당가격 :
						<input type="number" name="price" min="0"/>
					</td>
					<td>
						
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
				html += 	'<td>상품명 : ';
				html += 		'<input type="text" name="productName" />';
				html += 	'</td>';
				html += 	'<td>갯수 : ';
				html += 		'<input type="number" name="amount" />';
				html += 	'</td>';
				html += 	'<td>개당가격 : ';
				html += 		'<input type="number" name="price" />';
				html += 	'</td>';
				html += 	'<td>';
				html += 		'<button type="button" class="btn btn-primary" onclick="deleteMe(this);">삭제</button>';
				html += 	'</td>';
				html += '</tr>';

			$("#row").append(html);
		});
		
		// submit 이벤트를 바인딩
		$("#form").on("submit", function(e) {
			e.preventDefault();
			
			// Person ( name = "john", age = 27 ), Person ( name = "david", age = 19 )
			// form => "name=john&age=27&name=david&age=19"
			// json => [{ name: "john", age: 27 }, { name: "david", age: 19 }]
			
			var cardNo = $("#cardNo").val();
			if (!cardNo) {
				alert("카드를 선택해 주세요");
				$("#cardNo").focus();
				return;
			}
			
			var historyNo = $("#historyNo").val();
			if (!historyNo) {
				alert("이력 번호를 찾을 수 없습니다");
				$("#historyNo").focus();
				return;
			}
			
			var regDate = $("#regDate").val();
			if (!regDate) {
				alert("날짜를 입력해 주세요");
				$("#regDate").focus();
				return;
			}
			
			var shopName = $("#shopName").val();
			if (!regDate) {
				alert("사용처를 입력해 주세요");
				$("#shopName").focus();
				return;
			}
			
			var formData = $(e.target);
			var trList = formData.find("tr").get();
			
			var resultList = [];
			
			for (var i = 0; i < trList.length-1; i++) {
				var tr = trList[i];
				var tdList = $(tr).find("td").get();
				
				var history = {};
				
				for (var j = 0; j < tdList.length-1; j++) {
					var td = tdList[j];
					var input = $(td).find("input").get()[0];
					
					history[input.name] = input.value;
				}
				
				history["cardNo"] = cardNo;
				history["historyNo"] = historyNo;
				history["regDate"] = regDate;
				history["shopName"] = shopName;
				
				resultList.push(history);
			}
			
			$.ajax({
				url: "/history/regSave",
				type: "POST",
				contentType: "application/json",
				data: JSON.stringify(resultList),
				success: function(res) {
					if (res === "success") {
						location.href = "/history/home";
					} else {
						alert("실패...");
					}
				},
				error: function(err) {
					alert("실패...");
				}
			});
		});

		function deleteMe(target) {
			// parent() -> jQuery 메서드, 한 단계 부모 요소를 가리킨다
			// children() -> jQuery 메서드, 한 단계 자식 요소를 가리킨다
			$(target).parent().parent().remove();
		}
	</script>
</body>
</html>
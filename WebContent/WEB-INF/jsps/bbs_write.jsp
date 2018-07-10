<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="../css/cpwallet/bootstrap.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>

<style>
h3 {
	color:#24981f;font-size:24px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
}
</style>
</head>
<body>
	<div class="container">
		<h3>판매 물품 목록 > 물품추가</h3>
		
		<div class="col-lg-4"></div>
		<div class="col-lg-12">
			<div class="jumbotron" style="padding-top: 20px;">

				<div class="row">				    
					<form name="form" method="post" action="/bbsWriteArticle.do">
						<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
							<thead>
								<tr>
									<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>작성자</td>
									<td><input type="text" class="form-control" placeholder="작성자" name="boardName" maxlength="50"></td>
								</tr>
								<tr>
									<td>마켓</td>
									<td><input type="text" class="form-control" placeholder="마켓" name="boardMarket" maxlength="50"></td>
								</tr>
								<tr>
									<td>상품명</td>
									<td><input type="text" class="form-control" placeholder="상품명" name="boardSubject" maxlength="50"></td>
								</tr>
								<tr>
									<td>금액</td>
									<td><input type="text" class="form-control" placeholder="금액" name="boardPrice" maxlength="50"></td>
								</tr>
								<tr>
									<td>지갑ID</td>
									<td><input type="text" class="form-control" placeholder="지갑ID" name="boardWalletId" value="cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct" maxlength="200"></td>
								</tr>
								<tr>
									<td>상품정보</td>
									<td><textarea class="form-control" placeholder="내용" name="boardContent" maxlength="2048" style="height: 150px;"></textarea></td>
								</tr>
								<tr>
									<td>비밀번호</td>
									<td><input type="text" class="form-control" placeholder="비밀번호" name="boardPass" maxlength="10" style="width:100px;"></td>
								</tr>
							</tbody>					
						</table>
						<div style="text-align: center;">
							<a href="javascript:onclick=document.form.submit();" class="btn btn-primary">등록</a>
							<a href="javascript:onclick=document.form.reset();" class="btn btn-primary">취소</a>
							<a href="/bbs.do" class="btn btn-primary">목록</a>
						</div>
					</form>
				</div>
					
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>
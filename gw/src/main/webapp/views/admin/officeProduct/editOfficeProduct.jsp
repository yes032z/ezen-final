<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../inc/adminTop.jsp"%>

<link href="<c:url value='/vendors/choices/choices.min.css'/>"
	rel="stylesheet">
<link href="<c:url value='/vendors/flatpickr/flatpickr.min.css'/>"
	rel="stylesheet">
<link href="<c:url value='/vendors/dropzone/dropzone.min.c.css'/>"
	rel="stylesheet">

<style type="text/css">
	.mb-2 {
		color: #0E1726;
	}
	
	.card {
		background: white;
		color: #0E1726;
	}
	
	.form-select {
		background: white;
		color: #0E1726;
	}
	
	.form-control {
		background: white;
		color: #0E1726;
	}
</style> 
<div class="content">
	<div class="card mb-3">
		<div class="card-body">
			<h5 class="mb-2 mb-md-0">
				<strong>자원 수정</strong>
			</h5>
		</div>
	</div>
	<div class="row g-0">
		<div class="card mb-3">
			<div class="card-body">
				<form class="dropzone dropzone-multiple p-0" name = "editList"
					id="update" data-dropzone="data-dropzone"
					method="post">
					<div class="row gx-2">
						<label class="form-label" for="product-name">종류</label> 
						<select class="form-select" aria-label="Default select example" name = "category" >
							<option selected>선택하세요.</option>
							<option value="meetingRoom"
								<c:if test="${remanVo.category =='meetingRoom' }">
									selected="selected"
								</c:if>>회의실</option>
							<option value="noteBook"
								<c:if test = "${remanVo.category =='noteBook' }">
									selected = "selected"
								</c:if>>노트북</option>
							<option value="rentCar"
								<c:if test = "${remanVo.category == 'rentCar' }">
									selected = "selected"
								</c:if>>차량</option>
						</select>
						<div class="col-12 mb-3" s>
							<br> 
							<input type="hidden" name = "remanNo" value="${remanVo.remanNo }">
							<label class="form-label" for="product-name">자원 이름</label> 
							<input class="form-control" id="name" name="name" type="text" value="${remanVo.name }"/>
						</div>
						<div class="col-12 mb-3">
							<label class="form-label" for="product-description">설명</label>
							<div class="create-product-description-textarea">
								<textarea class="form-control" data-tinymce="data-tinymce"
									name="discription" id="product-description"
									style="height: 200px">${remanVo.discription }</textarea>
							</div>
							<br> 
							<label class="form-label" for="product-name">담당자</label>
							<input class="form-control" id="product-name" name="manager"
								type="text" value="${remanVo.manager }" />
						</div>
					</div>
					<br> <label class="form-label" for="product-name">자원 상태</label>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="checkbox" id="state" name = "state" value="1"
							<c:if test = "${remanVo.state == 1 }">
								checked="checked"
							</c:if>> 
						<label class="form-check-label" for="inlineCheckbox1">이용 가능</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="checkbox" id="state" name = "state" value="2"
							<c:if test = "${remanVo.state ==2 }">
								checked = "checked"
							</c:if>> 
						<label class="form-check-label" for="inlineCheckbox2">이용 불가</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="checkbox" id="state" name = "state" value="3" 
							<c:if test = "${remanVo.state ==3 }">
								checked = "checked"
							</c:if>> 
						<label class="form-check-label" for="inlineCheckbox3">관리자 문의</label>
					</div>
				</div>
			</div>
		</div>
		<div class="card mt-3">
			<div class="card-body">
				<div class="row justify-content-between align-items-center">
					<div class="col-auto">
						<button class="btn btn-primary" id="bt1" type="submit">수정</button>
						<button class="btn btn-primary" id="cancle">취소</button>
					</div>
				</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../../inc/adminBottom.jsp"%>
<script type="text/javascript" src="<c:url value='/js/market.js'/>"></script>
<script type="text/javascript">
	$(function(){
		$('#bt1').click(function(){
			console.log(12);
			if($('#name').val().length<1){
				alert("자원 이름을 입력하세요.");
				$('#product-name').focus();
				
				return false;
			}
			
			if($('#category').val().length<1){
				alert("자원 종류를 선택하세요.");
				$('#category').focus();
				
				return false;
			}
			
			if(!$('input[name=state]').is(':checked')){
				alert("자원 상태를 선택해주세요.");
				
				return false;
			}
			
			if($('#product-manager').val().length<1){
				alert("담당자를 기재해주세요.");
				$('#product-manager').focus();
				
				return false;
			}
			
			if($('#product-description').val().length<1){
				alert("자원 내용을 입력해주세요.");
				$('#product-description').focus();
				
				return false;
			}
			if(confirm("수정하시겠습니까?")){
				$.ajax({
					url:"/admin/officeProduct/ajaxeditOfficeProduct",
					type:"post",
					datatype:"json",
					data:$('#update').serialize(),
					success:function(result){
						if(result >0){
							window.close();
							
							opener.location.reload();
						}else{
							alert("오류가 발생했습니다.");
						}
					},
					error:function(xhr, status, error){
						console.error("실패 :", status, error)
					}
				});
			}
		});
			
		$('#cancle').click(function(){
			event.preventDefault();
			window.close();
		});
	});
		
	
	
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file='../../inc/adminTop.jsp'%>
<link rel="stylesheet" href="<c:url value='/css/adminempform.css'/>">
<script src="<c:url value='/vendors/ckeditor/ckeditor.js'/>"></script>
<script src="<c:url value='/vendors/ckeditor/lang/ko.js'/>"></script>
<script type="text/javascript">
	$(function(){
		$('#btnFaqEdit').click(function(){
			event.preventDefault();
			var modalCheck=false;
			
			var count= $('input[type=checkbox]:checked').length;
			if(count==1){
				var boardNo=$('input[type=checkbox]:checked').val();
				alert(boardNo);
				
				$.ajax({
		            url: "<c:url value='/admin/board/ajaxSelectOneFAQ'/>",
		            type:'get',
					data: {boardNo: boardNo},
					dataType:'json',
		            success: function (res) {
		            	$('#title').empty();
		            	CKEDITOR.instances.editor.getData().empty();
		            	
		            	var receivedData = res;
		            	var boardNo=receivedData.boardNo;
		            	var title=receivedData.title;
		            	var content=receivedData.content;
		            	
		            	result="<input type='text' class='form-control admindefault' id='title' name='title' value='"+title+"'/>";
		            	result2="<textarea id='editor' name='content'>"+content+"</textarea>";
		            	
		            	$('#updateTitle').append(result);
		            	$('#updateContent').append(result2);
		            	modalCheck=true;
		            	if(modalCheck){
		            		$('#exampleModal2').modal('show');
		            	}	
		            	
		            },
		            error:function(xhr,status,error){
		                alert(status+" : "+error);
		            } 
		        });//ajax
			}else if(count<1){
				alert('수정할 FAQ 게시글을 체크 바랍니다.');
			}else if(count>1){
				alert('수정할 FAQ 게시글을 하나만 체크 바랍니다.');
			}
		});
	});
	
	function pageFunc(curPage){
		$('input[name="currentPage"]').val(curPage);
		$('form[name="frmPage"]').submit();
	}
	
	function submitForm() {
	    document.getElementById('frmSearch').submit();
	}
</script>
 <!-- 페이징 처리 관련 form -->
<form action="<c:url value='/admin/board/faqList'/>" 
	name="frmPage" method="get">
	<input type="hidden" name="currentPage" value=${param.currentPage }>
	<input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
	<input type="hidden" name="searchCondition" value="${param.searchCondition}">
</form>
<div class="card mb-3">
	<div class="card-body admindefault position-relative">
		<div class="row">
			<div class="col-lg-12">
				<h3 class="admindefault">FAQ</h3>
				<div class="col-auto">
					<div class="input-group admindefault">
						<form name="frmSearch" action='<c:url value='/admin/board/faqList'/>'>
						<div class="row flex-between-center">
						<div class="col-auto pe-0">
							<select name="searchCondition" class="form-select admindefault">
	                            <option value="title"
	                            	<c:if test="${param.searchCondition=='title'}">
	                            		selected = "selected"
	                            	</c:if>
	                            >제목</option>
	                            <option value="content"
	                            	<c:if test="${param.searchCondition=='content'}">
	                            		selected = "selected"
	                            	</c:if>
	                            >내용</option>
                          </select>
						</div>
						<div class="col-auto">
							<div class="input-group">
								<input name="searchKeyword"
									class="form-control shadow-none search admindefault"
									value='${param.searchKeyword}' type="search"
									placeholder="검색어 입력" aria-label="search" />
								<button
									class="btn btn-sm btn-outline-secondary border-300 hover-border-secondary">
									<span class="fa fa-search fs--1"></span>
								</button>
							</div>
						</div>
						<div class="col-auto mt-3">
							<div class="admindefault adminempdiv13" id="table-contact-replace-element">
								<input type="button" value="등록" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#exampleModal"/>
								<span class="adminhyphen"></span>
								<input type="button" value="수정" id="btnFaqEdit" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#exampleModal2"/>
								<span class="adminhyphen"></span>
								<input type="button" value="삭제" class="btn btn-outline-danger"/>
							</div>
						</div>
						</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<div class="card">
      <div class="card-body admindefault">
       <div class="col-auto searchEmpResult admindefault" style="padding: 10px 0 0 25px;">
			<c:if test="${!empty param.searchKeyword }">
			   <p>검색어 : ${param.searchKeyword} , <span style="font-weight: bold; color: red;">${pagingInfo.totalRecord}</span> 건 검색되었습니다.</p>
			</c:if>   
		</div>
        <div class="accordion border rounded overflow-hidden" id="accordionFaq">
          <c:if test="${!empty faqList }">
          <c:forEach var="boardVo" items="${faqList }">
          <div class="card shadow-none rounded-bottom-0 border-bottom">
            <div class="accordion-item border-0">
              <div class="card-header p-0 d-flex align-items-center adminempdiv12" id="faqAccordionHeading${boardVo.boardNo }">
               <input class="form-check-input me-2" type="checkbox" name="boardNo" value="${boardVo.boardNo}"/>
                <button class="accordion-button btn btn-link text-decoration-none d-block w-100 py-2 px-3 collapsed border-0 text-start rounded-0 shadow-none" 
                data-bs-toggle="collapse" data-bs-target="#collapseFaqAccordion${boardVo.boardNo }" aria-expanded="false" aria-controls="collapseFaqAccordion${boardVo.boardNo }">
                <span class="fas fa-caret-right accordion-icon me-3" data-fa-transform="shrink-2"></span>
                <span class="fw-medium font-sans-serif text-900">${boardVo.title }</span>
                </button>
              </div>
              <div class="accordion-collapse collapse" id="collapseFaqAccordion${boardVo.boardNo }" 
              aria-labelledby="faqAccordionHeading${boardVo.boardNo }" data-parent="#accordionFaq">
                <div class="accordion-body p-0 admindefault">
                  <div class="card-body pt-2">
                    <div class="ps-3 mb-0">
                      <p>${boardVo.content }</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
		</c:forEach>
		</c:if>
		</div>
	<div class="card-footer d-flex justify-content-center admindefault">
	<div class="divPage" id="divPage">
		<!-- 페이지 번호 추가 -->		
		<!-- 이전 블럭으로 이동 -->
		<c:if test="${pagingInfo.firstPage>1 }">
			<a href="#" id="prevPage" onclick="pageFunc(${pagingInfo.firstPage-1})">
				<img src="<c:url value='/images/first.JPG'/>">
			</a>
		</c:if>	
						
		<!-- [1][2][3][4][5][6][7][8][9][10] -->
		<c:forEach var="i" begin="${pagingInfo.firstPage }" end="${pagingInfo.lastPage }">		
			<c:if test="${i == pagingInfo.currentPage }">		
				<span id="curPage">${i}</span>
	        	</c:if>
			<c:if test="${i != pagingInfo.currentPage }">		
		        <a href="<c:url value='/admin/board/noticeList?currentPage=${i}&searchKeyword=${param.searchKeyword }&searchCondition=${param.searchCondition }'/>" id="otherPage">${i}</a>
		    </c:if>   		
		</c:forEach>
		
		<!-- 다음 블럭으로 이동 -->
		<c:if test="${pagingInfo.lastPage < pagingInfo.totalPage }">
	         <a href="#" id="nextPage" onclick="pageFunc(${pagingInfo.lastPage+1})">
				<img src="<c:url value='/images/last.JPG'/>">
			</a>
		</c:if>
		<!--  페이지 번호 끝 -->
	</div>
</div>
</div>
</div>


<div class="modal fade" id="exampleModal2" tabindex="-1" 
	aria-labelledby="exampleModalLabel2" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content admindefault" style="width: 700px;">
      <div class="modal-header">
        <h5 class="modal-title admindefault" id="exampleModalLabel2">FAQ 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<table class="table table-bordered">
			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 80%;" />
			</colgroup>
			<tbody id="table-contact-body">
				<form id="updateFaq">
				<tr class="adminemptr">
					<td class="align-middle">FAQ 제목</td>
					<td class="align-middle">
					<div id="updateTitle"></div>
					</td>
				</tr>
				<tr class="adminemptr">
					<td class="align-middle">FAQ 내용</td>
					<td class="align-middle">
					<div id="updateContent"></div>
					</td>
				</tr>
			</form>
			</tbody>
		</table>
      </div>
      <div class="modal-footer" style="text-align: center;">
        <input type="submit" value="수정" class="btn btn-primary">
        <input type="button" value="취소" class="btn btn-secondary" id="btnCancel">
      </div>
    </div>
  </div>
</div> 
<script>
	CKEDITOR.replace('editor', {
		filebrowserUploadUrl: '<c:url value="/admin/board/fileupload"/>'
	});
</script>
<%@ include file='faqWrite.jsp'%>
<%@ include file='../../inc/adminBottom.jsp'%>
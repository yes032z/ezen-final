<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<link rel="stylesheet"href="<c:url value='/css/mypageempform.css'/>">
<script type="text/javascript">
	function pageFunc(curPage){
		$('input[name="currentPage"]').val(curPage);
		$('form[name="frmPage"]').submit();
	}
	
	function submitForm() {
	    document.getElementById('frmSearch').submit();
	}
	function empDetail(empNo) {
	    window.open("<c:url value='/mypage/empDetail?empNo='/>"+empNo,'empDetail', 'width=320,height=550,top=300,left=700,location=yes,resizable=yes');
	}
</script>
<!-- 페이징 처리 관련 form -->
<form action="<c:url value='/board/deptBoard'/>" 
	name="frmPage" method="post">
	<input type="hidden" name="currentPage">
	<input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
	<input type="hidden" name="searchCondition" value="${param.searchCondition}">
	<input type="hidden" name="boardlistNo" value="${param.boardlistNo }">
</form>
<div class="row g-3 mb-3">
	<div class="col-xxl-3">
		<div class="card h-100 ">
			<div class="card-header d-flex flex-between-center">
						<h5 class="mb-0">
						<a style="text-decoration: none; color: black;" 
							href="<c:url value='/board/deptBoard'/>">
						<span class="fas fa-file" style="margin: 0 10px;"></span>
						부서 게시판 목록</a>
						</h5>
					</div>
					<div class="card-body">
					<c:if test="${empty deptBoardList }">
						비어있음
					</c:if>
					<c:if test="${!empty deptBoardList }">
						<c:forEach var="deptBoardVo" items="${deptBoardList }">
						<img src="<c:url value='/images/last.JPG'/>">
							<a href="<c:url value='/board/deptBoard?boardlistNo=${deptBoardVo.boardlistNo }'/>"
								style="text-decoration: none; color:#5e6e82;">
							${deptBoardVo.boardName }</a><br>
						</c:forEach>
					</c:if>
					</div>
				</div>
			</div>
				<div class="col-md-9">
				<div class="card h-100">
				<c:if test="${empty param.boardlistNo }">
					<div style="margin:50px 0px 0 150px;"><h1>부서 게시판을 선택해주세요.</h1></div>
				</c:if>
				<c:if test="${!empty param.boardlistNo }">
					<div class="card-header py-2">
					<h5 class="mb-0">
					<span class="fas fa-file" style="margin: 0 10px;"></span>
					${boardlistVo.boardName} 게시판
					</h5>
			</div>
			<div class="card-body py-2 ">
				<div class="card" id="allContactTable">
					<div class="card-header border-bottom border-200 px-0 ">
						<div class="d-lg-flex justify-content-between">
							<form name="frmSearch" method="post" action="<c:url value='/board/deptBoard'/>">
								<div class="row flex-between-center gy-2 px-x1">
									<div class="col-auto pe-0 ">
										<input type="hidden" name="boardlistNo" value="${param.boardlistNo }"/>
										<select name="searchCondition" class="mypageempborder mypageempsel">
											<option value="title"
												<c:if test="${param.searchCondition=='title'}">
								            		selected="selected"
								            	</c:if> 
											>제목</option>
											<option value="content"
												<c:if test="${param.searchCondition=='content'}">
								            		selected="selected"
								            	</c:if> 
											>내용</option>
										</select>
									</div>
									<div class="col-auto">
										<div class="input-group input-search-width ">
											<input name="searchKeyword" value="${param.searchKeyword }" class="form-control shadow-none search "
												type="search" placeholder="검색어 입력" aria-label="search" />
											<button onclick="submitForm()" id="btnSearch"
												class="btn btn-sm btn-outline-secondary border-300 hover-border-secondary">
												<span class="fa fa-search fs--1"></span>
											</button>
										</div>
									</div>
								</div>
							</form>
							<div class="border-bottom border-200 my-3"></div>
							<div class="d-flex align-items-center justify-content-between justify-content-lg-end px-x1 ">
								<div class="d-flex align-items-center "
									id="table-contact-replace-element">
								<a href="<c:url value='/board/deptBoardWrite?boardlistNo=${param.boardlistNo }'/>" class="btn btn-primary">등록</a>
								</div>
							</div>
						</div>
					</div>
						<div class=" searchEmpResult" style="padding: 10px 0 0 25px;">
							<c:if test="${!empty param.searchKeyword }">
							   <p>검색어 :${param.searchKeyword} , <span style="font-weight: bold; color: red;">${pagingInfo.totalRecord}</span> 건 검색되었습니다.</p>
							</c:if>   
						</div>
					<div class="card-body p-0 ">
						<div class="table-responsive scrollbar ">
							<table class="table table-sm table-hover">
					<colgroup>
						<c:if test="${boardlistVo.secflag=='Y'}">
							<c:if test="${boardlistVo.boardLike=='Y'}">
							<col style="width: 20%;" />
							<col style="width: 15%;" />
							<col style="width: 25%;" />
								<col style="width: 20%;" />
								<col style="width: 10%;" />
								<col style="width: 10%;" />
							</c:if>
							<c:if test="${boardlistVo.boardLike=='N'}">
							<col style="width: 20%;" />
							<col style="width: 15%;" />
							<col style="width: 30%;" />
								<col style="width: 20%;" />
								<col style="width: 15%;" />
							</c:if>
						</c:if>	
						<c:if test="${boardlistVo.secflag=='N'}">
							<c:if test="${boardlistVo.boardLike=='Y'}">
								<col style="width: 50%;" />
								<col style="width: 20%;" />
								<col style="width: 15%;" />
								<col style="width: 15%;" />
							</c:if>
							<c:if test="${boardlistVo.boardLike=='N'}">
							<col style="width: 50%;" />
								<col style="width: 30%;" />
								<col style="width: 20%;" />
							</c:if>
						</c:if>	
					</colgroup>
					<thead class="mypageempthead">
						<tr style="text-align: center;">
							<c:if test="${boardlistVo.secflag=='Y'}">
							<th class="align-middle py-2 fs-0 pe-2" scope="col" data-sort="name">작성자</th>
							<th class="align-middle" scope="col" data-sort="dept">부서</th>
							</c:if>
							<th class="align-middle" scope="col" data-sort="title">제목</th>
							<th class="align-middle" scope="col" data-sort="regdate">등록일</th>
							<th class="align-middle" scope="col" data-sort="readcount">조회수</th>
							<c:if test="${boardlistVo.boardLike=='Y'}">
							<th class="align-middle" scope="col" data-sort="likecount">추천수</th>
							</c:if>
						</tr>
					</thead>
					<tbody>
						<!-- 반복 시작  -->
						<c:forEach var="map" items="${boardList}">
							<tr>
								<c:if test="${boardlistVo.secflag=='Y'}">
								<td class="align-middle fs-0 py-3">
								 	<div class="d-flex align-items-center gap-2 position-relative">
										<div class="avatar avatar-xl mypageempdiv14">
											<div>
												<img class="rounded-circle" src="<c:url value='/images/${map["IMAGE"]}'/>">
											</div>
										</div>
										<a href="#" onclick="empDetail(${map.EMP_NO});" 
											style="text-decoration:none; color: #5e6e82;">${map['NAME']}
										</a>
									</div>
								</td>
								<td class="align-middle">
									<div class="mypageempdiv14">
									${map['DEPT_NAME']}
									</div>
								</td>
								</c:if>
								<td class="align-middle fs-0 py-3">
									<div class="mypageempdiv14">
									<a href="<c:url value='/board/deptBoardDetail?boardlistNo=${map.BOARDLIST_NO}&boardNo=${map.BOARD_NO}'/>">
									${map['TITLE']}
									<c:if test="${map['timeNew']==1}">
										<img alt="New이미지" src="<c:url value='/images/new.jpg'/>">
									</c:if>
									<c:if test="${boardlistVo.commentFlag=='Y'}">
										<c:if test="${map['commentCount']>0}">
										[${map['commentCount']}]
										</c:if>
									</c:if>
									</a>
									</div>
								</td>
								<td class="align-middle">
									<div class="mypageempdiv14">
										<fmt:formatDate value="${map['REGDATE']}" pattern="yyyy-MM-dd"/>
									</div>
								</td>
								<td class="align-middle">
								<div class="mypageempdiv14">
									${map['READCOUNT']}
								</div>
								</td>
								<c:if test="${boardlistVo.boardLike=='Y'}">
								<td class="align-middle">
								<div class="mypageempdiv14">${map['LIKECOUNT']}</div></td>
								</c:if>
							</tr>
						</c:forEach>
						<!-- 반복 끝 -->
					</tbody>
				</table>
						</div>
					</div>
					<div class="card-footer d-flex justify-content-center ">
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
							         <a href="#" id="otherPage" onclick="pageFunc(${i})">${i}</a>
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
			</c:if>
			</div>
		</div>
	</div>
<%@ include file="../inc/bottom.jsp"%>
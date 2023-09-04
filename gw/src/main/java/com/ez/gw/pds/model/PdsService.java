package com.ez.gw.pds.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.ez.gw.board.model.BoardVO;
import com.ez.gw.common.SearchVO;

import jakarta.servlet.http.HttpServletRequest;

public interface PdsService {
	int insertPds(BoardVO vo);
	List<Map<String, Object>> selectPdsAll(SearchVO vo);
	Map<String, Object> selectPds(int boardNo);
	int updatePds(BoardVO vo);
	int deletePds(int boardNo);
	int editPdsFile(@Param("boardNo") int boardNo, @Param("oldFileName") String oldFileName); 
	int insertFiles(PdsVO vo); //파일 업로드 
	List<PdsVO> selectFilesByBoardNo(int boardNo); // 게시글 번호로 파일 리스트 조회
	int updateDownloadCount(int boardNo);
	int getTotalRecord(SearchVO vo);
	int selectIsFile(int boardNo);
	List<PdsVO> selFilesByNotice(int boardNo); // 공지사항 디테일 파일 리스트 조회
	List<PdsVO> select24AnonymousImage();
	int deleteAnonymousImg(PdsVO vo); //익명게시판 이미지 삭제
	List<PdsVO> selFilesByDeptBoard(BoardVO boardVo); //부서 게시판 파일 등록
	List<Map<String, Object>> selectAdminPdsAll(SearchVO searchVo); // 관리자 - 파일목록 전체 조회
	int editNoticeFile(int pdsNo);
	int deleteMulti(List<PdsVO> list); //관리자 - 파일 다중 삭제
	int getAdminTotalFile(SearchVO searchVo); // 파일 총 갯수 구하는 메서드
	int deleteBoardMulti(HttpServletRequest request, List<BoardVO> list); //관리자 - 자료실 게시글 다중 삭제
	int editDeptBoardFile(int pdsNo); // 부서게시판 - 수정중 파일 삭제 메서드
	int insertPdsByAnonymous(PdsVO vo);
	int clubFiles(PdsVO pdsVo); //동호회 파일 업로드
	
	//NEW5
	List<BoardVO> selectPdsNew5(); //자료실 new5 게시글 조회
}

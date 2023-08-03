package com.ez.gw.board.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ez.gw.common.SearchVO;

@Mapper
public interface BoardDAO {
	int insertQna(BoardVO vo); //Qna 글등록 메서드
	List<Map<String, Object>> selectQnaAll(SearchVO searchVo); //Qna 글 리스트 목록 조회 메서드
	Map<String, Object> selectQna(int boardNo); //qna 글 1개 디테일 조회 메서드
	int updateReadcount(int boardNo); //조회수 증가 메서드
}

package com.ez.gw.club.model;

import java.util.List;
import java.util.Map;

import com.ez.gw.clubboard.model.ClubBoardVO;
import com.ez.gw.common.SearchVO;

public interface ClubService {
	int insertClub(ClubVO vo);
	List<Map<String, Object>> selectClub(SearchVO searchVo);
	ClubVO selectByClubNo(int clubNo);
	int updateClub(ClubVO vo);
	int deleteClub(int clubNo);
	int deleteMulti(List<ClubVO> list); //관리자 다중 삭제
}

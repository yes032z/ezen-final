package com.ez.gw.commute.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommuteDAO {
	List<CommuteVO> selectCommuteByEmpNo(int empNo); //사원번호로 해당 사원의 출퇴근 기록 전체 조회 메서드
	int insertWorkIn(int empNo); //출근 시간 인서트
	int updateWorkOut(int empNo); //퇴근 시간 업데이트
	int selectIsWorkIn(int empNo); //당일 출근 기록있는지 확인 메서드
	int selectIsWorkOut(int empNo); //당일 퇴근 기록있는지 확인 메서드
	
	int updateCommuteState(CommuteVO vo); // 오전 9시 이후로 출근하면 근태 상태가 1 지각으로 바뀌는 메서드
	int updateCommuteStateEalry(int empNo); //오후 6시 이전에 퇴근하면 근태 상태가 5 조퇴로 바뀌는 메서드
	int selectLateState(int empNo); //지각인지 현재 상태 조회하는 메서드
	int updateCommuteStateTotal(int empNo); // 지각 + 조퇴면 3으로 바뀌는 메서드
}

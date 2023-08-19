package com.ez.gw.employee.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.gw.common.ConstUtil;
import com.ez.gw.common.FileUploadUtil;
import com.ez.gw.common.SearchVO;
import com.ez.gw.dept.model.DeptService;
import com.ez.gw.dept.model.DeptVO;
import com.ez.gw.employee.model.EmployeeService;
import com.ez.gw.employee.model.EmployeeVO;
import com.ez.gw.position.model.PositionService;
import com.ez.gw.position.model.PositionVO;
import com.oracle.wls.shaded.org.apache.xpath.operations.Mod;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EmployeeController {
	private static final Logger logger=LoggerFactory.getLogger(EmployeeController.class);
	private final EmployeeService employeeService;
	private final DeptService deptService;
    private final PositionService positionService;
    private final FileUploadUtil fileuploadUtil;
    
	@GetMapping("/admin/employee/employeeRegister")
	public String empRegister_get(Model model) {
		logger.info("관리자 - 사원등록 페이지");
		List<DeptVO> deptList = deptService.selectAllDept();
		List<PositionVO> positionList=positionService.selectAllPosition();
		logger.info("부서&직위 전체목록 조회 결과, dpetList={}, positionList= {}", deptList, positionList);
		
		model.addAttribute("deptList",deptList);
		model.addAttribute("positionList",positionList);
		return "admin/employee/employeeRegister";
	}
	
	@PostMapping("/admin/employee/employeeRegister")
	public String productWrite_post(@ModelAttribute EmployeeVO vo
			, HttpServletRequest request, Model model) {
		logger.info("사원 등록 처리 파라미터 vo={}", vo);
		//이미지업로드 처리
		String fileName="", originalFileName="";
		long fileSize=0;
		try {
			List<Map<String, Object>> list
				=fileuploadUtil.fileupload(request, ConstUtil.UPLOAD_IMAGE_FLAG);
			
			for(Map<String, Object> map:list) {
				fileName=(String) map.get("fileName");
				originalFileName=(String) map.get("originalFileName");
				fileSize=(long) map.get("fileSize");
			}
			
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		vo.setImage(fileName);
		//db
		int cnt=employeeService.insertEmp(vo);
		logger.info("사원 등록 처리 결과 cnt={}",cnt);
		
	    String msg = "사원 등록에 실패했습니다.", url = "/admin/employee/employeeRegister";
        if (cnt > 0) {
            msg = "사원번호 생성이 완료되었습니다.";
        }
        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        return "common/message";
	}
	
	@RequestMapping("/mypage/empDetail")
	public String empDetail(@RequestParam (defaultValue = "0") int empNo, Model model) {
		logger.info("조직도- 사원 디테일 페이지 보기 파라미터 empNo={}", empNo);
		
		EmployeeVO empVo=employeeService.selectByEmpNo(empNo);
		logger.info("사원 디테일 조회 결과, empVo={}", empVo);
		
		model.addAttribute("empVo", empVo);
		
		return "mypage/empDetail";
	}
	
	@RequestMapping("/mypage/ajaxSearchEmp")
	@ResponseBody
	public List<Map<String, Object>> searchEmpList(@ModelAttribute SearchVO searchVo){
		logger.info("ajax 이용, 조직도 사원 검색- 파라미터 searchVo={}", searchVo);
		
		List<Map<String, Object>> searchList=employeeService.selectSearchEmp(searchVo);
		logger.info("ajax 이용, 조직도 사원 검색 결과 - searchList.size()={}", searchList.size());
		return searchList;
	}
	
	@GetMapping("/mypage/empInfoEdit")
	public String empEdit(HttpSession session,Model model) {
		int empNo=(int)session.getAttribute("empNo");
		logger.info("사원 정보 수정 페이지, 파라미터 empNo={}", empNo);
		Map<String, Object> map=employeeService.selectEmpByEmpNo(empNo);
		logger.info("사원 정보 수정 페이지 결과 map={}", map);
	    model.addAttribute("map", map);
		return "mypage/empInfoEdit";
	}
	
	@PostMapping("/mypage/empInfoEdit")
	public String empEdit_post(@ModelAttribute EmployeeVO empVo,
			HttpSession session, Model model) {
		int empNo=(int)session.getAttribute("empNo");
		empVo.setEmpNo(empNo);
		logger.info("사원 - 사원정보 수정처리 파라미터 empVo={}", empVo);
		
		int result=employeeService.loginCheck(empVo.getPwd(),empVo.getEmpNo());
		logger.info("비밀번호 체크 결과 result={}",result);
		
		String msg="정보 수정에 실패했습니다.", url="/mypage/empInfoEdit";
		if(result==employeeService.LOGIN_OK) {
			int cnt=employeeService.updateEmpInfo(empVo);
			logger.info("사원정보 수정결과 cnt={}", cnt);
			if(cnt>0) {
				msg="정보 수정이 완료되었습니다.";
			}
		}else if(result==employeeService.PWD_DISAGREE) {
			msg="비밀번호가 일치하지 않습니다.";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@GetMapping("/inc/empMain")
	public String empMain(HttpSession session,Model model) {
		int empNo=(int)session.getAttribute("empNo");
		logger.info("사원메인 정보 페이지, 파라미터 empNo={}", empNo);
		Map<String, Object> map=employeeService.selectEmpByEmpNo(empNo);
		logger.info("사원메인 정보 페이지 결과 map={}", map);
		model.addAttribute("map", map);
		return "inc/empMain";
	}
	
	@GetMapping("/mypage/pwdEdit")
	public String pwdEdit(@RequestParam(defaultValue = "0") int empNo, Model model){
		logger.info("사원 비밀번호 변경 페이지 파라미터 empNo={}", empNo);
		Map<String, Object> map=employeeService.selectEmpByEmpNo(empNo);
		logger.info("사원 비밀번호 변경 페이지 결과 map={}", map);
	    model.addAttribute("map", map);
		return "mypage/pwdEdit";
	}
	
	@PostMapping("/mypage/pwdEdit")
	public String pwdEdit_post(@ModelAttribute EmployeeVO empVo,
			HttpSession session, Model model) {
		int empNo=(int)session.getAttribute("empNo");
		empVo.setEmpNo(empNo);
		logger.info("사원 - 비밀번호 수정처리 파라미터 empVo={}", empVo);
		
		int cnt=employeeService.updateEmpPwd(empVo);
		logger.info("사원 - 비밀번호 수정결과 cnt={}", cnt);
		String msg="비밀번호 수정에 실패했습니다.", url="/mypage/pwdEdit";
		if(cnt>0) {
				msg="비밀번호 수정이 완료되었습니다.";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
}



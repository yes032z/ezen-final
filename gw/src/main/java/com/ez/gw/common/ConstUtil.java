package com.ez.gw.common;

public interface ConstUtil {
	//게시판 페이징 처리 관련 상수
	public static final int RECORD_COUNT=10;
	int BLOCK_SIZE=10;
	
	//파일 업로드 처리 관련 상수
	String FILE_UPLOAD_TYPE = "test";
	//String FILE_UPLOAD_TYPE = "deploy";
	
	//자료실 파일 저장 경로
	String FILE_UPLOAD_PATH = "pds_upload";
	
	//집
	//String FILE_UPLOAD_PATH_TEST = "C:\\Users\\pc\\git\\final\\gw\\src\\main\\webapp\\pds_upload";
	//학원
	String FILE_UPLOAD_PATH_TEST = "C:\\Users\\ezen\\git\\final\\gw\\src\\main\\webapp\\pds_upload";
	
	
	//관리자 페이지 - 사원 이미지 저장 경로
	String IMAGE_FILE_UPLOAD_PATH = "images";
	String IMAGE_FILE_UPLOAD_PATH_TEST = "D:\\lecture\\workspace_list\\sp_final_ws\\final\\gw\\src\\main\\webapp";
	
	//자료실 업로드인지, 상품 등록시 업로드인지 구분값
	int UPLOAD_FILE_FLAG = 1;  //자료실 업로드
	int UPLOAD_IMAGE_FLAG = 2; //사원 등록시 이미지 업로드
	
	
}

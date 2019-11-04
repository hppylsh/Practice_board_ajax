package egovframework.edu.bbs.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;


public interface Cs_BoardService {
	
	// 리스트 출력하기
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map);
	
	// 공지사항 출력
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map);
	
	//게시글 상세내용 출력하기
	public Map<String, Object> selectBoardDetail(Map<String, Object> map);
	
	// 게시글 입력하기
	public void insertWrite(Map<String, Object> commandMap);
	
	// 게시판 리스트 출력하기
	public List<Map<String, Object>> selectBbsList(Map<String, Object> map);
	
	// 게시판 수정폼
	public Map<String, Object> selectBbsDetail(Map<String, Object> map);

	// 게시판 리스트 수정
	public void updateBbsDetail(Map<String, Object> commandMap);

	// 게시판 리스트 입력
	public void insertBbs(Map<String, Object> commandMap);

	// 사이드바 출력
	public List<Map<String, Object>> selectSidebar(Map<String, Object> commandMap);
	
	// 게시글 삭제 처리(수정)
	public void updateDelete(Map<String, Object> commandMap);
	
	// 게시글 갯수 세기(페이징)
	public int selectCountList(Map<String, Object> map);
	
	// 조회수 올리기
	public void updateHitCnt(Map<String, Object> commandMap);
	
	// 게시글 수정
	public void updateBoard(Map<String, Object> commandMap);
	
	public Map<String, Object> selectBbsCondition(Map<String, Object> map);
	
	// 검색 옵션
	public Map<String, Object> selectSearchOption();
	

}

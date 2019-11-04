package egovframework.edu.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import egovframework.edu.bbs.service.Cs_BoardService;
import oracle.sql.DATE;

@Service("BoardService")
public class Cs_BoardServiceImpl implements Cs_BoardService {

	@Resource
	private Cs_BoardDAO dao;

	// 게시글 리스트 출력하기
	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) {
		
		List<Map<String,Object>> list = dao.selectBoardList(map);
		return list;

	}
	
	// 공지사항(게시글) 리스트 출력하기
	@Override
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) {
		
		return dao.selectNoticeList(map);
	}

	// 게시글 상세페이지 읽기
	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("detail", dao.selectBoardDetail(map));
		resultMap.put("leg", dao.selectLeg(map));
		resultMap.put("lead", dao.selectLead(map));
		
		return resultMap;

	}

	// 게시글 쓰기
	@Override
	public void insertWrite(Map<String, Object> commandMap) {

		String TITLE = (String) commandMap.get("title");
		String CONTENT = (String) commandMap.get("content");
		String HEAD_ID = (String) commandMap.get("headId");
		String BBS_ID = (String) commandMap.get("bbsId");
		String NOTICE = (String) commandMap.get("notice");
		String POST_END = (String) commandMap.get("postEnd");
		String SECRET_CHECK = (String) commandMap.get("secretCheck");
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("title", TITLE);
		param.put("content", CONTENT);
		param.put("headId", HEAD_ID);
		param.put("bbsId", BBS_ID);
		param.put("notice", NOTICE);
		param.put("postEnd", POST_END);
		param.put("secretCheck", SECRET_CHECK);
		
		dao.insertWrite(param);

	}

	// 게시판 리스트 출력하기
	@Override
	public List<Map<String, Object>> selectBbsList(Map<String, Object> map) {

		return dao.selectBbsList(map);

	}
	
	
	// 게시판 상세페이지 출력
	@Override
	public Map<String, Object> selectBbsDetail(Map<String, Object> map) {
				
		return dao.selectBbsDetail(map);
	}
	
	// 게시판 리스트 수정
	@Override
	public void updateBbsDetail(Map<String, Object> commandMap) {
		
		dao.updateBbsDetail(commandMap);
	}
	
	// 게시판 리스트 입력
	@Override
	public void insertBbs(Map<String, Object> commandMap) {
		
		dao.insertBbs(commandMap);
	}
	
	// 사이드바 출력
	@Override
	public List<Map<String, Object>> selectSidebar(Map<String, Object> commandMap) {
		return dao.selectSidebar(commandMap);
	}
	
	// 게시글 삭제 처리(수정)
	@Override
	public void updateDelete(Map<String, Object> commandMap) {
		dao.updateDeleteBoard(commandMap);
	}
	
	// 게시글 갯수 세기(페이징)
	@Override
	public int selectCountList(Map<String, Object> map) {
		return dao.selectCountList(map);
	}
	
	// 조회수 올리기
	@Override
	public void updateHitCnt(Map<String, Object> commandMap) {
		
		dao.updateHitCnt(commandMap);
	}
	
	// 게시글 수정
	public void updateBoard(Map<String, Object> commandMap) {
		dao.updateBoard(commandMap);
	}
	
	//
	public Map<String, Object> selectBbsCondition(Map<String, Object> map) {
		return dao.selectBbsCondition(map);
	}
	
	
	public Map<String, Object> selectSearchOption() {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("SN", dao.selectSN());
		resultMap.put("SO", dao.selectSO());
		
		return resultMap;
		
	}
	
	
}

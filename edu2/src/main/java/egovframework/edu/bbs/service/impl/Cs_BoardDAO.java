package egovframework.edu.bbs.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("boardDAO")
public class Cs_BoardDAO extends EgovAbstractMapper {
	
	// 게시글 리스트 출력하기
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) {
		return selectList("board.list", map);
	}
	
	// 공지사항(게시글) 리스트 출력하기
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) {
		return selectList("board.notice", map);
	}
	
	// 게시글 상세페이지 읽기
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("board.detail", map);
	}
	
	// 게시글 쓰기
	public void insertWrite(Map<String, String> commandMap) {
		insert("board.writeInsert", commandMap);
	} 
	
	// 게시판 리스트 출력하기
	public List<Map<String, Object>> selectBbsList(Map<String, Object> map) {
		return selectList("board.bbsList", map);
	}
	
	// 게시판 상세페이지 출력
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBbsDetail(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("board.bbsDetail", map);
	}

	// 게시판 리스트 수정
	public void updateBbsDetail(Map<String, Object> commandMap) {
		update("board.updateBbsDetail", commandMap);
		
	}

	// 게시판 리스트 입력
	public void insertBbs(Map<String, Object> commandMap) {
		insert("board.insertBbs", commandMap);
		
	}
	
	//사이드바
	public List<Map<String, Object>> selectSidebar(Map<String, Object> map) {
		return selectList("board.bbsList", map);
	}

	// 게시글 삭제 처리(수정)
	public void updateDeleteBoard(Map<String, Object> commandMap) {
		update("board.updateDeleteBoard", commandMap);
		
	}
	
	// 게시글 이전글
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectLeg(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("board.selectLeg", map);
	}
	
	// 게시글 다음글
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectLead(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("board.selectLead", map);
	}
	
	// 게시글 갯수세기
	public int selectCountList(Map<String, Object> map) {
		return selectOne("board.selectCountList", map);
	}

	// 카운트
	public void updateHitCnt(Map<String, Object> commandMap) {
		update("board.updateHitCnt", commandMap);
		
	}
	
	// 게시글 상세 페이지 수정
	public void updateBoard(Map<String, Object> commandMap) {
		update("board.updateBoard", commandMap);
		
	}
	
	// bbs게시판 상태 불러오기
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBbsCondition(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("board.bbsCondition", map);
	}
	
	// 검색 옵션
	public List<Map<String, Object>> selectSN() {
		return selectList("board.selectSN");
	}
	
	public List<Map<String, Object>> selectSO() {
		return selectList("board.selectSO");
	}
	

}



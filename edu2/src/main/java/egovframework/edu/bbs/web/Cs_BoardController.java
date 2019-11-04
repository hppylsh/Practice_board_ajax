package egovframework.edu.bbs.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.edu.bbs.common.Pager;
import egovframework.edu.bbs.service.Cs_BoardService;

@ResponseBody
@Controller
public class Cs_BoardController {

	@Resource(name="BoardService")
	private Cs_BoardService boardService;

	// 게시글 리스트
	@RequestMapping(value = "/list.do")
	public ModelAndView boardList(
			  @RequestParam Map<String, Object> commandMap
			, @RequestParam(defaultValue = "1") int curPage
			, @RequestParam(defaultValue = "SO001") String search_option
			, @RequestParam(defaultValue = "SN001") String search_notice
			, @RequestParam(defaultValue = "") String keyword) throws Exception {
		ModelAndView mav = new ModelAndView("V_list");
	
		// 글 갯수 가져오기
		int count = boardService.selectCountList(commandMap);
		
		// 레코드 갯수, 현재 페이지 번호
		Pager pager = new Pager(count, curPage);
		// 시작번호, 끝번호
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		// commandMap에 담기
		commandMap.put("start", start);
		commandMap.put("end", end);
		commandMap.put("search_option", search_option);
		commandMap.put("search_notice", search_notice);
		commandMap.put("keyword", keyword);
		
		// 게시글 정보
		List<Map<String, Object>> list = boardService.selectBoardList(commandMap);
		// 공지 정보
		List<Map<String, Object>> notice = boardService.selectNoticeList(commandMap);
		// bbs게시판 정보
		Map<String, Object> bbs = boardService.selectBbsCondition(commandMap);
		
		Map<String, Object> SearchOption = boardService.selectSearchOption();
		
		//맵에 자료저장
		Map<String, Object> map = new HashMap<>();
		map.put("list", list); 
		map.put("count", count);
		map.put("pager",pager);
		map.put("search_option",search_option);
		map.put("search_notice",search_notice);
		map.put("keyword",keyword);
		
		//데이터 저장
		mav.addObject("map", map);
		mav.addObject("notice", notice);
		mav.addObject("bbs", bbs);
		mav.addObject("SearchOption", SearchOption);

		return mav;
	}

	//게시글 쓰는 페이지로 이동
	@RequestMapping(value = "/write.do")
	public ModelAndView boardWrite(@RequestParam Map<String, Object> commandMap) throws Exception {
		
		ModelAndView mav = new ModelAndView("V_Write");

		return mav;
	}

	//게시글 상세페이지로 이동
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/detail.do")
	public ModelAndView boardDetail(@RequestParam Map<String, Object> commandMap) throws Exception {

		ModelAndView mav = new ModelAndView("V_boardDetail");
		
		Map<String, Object> result = boardService.selectBoardDetail(commandMap);
		// 조회수 1 올리기
		boardService.updateHitCnt(commandMap);
		
		// 상세페이지 정보
		Map<String, Object> detail = (Map<String, Object>) result.get("detail");
		// 이전글
		Map<String, Object> leg = (Map<String, Object>) result.get("leg");
		// 다음글
		Map<String, Object> lead = (Map<String, Object>) result.get("lead");
		
		
		
		mav.addObject("map", detail);
		mav.addObject("leg", leg);
		mav.addObject("lead", lead);

		return mav;
	}

	//게시글 입력
	@RequestMapping(value = "/insertwritetest.do")
	public ModelAndView insertWritetest(@RequestParam Map<String, Object> commandMap) {
		ModelAndView mav = new ModelAndView("redirect :/list.do");
		
		boardService.insertWrite(commandMap);
		
		return mav;
	}
	
	@RequestMapping(value = "/insertwrite.do", method=RequestMethod.POST)
	@ResponseBody
	public void insertWrite(@RequestParam Map<String, Object> commandMap) {
		
		boardService.insertWrite(commandMap);
		
	}
	
	// 게시글 수정 폼
	@RequestMapping(value = "/modifyform.do")
	public ModelAndView selectRevise(@RequestParam Map<String, Object> commandMap) {
		ModelAndView mav = new ModelAndView("V_boardModify");
		
		Map<String, Object> map = boardService.selectBoardDetail(commandMap);
		mav.addObject("map", map);

		return mav;
		
	}
	
	// 게시글 수정
	@RequestMapping(value = "/modify.do", method=RequestMethod.POST)
	@ResponseBody
	public void updateRevise(@RequestParam Map<String, Object> commandMap) {
		
		boardService.updateBoard(commandMap);
		
	}
	
	
	// 게시글 삭제(수정처리)
	@RequestMapping(value = "/delete.do")
	public void updateDelete(@RequestParam Map<String, Object> commandMap) {
		boardService.updateDelete(commandMap);
	}
	
	
	// 게시판 관리 리스트
	@RequestMapping(value = "/bbslist.do")
	public ModelAndView selectbbsList(Map<String, Object> commandMap) throws Exception {
		ModelAndView mav = new ModelAndView("V_bbsList");
		
		List<Map<String, Object>> list = boardService.selectBbsList(commandMap);
		mav.addObject("list", list);

		return mav;
	}
	
	// 게시판 관리 상세페이지
	@RequestMapping(value = "/bbsdetail.do")
	public ModelAndView selectbbsDetail(Map<String, Object> commandMap) throws Exception {
		ModelAndView mav = new ModelAndView("V_bbsDetail");
		
		List<Map<String, Object>> list = boardService.selectBbsList(commandMap);
		mav.addObject("list", list);

		return mav;
	}
	
	//게시판관리 수정 폼
	@RequestMapping(value = "/bbsmodifyform.do")
	public ModelAndView selectBbsModifyForm(@RequestParam Map<String, Object> commandMap) {
		ModelAndView mav = new ModelAndView("V_bbsModifyForm");
		
		Map<String, Object> map = boardService.selectBbsDetail(commandMap);
		mav.addObject("map", map);

		return mav;
		
	}
	
	//게시판관리 수정 
	@RequestMapping(value = "/updateBbs.do")
	public ModelAndView selectBbsModify(@RequestParam Map<String, Object> commandMap) {
		ModelAndView mav = new ModelAndView("forward:/bbslist.do");
		
		boardService.updateBbsDetail(commandMap);
		
		return mav;
		
	}
	
	//게시판 생성 폼
	@RequestMapping(value = "/insertBbsForm.do")
	public ModelAndView insertBbsForm(@RequestParam Map<String, Object> commandMap) {
		ModelAndView mav = new ModelAndView("V_bbsInsertForm");
		return mav;
		
	}
	
	//게시판 생성
	@RequestMapping(value = "/insertBbs.do")
	public ModelAndView insertBbs(@RequestParam Map<String, Object> commandMap) {
		ModelAndView mav = new ModelAndView("forward:/bbslist.do");
		
		boardService.insertBbs(commandMap);
		
		return mav;
		
	}
	
	//사이드바
	@RequestMapping(value = "/sidebar.do")
	public ModelAndView sidebar(@RequestParam Map<String, Object> commandMap) {
		System.out.println("kkkkk : " + commandMap);
		ModelAndView mav = new ModelAndView("V_sidebar");
		
		List<Map<String, Object>> sidebar = boardService.selectSidebar(commandMap);
		mav.addObject("sidebar", sidebar);
		
		return mav;
		
	}

}

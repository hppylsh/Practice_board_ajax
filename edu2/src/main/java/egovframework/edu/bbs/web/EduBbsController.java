package egovframework.edu.bbs.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.edu.bbs.service.EduBbsService;

@Controller
public class EduBbsController {

	@Resource(name = "EduBbsService")
    private EduBbsService eduBbsService;
	
	@RequestMapping("/bbs/boardList.do")
	public String bubJungCodeList(@RequestParam HashMap<String, Object> commandMap, Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		String boardNo = request.getParameter("boardNo");
		
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("boardNo",boardNo);		
		
		
		List<?> boardList = eduBbsService.selectBoardList(commandMap);
		
		model.addAttribute("boardList", boardList);
		return "egovframework/edu/bbs/boardList";
	}


}
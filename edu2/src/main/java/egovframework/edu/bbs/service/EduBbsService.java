package egovframework.edu.bbs.service;

import java.util.HashMap;
import java.util.List;

public interface EduBbsService {
	
	public List<?> selectBoardList(HashMap<String, Object> hashMap);
	public List<?> selectBoardDetail(HashMap<String, Object> hashMap);

}

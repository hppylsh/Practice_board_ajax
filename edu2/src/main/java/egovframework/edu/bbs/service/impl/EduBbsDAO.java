package egovframework.edu.bbs.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


@Repository("EduBbsDAO")
public class EduBbsDAO extends EgovAbstractMapper {
	
	public List<?> selectBoardList(HashMap<String, Object> hashMap) {
		List<?> list = selectList("eduBbs.selectBoardList", hashMap);
		System.out.println(list);
		return list;
	}
	
	public List<?> selectBoardDetail(HashMap<String, Object> hashMap) {
		return selectList("eduBbs.selectBoardDetail", hashMap);
	}
	
}

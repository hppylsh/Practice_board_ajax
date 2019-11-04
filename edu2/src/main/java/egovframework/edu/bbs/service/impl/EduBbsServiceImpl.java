package egovframework.edu.bbs.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.edu.bbs.service.EduBbsService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("EduBbsService")
public class EduBbsServiceImpl extends EgovAbstractServiceImpl implements EduBbsService {
	protected Logger logger = LoggerFactory.getLogger(EduBbsServiceImpl.class);
	@Resource
	private EduBbsDAO eduBbsDAO;

	public List<?> selectBoardList(HashMap<String, Object> hashMap) {
		logger.debug("이런식으로 로그를 남길수도 있습니다.");
		return eduBbsDAO.selectBoardList(hashMap);
	}
	public List<?> selectBoardDetail(HashMap<String, Object> hashMap) {
		return eduBbsDAO.selectBoardDetail(hashMap);
	}
}

package com.lec.spring.domain.report;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReportDAOImpl implements ReportDAO {
	private ReportDAO mapper;
	
	@Autowired
	public ReportDAOImpl(SqlSession sqlSession) {
		mapper = sqlSession.getMapper(ReportDAO.class);
	}
	
	@Override
	public List<ReportDTO> selectReport() {
		return mapper.selectReport();
	}

	@Override
	public int countRp() {
		return mapper.countRp();
	}

	@Override
	public List<ReportDTO> selectFromRowRp(int from, int pageRows) {
		return mapper.selectFromRowRp(from, pageRows);
	}

	@Override
	public ReportDTO selectByReport(int uid) {
		return mapper.selectByReport(uid);
	}

	@Override
	public int deleteReport(int uid) {
		return mapper.deleteReport(uid);
	}
	
	
}
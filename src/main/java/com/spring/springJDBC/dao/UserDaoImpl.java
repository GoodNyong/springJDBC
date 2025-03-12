package com.spring.springJDBC.dao;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.spring.springJDBC.vo.UserVo;

@Component
public class UserDaoImpl implements UserDao {

//	@Autowired
//	private JdbcTemplate jdbcTemplate;
	private JdbcTemplate jdbcTemplate;
	private String sql = "";

	private RowMapper<UserVo> rowMapper = (rs, idx) -> {
		UserVo vo = new UserVo();
		vo.setIdx(rs.getInt("idx"));
		vo.setMid(rs.getString("mid"));
		vo.setPwd(rs.getString("pwd"));
		vo.setName(rs.getString("name"));
		vo.setAge(rs.getInt("age"));
		vo.setGender(rs.getString("gender"));
		vo.setAddress(rs.getString("address"));
		return vo;
	};

	@Autowired
	public void setdatasource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public int setUserInput(UserVo vo) {
		sql = "insert into user values (default, ?, ?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql, vo.getMid(), vo.getPwd(), vo.getName(), vo.getAge(), vo.getGender(),
				vo.getAddress());
	}

	@Override
	public int getUserCnt() {
		sql = "select count(*) from user";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	// 아이디 중복 체크 후 검색한 결과 반환(없으면 "empty"를 반환)
	@Override
	public UserVo getUserIdSearch(String mid) {
		sql = "select * from user where mid = ?";
		try {
			return jdbcTemplate.queryForObject(sql, rowMapper, mid);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public List<UserVo> getUserList() {
		sql = "select * from user order by idx desc";
		return jdbcTemplate.query(sql, rowMapper);
	}

	@Override
	public int setUserDeleteOk(int idx) {
		sql = "delete from user where idx=?";
		return jdbcTemplate.update(sql, idx);
	}

	@Override
	public UserVo getUserIdxSearch(int idx) {
		sql = "select * from user where idx = ?";
		return jdbcTemplate.queryForObject(sql, rowMapper, idx);
	}

	@Override
	public int setUserUpdate(UserVo vo) {
		sql = "update user set pwd=?, name=?, age=?, gender=?, address=? where idx = ?";
		return jdbcTemplate.update(sql, vo.getPwd(), vo.getName(), vo.getAge(), vo.getGender(), vo.getAddress(),
				vo.getIdx());
	}

	@Override
	public List<UserVo> getUserSearchListOk(String mid) {
		sql = "select * from user where mid like ?";
		return jdbcTemplate.query(sql, rowMapper, "%" + mid + "%");
	}

	@Override
	public UserVo getUserSearchPart(String part, String content) {
		sql = "";
		return null;
	}

}

package com.spring.springJDBC.dao;

import org.springframework.stereotype.Repository;

import com.spring.springJDBC.vo.UserVo;

@Repository
public interface UserDao {

	int setUserInput(UserVo vo);

	int getUserCnt();

	UserVo getUserIdSearch(String mid);
	
	
}

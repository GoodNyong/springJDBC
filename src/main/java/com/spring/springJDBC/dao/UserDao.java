package com.spring.springJDBC.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.springJDBC.vo.UserVo;

@Repository
public interface UserDao {

	int setUserInput(UserVo vo);

	int getUserCnt();

	UserVo getUserIdSearch(String mid);

	List<UserVo> getUserList();

	int setUserDeleteOk(int idx);

	UserVo getUserIdxSearch(int idx);

	int setUserUpdate(UserVo vo);

	List<UserVo> getUserSearchListOk(String mid);

	UserVo getUserSearchPart(String part, String content);
	
	
}

package com.spring.springJDBC.service;

import java.util.List;

import com.spring.springJDBC.vo.UserVo;

public interface UserService {

	int setUserInput(UserVo vo);

	int getUserCnt();

	UserVo getUserIdSearch(String mid);

	List<UserVo> getUserList();

	int setUserDeleteOk(int idx);

	UserVo getUserIdxSearch(int idx);

	int setUserUpdate(UserVo vo);

	List<UserVo> getUserSearchListOk(String mid);

	List<UserVo> getUserSearchPart(String part, String content);

}

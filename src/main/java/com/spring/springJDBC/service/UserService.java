package com.spring.springJDBC.service;

import com.spring.springJDBC.vo.UserVo;

public interface UserService {

	int setUserInput(UserVo vo);

	int getUserCnt();

	UserVo getUserIdSearch(String mid);

}

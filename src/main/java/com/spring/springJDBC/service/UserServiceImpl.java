package com.spring.springJDBC.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springJDBC.dao.UserDao;
import com.spring.springJDBC.vo.UserVo;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	@Override
	public int setUserInput(UserVo vo) {

		// 원래는 이렇게?
//		int res = userDao.setUserInput(vo);
//		return res;

		return userDao.setUserInput(vo);
	}

	@Override
	public int getUserCnt() {

		return userDao.getUserCnt();
	}

	@Override
	public UserVo getUserIdSearch(String mid) {
		return userDao.getUserIdSearch(mid);
	}

	@Override
	public List<UserVo> getUserList() {
		return userDao.getUserList();
	}

	@Override
	public int setUserDeleteOk(int idx) {
		return userDao.setUserDeleteOk(idx);
	}

	@Override
	public UserVo getUserIdxSearch(int idx) {
		return userDao.getUserIdxSearch(idx);
	}

	@Override
	public int setUserUpdate(UserVo vo) {
		return userDao.setUserUpdate(vo);
	}

	@Override
	public List<UserVo> getUserSearchListOk(String mid) {
		return userDao.getUserSearchListOk(mid);
	}

	@Override
	public List<UserVo> getUserSearchPart(String part, String searchWord) {
		return userDao.getUserSearchPart(part, searchWord);
	}

}

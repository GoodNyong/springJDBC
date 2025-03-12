package com.spring.springJDBC.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.springJDBC.service.UserService;
import com.spring.springJDBC.vo.UserVo;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	
	@RequestMapping(value = "/userMain", method = RequestMethod.GET)
	public String userMainGet(Model model) {
		// 전체 인원수 구하기
		int userCnt = userService.getUserCnt();
		model.addAttribute("userCnt", userCnt);
		
		return "user/userMain";
	}
	
	@RequestMapping(value = "/userInput", method = RequestMethod.GET )
	public String userInputGet() {
		return "user/userInput";
	}
	
	@RequestMapping(value = "/userInput", method = RequestMethod.POST )
	public String userInputPost(UserVo vo, Model model) {
		// 아이디 중복체크
		UserVo vo2 = userService.getUserIdSearch(vo.getMid());
		System.out.println("vo2 : " + vo2);
		if(vo2 != null) return "redirect:/message/userIdDuplication";
		
		// 회원 가입 처리
		int res = userService.setUserInput(vo);
		if (res != 0) return "redirect:/message/userInputOk";
		else return "redirect:/message/userInputNo";
	}
	
	// 개별 회원 조회 페이지 열기
	@RequestMapping(value = "/userSearch", method = RequestMethod.GET )
	public String userSearchGet() {
		return "user/userSearch";
	}
	
	// 개별 회원 완전 일치 조회
	@RequestMapping(value = "/userSearchList", method = RequestMethod.GET)
	public String userSearchListGet(Model model, String mid) {
		UserVo vo = userService.getUserIdSearch(mid);
		if (vo != null) {
			model.addAttribute("vo", vo);
			return "user/userSearch";
		} else return "redirect:/message/userSearchNo";
	}
	
	// 개별 회원 조회 - part에 따른 검색(part : mid/name/address)
	@RequestMapping(value = "/userSearchPart", method = RequestMethod.GET)
	public String userSearchPartGet(Model model, String part, String searchWord) {
		List<UserVo> vos = userService.getUserSearchPart(part, searchWord);
		if(vos != null && !vos.isEmpty()) {
			model.addAttribute("vos", vos);
			return "user/userSearch";
		}
		else return "redirect:/message/userSearchNo";
	}
	
	// 개별 회원 아이디 부분 일치 조회(목록 반환)
	@RequestMapping(value = "/userSearchListOk", method = RequestMethod.GET)
	public String userSearchListOkGet(Model model, String mid) {
		List<UserVo> vos = userService.getUserSearchListOk(mid);
		model.addAttribute("vos", vos);
		return "user/userSearch";
	}
	
	// 전체 회원 목록 페이지 요청
	@RequestMapping(value = "/userList", method = RequestMethod.GET )
	public String userListGet(Model model) {
		List<UserVo> vos = userService.getUserList();
//		System.out.println(vos.toString());
		model.addAttribute("vos", vos);
//		System.out.println(model.toString());
		return "user/userList";
	}
	
	@RequestMapping(value = "/userDeleteOk", method = RequestMethod.GET)
	public String userDeleteOkGet(int idx) {
		int res = userService.setUserDeleteOk(idx);
		if(res != 0) return "redirect:/message/userDeleteOk";
		else return "redirect:/message/userDeleteNo";
	}
	
	@RequestMapping(value = "/userUpdate", method = RequestMethod.GET)
	public String userUpdateGet(Model model, int idx) {
		UserVo vo = userService.getUserIdxSearch(idx);
		model.addAttribute("vo", vo);
		return "user/userUpdate";
	}
	
	@RequestMapping(value = "/userUpdate", method = RequestMethod.POST)
	public String userUpdatePost(Model model, UserVo vo) {
		int res = userService.setUserUpdate(vo);
		if(res != 0) return "redirect:/message/userUpdateOk";
		else return "redirect:/message/userUpdateNo";
	}
	
}

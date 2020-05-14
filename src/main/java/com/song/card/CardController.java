package com.song.card;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.song.service.CardService;
import com.song.vo.CardVo;

@Controller
public class CardController {

	@Autowired
	private CardService cardService;
	
	//등록페이지 정보 가져가기
	@GetMapping("/reg")
	public String Reg(HttpServletRequest req) {
		// 코드 수정
		return "reg";
	}

}

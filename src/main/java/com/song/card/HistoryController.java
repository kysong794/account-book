package com.song.card;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.song.service.CardService;
import com.song.service.HistoryService;
import com.song.vo.CardVo;
import com.song.vo.HistoryVo;

@Controller
@RequestMapping("/history")
public class HistoryController {
	
	@Autowired
	private HistoryService historyService;
	
	@Autowired
	private CardService cardService;
	
	//등록페이지 정보 가져가기
	@GetMapping("/reg")
	public String Reg(HttpServletRequest req) {
		int historyNo = historyService.historyNo();
		int cardNo = cardService.cardNo();
		List<CardVo> findAll = cardService.findAll();
		
		req.setAttribute("historyNo", historyNo);
		req.setAttribute("cardNo", cardNo);
		req.setAttribute("findAll", findAll);
		return "reg";
	}
	
	//등록페이지 등록
	@PostMapping("/RegSave")
	public String RegSave(HistoryVo historyVo) {
		
		historyService.RegSeve(historyVo);
		return "redirect:/history/reg";
	}
	
	//카드 사용 내역 리스트
	@GetMapping("/home")
	public String historyList(HttpServletRequest req){
		
		List<HistoryVo> historyList = historyService.historyList();
		int totalPrice = historyService.totalPrice();
		
		req.setAttribute("historyList", historyList);
		req.setAttribute("totalPrice", totalPrice);
		
		return "home";
	}
	
	
}

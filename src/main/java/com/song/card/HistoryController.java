package com.song.card;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView historyList(ModelAndView mav){
		
		List<HistoryVo> historyList = historyService.historyList();
		Integer totalPrice = historyService.totalPrice();
		Integer totalBalance = historyService.totalBalance();
//		Integer eachBalance = historyService.eachBalance(historyNo);
		
		mav.addObject("historyList", historyList);
		mav.addObject("totalPrice", totalPrice);
		mav.addObject("totalBalance", totalBalance);
		mav.setViewName("home");
		
		return mav;
	}
	
	@PostMapping("delete")
	public String delete(Integer historyNo) {
		historyService.delete(historyNo);
		
		return "redirect:/history/home";
	}
	
}

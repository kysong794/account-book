package com.song.card;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	// 등록페이지 등록
	/*
	 * Http 규약에서 데이터를 전달하는 방법은 여러가지가 있는데, 
	 * 1) query string ?name=songsong
	 * 2) path variable "/path/{name}"
	 * 3) body 몸체의 문자열로 전달
	 * 3-1) FORM : "key=value&key=value...",
	 * 3-2) JSON : "{key: value, key: value, ...}"
	 */
	@PostMapping("/RegSave")
	public String RegSave(HistoryVo historyVo) {
		historyService.RegSeve(historyVo);
		return "redirect:/history/reg";
	}
	
	//카드 사용 내역 리스트
	@GetMapping("/home")
	public ModelAndView historyList(ModelAndView mav){
		
		List<CardVo> findAll = cardService.findAll();
		List<HistoryVo> historyList = historyService.getHistoryList();
		Integer totalPrice = historyService.totalPrice();
		Integer totalBalance = historyService.totalBalance();

		for (int i = 1; i < historyList.size(); i++) {
			// 이전 행
			HistoryVo previous = historyList.get(i-1);
			// 현재 행
			HistoryVo current = historyList.get(i);
			
			if (previous.getHistoryNo() == current.getHistoryNo()) {
				// 같으면 이전 행의 eachBalance를 지운다
				previous.setEachBalance(null);
				
			} else {
				// 넘어감
			}
		}

		//가능 한가?에 대한 의문으로써 가능성의 질의
		//cardUseLimit을 따로 select 해서 가져왔지만,
		//원래라면 카드 번호에 맞는 cardUseLimit 값에 맞게 D-day 계산이 자동으로 맞춰지게 셋팅해야함
		//현재 못한 이유 리스트에서 cardUseLimit만 빼오는법 몰라서 ㅠㅠ
		//지금의 D-day 셋팅값은 어떤 카드를 선택해도 1번 카드에대한 cardUseLimit 값만 가져오게됨
		
		try {
			
			SimpleDateFormat sdf = new SimpleDateFormat ("yyyy-MM-dd");
			Date now = new Date();
			Date cardUseLimit = cardService.cardUseLimit();
			
			String nowTime = sdf.format(now);
			String cardUseLimit01 = sdf.format(cardUseLimit);

			Date now00 = sdf.parse(nowTime);		
			Date cardUseLimit00 = sdf.parse(cardUseLimit01);
			
			long d_day = (cardUseLimit00.getTime() - now00.getTime()) / (24 * 60 * 60 * 1000);
			
			mav.addObject("d_day", d_day);
			mav.addObject("now",now);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mav.addObject("findAll", findAll);
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
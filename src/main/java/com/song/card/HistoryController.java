package com.song.card;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.song.service.CardService;
import com.song.service.HistoryService;
import com.song.vo.CardVo;
import com.song.vo.HistoryVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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
	@ResponseBody
	@PostMapping("/regSave")
	public String RegSave(@RequestBody List<HistoryVo> historyVoList) {
		boolean isValid = true;
		for (int i = 0; i < historyVoList.size(); i++) {
			if (!isValid(historyVoList.get(0))) {
				isValid = false;
				break;
			}
		}
		
		if (!isValid) {
			return "failed";
		}
		
		try {
			historyService.bulkSave(historyVoList);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();

			return "failed";
		}
	}
	
	private boolean isValid(HistoryVo vo) {
		boolean isCardNoValid = vo.getCardNo() != null;
		boolean isHistoryNoValid = vo.getHistoryNo() != null;
		boolean isRegDateValid = vo.getRegDate() != null;
		boolean isShopNameValid = vo.getShopName() != null;
		boolean isProductNameValid = vo.getProductName() != null;
		boolean isPriceValid = vo.getPrice() > 0;
		boolean isAmountValid = vo.getAmount() > 0;
		
		return isCardNoValid &&
				isHistoryNoValid &&
				isRegDateValid &&
				isShopNameValid &&
				isProductNameValid &&
				isPriceValid &&
				isAmountValid;
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
		
		try {
			
			Date now = new Date();
			
			for (int i = 0; i < findAll.size(); i++) {
				CardVo card = findAll.get(0);
				SimpleDateFormat sdf = new SimpleDateFormat ("yyyy-MM-dd");
				Date cardUseLimit = card.getCardUseLimit();
				
				String nowTime = sdf.format(now);
				String cardUseLimit01 = sdf.format(cardUseLimit);

				Date nowTime00 = sdf.parse(nowTime);		
				Date cardUseLimit00 = sdf.parse(cardUseLimit01);
				
				long d_day = (cardUseLimit00.getTime() - nowTime00.getTime()) / (24 * 60 * 60 * 1000);
				
				card.setDayLeft((int)d_day);
			}
			
//			mav.addObject("d_day", d_day);
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
	public String delete(Integer historyNo, String productName) {
		historyService.delete(historyNo, productName);
		
		return "redirect:/history/home";
	}
	
	@PostMapping("/modify")
	public String modify(HistoryVo historyVo) {
		historyService.modify(historyVo);
		
		return "redirect:/history/home";
	}
	
}
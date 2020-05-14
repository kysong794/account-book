package com.song.card;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.song.vo.CardVo;
import com.song.vo.HistoryVo;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) throws ParseException {
		model.addAttribute("cards", getCards());
		model.addAttribute("histories", getHistories());
		return "home";
	}
	
	// Mock Card
	private List<CardVo> getCards() throws ParseException {
		CardVo card = new CardVo();
		card.setCardNo(1);
		card.setCardName("긴급재난지원카드");
		card.setBalance(500000);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		card.setCardUseLimit(sdf.parse("2020-07-31"));
		
		return Collections.singletonList(card);
	}
	
	// Mock History
	private List<HistoryVo> getHistories() {
		List<HistoryVo> h = new ArrayList<>();
		
		HistoryVo h1 = new HistoryVo();
		h1.setHistoryNo(1);
		h1.setRegDate(new Date());
		h1.setShopName("홈플러스");
		h1.setProductName("샴푸");
		h1.setAmount(1);
		h1.setPrice(6000);
		h1.setCardNo(1);
		
		HistoryVo h2 = new HistoryVo();
		h2.setHistoryNo(1);
		h2.setRegDate(new Date());
		h2.setShopName("홈플러스");
		h2.setProductName("햇반");
		h2.setAmount(12);
		h2.setPrice(500);
		h2.setCardNo(1);
		
		HistoryVo h3 = new HistoryVo();
		h3.setHistoryNo(2);
		h3.setRegDate(new Date());
		h3.setShopName("이마트");
		h3.setProductName("시리얼");
		h3.setAmount(1);
		h3.setPrice(8000);
		h3.setCardNo(1);
		
		h.add(h1);
		h.add(h2);
		h.add(h3);
		
		return h;
	}
	
}

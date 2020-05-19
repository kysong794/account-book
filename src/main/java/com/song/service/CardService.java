package com.song.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.song.repository.CardRepository;
import com.song.vo.CardVo;

@Service
public class CardService {

	@Autowired
	private CardRepository cardRepository;
	
	public int cardNo() {
		return cardRepository.cardNo();
	}
	
	public List<CardVo> findAll(){
		return cardRepository.findAll();
	}
	
	public Date cardUseLimit() {
		return cardRepository.cardUseLimit();
	}
	

}

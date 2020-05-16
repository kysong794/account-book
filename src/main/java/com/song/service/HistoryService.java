package com.song.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.song.repository.HistoryRepository;
import com.song.vo.CardVo;
import com.song.vo.HistoryVo;

@Service
@Transactional
public class HistoryService {
	
	@Autowired
	private HistoryRepository historyRepository;
	
	public void RegSeve(HistoryVo historyVo) {
		historyRepository.RegSave(historyVo);
	}
	
	public int historyNo() {
		return historyRepository.historyNo();
	}
	
	public List<HistoryVo> getHistoryList(){
		return historyRepository.getHistoryList();
	}
	
	public Integer totalPrice() {
		return historyRepository.totalPrice();
	}
	
	public Integer totalBalance() {
		return historyRepository.totalBalance();
	}
	
	public void delete(Integer historyNo) {
		historyRepository.delete(historyNo);
	}
	
}

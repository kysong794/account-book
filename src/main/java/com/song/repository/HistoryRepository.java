package com.song.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.song.vo.HistoryVo;

@Mapper
public interface HistoryRepository {
	
	List<HistoryVo> findAll();
	HistoryVo findByNo(Integer historyNo);
	void update(HistoryVo historyVo);
	void delete(Integer historyNo);
	
	void RegSave(HistoryVo historyVo);
	
	int historyNo();

	List<HistoryVo> historyList();
	
	Integer totalPrice();
	
	Integer totalBalance();
	
//	Integer eachBalance(Integer historyNo);
	
}

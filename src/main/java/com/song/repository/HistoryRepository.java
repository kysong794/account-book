package com.song.repository;

import java.util.Date;
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
	
	Integer historyNo();

	List<HistoryVo> getHistoryList();
	
	Integer totalPrice();
	
	Integer totalBalance();
	

}

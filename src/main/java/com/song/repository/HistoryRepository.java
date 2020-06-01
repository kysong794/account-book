package com.song.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.song.vo.HistoryVo;

@Mapper
public interface HistoryRepository {
	
	List<HistoryVo> findAll();
	HistoryVo findByNo(Integer historyNo);
	void update(HistoryVo historyVo);
	
	void delete(@Param("historyNo") Integer historyNo, @Param("productName") String productName);
	
	void RegSave(HistoryVo historyVo);
	
	Integer historyNo();

	List<HistoryVo> getHistoryList();
	
	Integer totalPrice();
	
	Integer totalBalance();
	
	void bulkSave(@Param("list") List<HistoryVo> list);
	
	void modify(HistoryVo historyVo);

}

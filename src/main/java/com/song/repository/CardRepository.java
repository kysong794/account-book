package com.song.repository;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.song.vo.CardVo;

@Mapper
public interface CardRepository {
	
	List<CardVo> findAll();
	CardVo findByNo(Integer cardNo);
	void update(CardVo cardVo);
	void delete(Integer cardNo);
	
	int cardNo();
	
	Date cardUseLimit();
	
	
}

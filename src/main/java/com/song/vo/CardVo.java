package com.song.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CardVo {
	// 카드 번호
	private Integer cardNo;
	// 카드 이름
	private String cardName;
	// 잔액
	private Integer balance;
	// 카드 사용 기한
	private Date cardUseLimit;
}

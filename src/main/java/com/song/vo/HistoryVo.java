package com.song.vo;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class HistoryVo {
	// 이용 내역 번호
	@NotNull
	private Integer historyNo;
	// 등록일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date regDate;
	// 사용처
	private String shopName;
	// 상품명
	private String productName;
	// 갯수
	private Integer amount;
	// 개당 가격
	private Integer price;
	// 카드 번호
	private Integer cardNo;
	// 총 소비액
	private Integer totalPrice;
	// 각각 소비액
	private Integer eachBalance;
	
}

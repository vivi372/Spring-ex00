package org.zerock.cart.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.cart.vo.CartVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cart")
@Log4j
public class CartController {
	
	@PostMapping("write.do")
	public String write(@ModelAttribute CartVO vo) {
		log.info(vo.getList());
		
		return null;
	}
	
}

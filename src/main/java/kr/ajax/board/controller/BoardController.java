package kr.ajax.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ajax.board.dto.BoardDTO;
import kr.ajax.board.service.BoardService;

@Controller
public class BoardController {
	Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	BoardService boardService;
	
	//동기방식 
	@RequestMapping(value="/")
	public String list(Model model) {	// "/"요청이오면
		log.info("List & Main");
		
		//List<BoardDTO> list = boardService.list();
		//model.addAttribute("list",list);
		
		return "list";	//특정 페이지(list.jsp)로 보낸다. 
	}
	
	//비동기방식 : 일단 페이지에 도착한 다음
	@RequestMapping(value="/list.ajax")
	@ResponseBody
	public  Map<String,Object> listCall() {
		log.info("listCall");
		Map<String, Object> map = new HashMap<String, Object>();
		List<BoardDTO> list = boardService.list();
		map.put("list", list);
		
		return map;	//json과 가장 닮은 map으로
	}
	
	//배열형태로 들어올 경우 따로 명시를 해줘야한다. 
	@RequestMapping(value="/del",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> del(@RequestParam(value="delList[]") List<String> delList){
		log.info("del List :{} ",delList);
		
		
		int cnt = boardService.del(delList);
		log.info("del count : "+ cnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cnt", cnt);
		
		return map;
	}
	

}

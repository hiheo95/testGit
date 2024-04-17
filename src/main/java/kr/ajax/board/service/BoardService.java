package kr.ajax.board.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ajax.board.dao.BoardDAO;
import kr.ajax.board.dto.BoardDTO;

@Service
public class BoardService {
	
	Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	BoardDAO boardDAO;
	
	private String root_path = "/Users/hsg/upload/";
	
	public List<BoardDTO> list() {
		return boardDAO.list();
	}

	public int del(List<String> delList) {
		int cnt = 0;
		
		for(String idx : delList) {
			
			//1. 게시글에 연결된파일명(new_filename) 확보 
			List<String> fileNames = boardDAO.findFile(idx);
			
			//2. bbs에서 해당 글 삭제
			cnt+= boardDAO.delete(idx);
			
			//3. 파일 삭제
			log.info("fileNames:{}",fileNames);
			delFile(fileNames);
			
		}
		return cnt;
	}

	private void delFile(List<String> fileNames) {
		for(String name:fileNames) {
			File file = new File(root_path+name);
			if(file.exists()) {
				file.delete();
			}
		}
	}

}

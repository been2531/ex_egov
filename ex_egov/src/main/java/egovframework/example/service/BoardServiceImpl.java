package egovframework.example.service;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import egovframework.example.mapper.BoardMapper;
import egovframework.example.vo.BoardVO;
import egovframework.example.vo.PageVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Setter;

@Service
@Component
@Data
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private static final Logger log = 
			LoggerFactory.getLogger(BoardServiceImpl.class);
	
	// 주입
	@Setter(onMethod_ = { @Autowired })
	private BoardMapper mapper;
	
	
	@Override
	public int boardCount() {
		log.info("BoardService : boardCount().....");
		return mapper.boardCount();
	}
	
	@Override
	public int boardCountSearchPage(PageVO vo) {
		log.info("BoardService : boardCount().....");
		return mapper.boardCountSearchPage(vo);
	}
	
	@Override
	public List<BoardVO> boardList(PageVO vo) {
		return mapper.boardList(vo);
	}
	
	@Override
	public List<BoardVO> boardListSearchPage(PageVO vo) {
		return mapper.boardListSearchPage(vo);
	}

	@Override
	public int boardWrite(BoardVO vo) {
		log.info("BoardService : boardWrite().....");
		return mapper.boardWrite(vo);
	}

	@Override
	public void boardHits(int idx) {
		mapper.boardHits(idx);
	}
	
	@Override
	public BoardVO boardView(int idx) {
		return mapper.boardView(idx);
	}
	
	@Override
	public int boardModify(BoardVO vo) {
		return mapper.boardModify(vo);
	}
	
	@Override
	public int boardDelete(BoardVO vo) {
		return mapper.boardDelete(vo);
	}
	
}

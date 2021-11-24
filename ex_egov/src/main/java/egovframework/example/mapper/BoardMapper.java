package egovframework.example.mapper;
import java.util.List;
import egovframework.example.vo.BoardVO;
import egovframework.example.vo.PageVO;

public interface BoardMapper {
	
	//@Select("select count(*) from tbl_board") -> BoardMapper.xml
	
	// 게시글 총수 (검색조건 X)
	public int boardCount();
	
	// 게시글 총수 (검색조건 O)
	public int boardCountSearchPage(PageVO vo);
	
	// 전체 게시글 목록 (검색 X, 페이지 X)
	public List<BoardVO> boardList(PageVO vo);
	
	// 전체 게시글 목록 (검색 O, 페이지 O)
	public List<BoardVO> boardListSearchPage(PageVO vo);
	
	// 등록
	public int boardWrite(BoardVO vo);
	
	// 조회수 증가
	public void boardHits(int idx);
	
	// 해당 글 조회 (view)
	public BoardVO boardView(int idx);
	
	// 수정
	public int boardModify(BoardVO vo);
	
	// 삭제
	public int boardDelete(BoardVO vo);
}

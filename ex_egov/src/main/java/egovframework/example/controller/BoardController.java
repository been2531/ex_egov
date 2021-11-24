package egovframework.example.controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.service.BoardService;
import egovframework.example.vo.BoardVO;
import egovframework.example.vo.PageIndex;
import egovframework.example.vo.PageVO;
import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/Board/*")
@AllArgsConstructor
public class BoardController {
	
	private static final Logger log = 
			LoggerFactory.getLogger(BoardController.class);
	
	private BoardService service; // 자동주입 @Setter없이
	
	// 조회 GET, POST
	@RequestMapping(value="board_list", method={RequestMethod.GET, RequestMethod.POST})
	public void boardList(@RequestParam("page") int page, PageVO vo, Model model) {
		log.info("BoardController : boardList()....");
		String url = "board_list", addtag="";
		
		int nowpage = 1;
		int maxlist = 10;
		int totpage = 1;
		int totcount = 0;
		
		// post로 넘어올 떄 
		if(vo.getKey() != null) {
			totcount = service.boardCountSearchPage(vo); // 총글 수 카운트
		}else {
			totcount = service.boardCount();
		}
		
		// 총페이지 수 계산
		if(totcount % maxlist == 0) {
			totpage = totcount / maxlist;
		}else {
			totpage = totcount / maxlist +1;
		}
		
		if(totpage==0) 
			totpage =1;
		if(page != 0)
			nowpage =page;
		if(nowpage>totpage)
			nowpage=totpage;
		
		// 페이지 시작번호
		int startpage = (nowpage-1) * maxlist+1;
		int endpage = nowpage * maxlist;
		
		int listcount = totcount- ((nowpage-1) * maxlist);
		
		vo.setStartpage(startpage);
		vo.setEndpage(endpage);
		
		if(vo.getKey() != null) {
			model.addAttribute("list",service.boardListSearchPage(vo)); // post
		}else {
			model.addAttribute("list", service.boardList(vo)); // get
		}
		
		model.addAttribute("page", nowpage);
		model.addAttribute("totpage", totpage);
		model.addAttribute("listcount", listcount);
		model.addAttribute("totcount", totcount);
		
		// 페이지 인덱싱
		if(vo.getKey() != null) {
			model.addAttribute("pageSkip",PageIndex.pageListHan(nowpage, totpage, url, vo.getSearch(), vo.getKey()));
		}else {
			model.addAttribute("pageSkip",PageIndex.pageList(nowpage, totpage, url, addtag));
		}
	}
	
	// 등록 GET
	@RequestMapping(value="/board_write", method={RequestMethod.GET})
	public void boardWrite(@ModelAttribute("page") int page) {
		
	}
/*	
	// 등록 POST
	@ResponseBody 
	@RequestMapping(value="/board_modify", method={RequestMethod.POST})
	public String boardModifyPro(@RequestBody BoardVO vo, @RequestParam(value="page", defaultValue="1") int page, RedirectAttributes rttr) {
		rttr.addFlashAttribute("row", service.boardWrite(vo));
		rttr.addFlashAttribute("page", page);
		System.out.println("page : " + page);
		return "redirect:/Board/board_list?page="+page;
	}
*/	
	// 등록 POST
	@ResponseBody 
	@RequestMapping(value="/board_write", method={RequestMethod.POST})
	public void boardWritePro(@RequestBody BoardVO vo, RedirectAttributes rttr) {
		rttr.addFlashAttribute("row", service.boardWrite(vo));
	}

	// 해당 idx에 맞는 데이터
	@GetMapping("board_view")
	public void boardView(@RequestParam("idx") int idx, @ModelAttribute("page") int page, Model model) {
		// 조회수 증가
		service.boardHits(idx);
		
		// idx에 해당되는 글 검색
		BoardVO vo = service.boardView(idx);
		vo.setContents(vo.getContents().replace("\n", "<br>"));
		
		// 모델에 담아서 전송
		model.addAttribute("vo", vo);
	}
	
	// 수정 GET // @ModelAttribute : 그저 넘겨주기 위한 
	@GetMapping("board_modify")
	public void boardModify(@RequestParam("idx") int idx, @ModelAttribute("page") int page, Model model) {
		model.addAttribute("vo", service.boardView(idx));
		
	}
/*	
	// 수정 POST
	@PostMapping("board_modify")
	public void boardModifyPro(BoardVO vo, @ModelAttribute("page") int page, RedirectAttributes rttr) {
		rttr.addFlashAttribute("row", service.boardModify(vo));
		rttr.addFlashAttribute("page", page);
	}
	
	@GetMapping("board_modify_pro")
	public void boardModifyPass() {
		
	}
*/	

	// 수정 POST
	@ResponseBody 
	@RequestMapping(value="/board_modify", method={RequestMethod.POST})
	public void boardModifyPro(@RequestBody BoardVO vo, RedirectAttributes rttr) {
		rttr.addFlashAttribute("row", service.boardModify(vo));
	}
	
	// 삭제 GET
	@GetMapping("board_delete")
	public void boardDelete(@RequestParam("idx") int idx, @ModelAttribute("page") int page, Model model) {
		model.addAttribute("vo", service.boardView(idx));
	}
	
	// 삭제 POST
	@PostMapping("board_delete")
	public String boardDeletePro(BoardVO vo, @ModelAttribute("page") int page, RedirectAttributes rttr) {
		rttr.addFlashAttribute("row", service.boardDelete(vo));
		rttr.addFlashAttribute("page", page);
		return "redirect:board_delete_pro";
	}
	
	
	@GetMapping("board_delete_pro")
	public void boardDeletePass() {
		
	}
	
}

package egovframework.example.vo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor 
public class PageVO {
	public PageVO() {}
	// 페이지 처리용
	private int startpage;
	private int endpage;
	
	// 검색
	private String search;
	private String key;
}

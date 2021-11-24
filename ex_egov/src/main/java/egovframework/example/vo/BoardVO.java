package egovframework.example.vo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor 
public class BoardVO {
	public BoardVO() {};
	
	private int idx;
	private String name;
	private String pass;
	private String subject;
	private String contents;
	private String regdate;
	private int readcnt;
}

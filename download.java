//스프링을 사용하지 않는 서블릿의 다운로드 예제. 출처 : CHeessoo

public Download() {
    super();
    // TODO Auto-generated constructor stub
  }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	  // 요청 인코딩
	  request.setCharacterEncoding("UTF-8");
	  
	  // 요청 파라미터 (다운로드 할 파일명)
	  String path = URLDecoder.decode(request.getParameter("path"), "UTF-8");

	  // 다운로드 할 파일의 File 객체 생성
	  File file = new File(path);  // new File("C:\storage\404.jpg")
	  
	  // 다운로드 할 파일을 읽어 들일 바이트 기반 입력 스트림
	  BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
	  
	  // 다운로드용 응답을 만드려면 응답 헤더 "Content-Disposition"에 "attachment" 값을 저장해야 한다.
	  response.setHeader("Content-Disposition", "attachment");  // 다운로드할 때 파일 저장 대화상자가 나타난다.
	  response.setHeader("Content-Disposition", "attachment; filename=" + path.substring(path.lastIndexOf("\\") + 1)); // 다운로드할 때 작성한 filename으로 곧바로 저장된다.
	  
	  // 바이트 기반 응답 출력 스트림 생성
	  BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
	  
	  // 첨부 파일 읽기  ->  byte[]  ->  응답 출력 스트림
	  //       in                              out
	  //      read()                          write()
	  
	  byte[] b = new byte[1024];              // 1024바이트 단위로 읽기
	  int readByte = 0;                       // 실제로 읽은 바이트 수
	  while((readByte = in.read(b)) != -1) {  // 모두 읽어서 더 이상 읽은 내용이 없으면 -1이 반환
	    out.write(b, 0, readByte);            // 읽은 바이트 만큼만 내보내기
	  }
	  
	  // 사용한 스트림 닫기
	  out.close();
	  in.close();
	    
	}


============================================================

//아니라면 이런식도 괜찮을 것 같음

import java.io.BufferedOutputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/downloadFile")
public class FileDownloadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 요청 파라미터에서 데이터 가져오기
        String data = request.getParameter("userData"); // "이름, 별명, 아이디"
        
        // 응답 헤더 설정
        response.setContentType("text/csv"); // CSV 파일 타입
        response.setHeader("Content-Disposition", "attachment; filename=\"data.csv\"");

	// 만약 name에 변수를 넣는다면 filename=\"" + name + "_data.csv\"" 이런식으로 이스케이프 문자

        // 바이트 배열로 변환
        byte[] fileContent = data.getBytes("UTF-8");
        
        // 응답에 파일 내용 쓰기
        try (BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())) {
            out.write(fileContent);
            out.flush();
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 서버 에러
        }
    }
}


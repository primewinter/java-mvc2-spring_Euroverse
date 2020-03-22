package com.ksy.web.admin;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ksy.common.Page;
import com.ksy.common.Search;
import com.ksy.service.admin.AdminService;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.User;

@RestController
@RequestMapping("/admin/*")
public class AdminRestController {

	@Autowired
	@Qualifier("adminServiceImpl")
	private AdminService adminService;
	
	
	public AdminRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['postPageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['postPageSize']}")
	int pageSize;
	
	//유저의 목록을 불러옴
	@RequestMapping(value="json/getUserList", method = RequestMethod.POST)
	public Map<String, Object> getUserList(@RequestBody Search search ) throws Exception {
		
		System.out.println("\n\n restController getUserList\n\n");
		
		User user = new User();
//		Search search = new Search();
		//현재 페이지를 항상 1로 유지
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		//map에  getUserList 담기
		Map<String, Object> map = adminService.getUserList(search);
		
		//페이지를 눌렀을때 결과페이지의 페이지값을 찾아오는 작업 
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(),
				pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		System.out.println("map 디버깅 ==>"+map);
		
		
		return map;
	}
	
	// 관리자가 답변을 등록함
	@RequestMapping(value="json/addQnaComment", method = RequestMethod.POST)
	public Map<String,Object> addQnaComment(@RequestBody Comment comment) throws Exception {
		
		//디버깅 method 시작
		System.out.println("\n\nAdminComtroller addQnaComment\n\n");
		//바인딩여부 디버깅
		System.out.println("comment==>"+comment);
		
		Map<String, Object> map = adminService.getQnaCommentList(comment.getPostId());
		List<String> list = (List<String>)map.get("list");//list.size 가 0일때 add 답변은 한개만 달수있게 하기위해
		System.out.println("list size"+list.size());// list.size 디버깅
		
		//add와 update를 하고 난 comment를 다시 map에 담기위해 map 생성
		Map<String,Object> realMap = new HashMap<String,Object>();
		
		//list.size 가 0일때  관리자 답변 add 문의글 상태답변완료 처리하기위해 update post_grade= 'Q'
		if(list.size() == 0) {
			//comment를 update와 add하고 난후 처음생성한 map과 다른map에 put
			adminService.addQnaComment(comment);
			adminService.updateQnaGrade(comment.getPostId());
			realMap = adminService.getQnaCommentList(comment.getPostId());
		}// if
		
		//답변을 달았는데 또다는경우 returnMap에 error메세지를 담아서 ajax로 보내기위한 map
		Map<String, Object> returnMap = new HashMap<String, Object>();	
		
		//디버깅
		System.out.println("\n\n realMap 디버깅 "+realMap.get("list")+"\n\n");
		
		if(list.size() == 0) {
			realMap.put("returnMsg", "ok");
			return realMap;
		}//if
		else{
			returnMap.put("returnMsg", "error");
			return returnMap;
		}//else
		
	}//method
	
	//관리자가 입력한 답변을 조회
	@RequestMapping(value="json/getQnaCommentList/{postId}", method = RequestMethod.GET)
	public Map<String,Object> getQnaCommentList(@PathVariable String postId) throws Exception {
		
		System.out.println("\n\nAdminComtroller getQnaComment\n\n");
		
		System.out.println("postId==>"+postId);
		
		Map<String,Object> map = adminService.getQnaCommentList(postId);
		
		System.out.println("map 디버깅 ==>"+map);
		
		return map;
	}
	
	// 관리자가 답변을 삭제함 플래그처리 deleted = "T" 동시에 post 업데이트 
	@RequestMapping(value="json/deleteQnaComm", method = RequestMethod.POST)
	public void deleteQnaComm(@RequestBody Comment comment) throws Exception {
		
		System.out.println("\n\nAdminComtroller deleteQnaComm\n\n");
		System.out.println("comment ==>"+comment);
		// cmtId, postId가 바인딩된 comment
		adminService.deleteQnaComm(comment.getCmtId());
		System.out.println("delete실행 ==>"+comment);
		
		adminService.backUpQnaGrade(comment.getPostId());
		
		System.out.println("\n\ndeleteQnaComm End\n\n");
	}
	
	//게시글규제
	@RequestMapping(value="json/updatePostReport/{refId}", method = RequestMethod.GET)
	public void updatePostReport(@PathVariable String refId) throws Exception {
		
		System.out.println("\n\nAdminComtroller updatePostReport\n\n");
		
		System.out.println("postId==>"+refId);
		
		adminService.updatePostReport(refId);
	}
	
	//댓글규제
	@RequestMapping(value="json/updateCmtReport/{refId}", method = RequestMethod.GET)
	public void updateCmtReport(@PathVariable String refId) throws Exception {
		
		System.out.println("\n\nAdminComtroller updateCmtReport\n\n");
		
		System.out.println("cmtId==>"+refId);
		
		adminService.updateCommReport(refId);
	}
	

}

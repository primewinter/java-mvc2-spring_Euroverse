package com.ksy.web.community;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.multipart.MultipartFile;

import com.ksy.common.Page;
import com.ksy.common.Search;
import com.ksy.service.community.CommunityService;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Like;
import com.ksy.service.domain.Offer;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.Push;
import com.ksy.service.domain.Report;
import com.ksy.service.domain.User;
import com.ksy.service.like.LikeService;
import com.ksy.service.push.PushService;

@RestController
@RequestMapping("/community/*")
public class CommunityRestController {

	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	
	@Autowired
	@Qualifier("likeServiceImpl")
	private LikeService likeService; 
	
	@Autowired
	@Qualifier("pushServiceImpl")
	private PushService pushService;
	
	public CommunityRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['postPageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['postPageSize']}")
	int pageSize;

	@RequestMapping(value="json/addOffer", method = RequestMethod.POST)
	public void addOffer( @RequestBody Offer offer, HttpSession session, HttpServletResponse response ) throws Exception {
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		User user = (User)session.getAttribute("user");
		
		String fromUserId = user.getUserId();
		offer.setFromUserId(fromUserId);
		
		communityService.addOffer(offer);

		//플래너 초대 push 하기 method
		Push push = new Push();
		push.setPushType("A");
		push.setRefId(offer.getRefId());
		push.setReceiverId(offer.getToUserId());
		pushService.addPush(push);
		
		JSONObject obj = new JSONObject();
		obj.put("toUserId", offer.getToUserId());
		out.println(obj);
	}

	@RequestMapping(value="/json/addReport", method=RequestMethod.POST)
	public void addReport(Report report, HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("/community/json/addReport : POST");
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		User user=(User)session.getAttribute("user");
		report.setReportUserId(user.getUserId());
		
		communityService.addReport(report);
		
		JSONObject obj = new JSONObject();
		obj.put("msg", "신고 완료!");
		out.println(obj);
	}
	
	@RequestMapping(value="/json/deleteComment/{cmtId}", method=RequestMethod.GET )
	public void deleteComment(@PathVariable String cmtId, HttpServletResponse response) throws Exception {
		
		System.out.println("/community/json/deleteComment : GET");
		
		PrintWriter out = response.getWriter();
		
		communityService.deleteComment(cmtId);
		
		JSONObject obj = new JSONObject();
		obj.put("msg", "삭제 성공!");
		out.println(obj);
	}

	@RequestMapping(value="/json/getComment/{cmtId}", method=RequestMethod.GET )
	public Comment getComment(@PathVariable String cmtId) throws Exception {
		
		System.out.println("/community/json/getComment : GET");
		
		Comment comment = communityService.getComment(cmtId);
		
		return comment;
	}
	
	@RequestMapping(value="/json/updateComment", method=RequestMethod.POST )
	public Comment updateComment(Comment comment) throws Exception {
		
		System.out.println("/community/json/updateComment : POST");
		
		if(comment.getSecret() == null) {
			comment.setSecret("F");
		}
		
		communityService.updateComment(comment);
		comment=communityService.getComment(comment.getCmtId());
		
		return comment;
	}
	
	@RequestMapping(value="/json/like/{cmtId}", method=RequestMethod.GET )
	public void like(@PathVariable String cmtId, HttpSession session, HttpServletResponse response ) throws Exception {
	  
		System.out.println("/community/json/like : GET");
		System.out.println(cmtId);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		 
		Like like = new Like();
		User user=(User)session.getAttribute("user");
	    like.setLikeUserId(user.getUserId());
	    like.setRefId(cmtId);
	    like.setLikeType("C");
	    
	    if(likeService.countByLike(like)==0){
	    	likeService.addLike(like);
	    }
	    like=likeService.getLike(like);
	   
		Comment comment = communityService.getComment(cmtId);
		
		int cmtLikeCount = comment.getCmtLikeCount(); //게시판의 좋아요 카운트
		String likeCheck = like.getLikeCheck(); //좋아요 체크 값
	
		if(likeCheck.equals("F")) {
		  likeService.like_check(like);
		  likeCheck="T";
		  cmtLikeCount++;
		  System.out.println("들어간 후 댓글 추천수 : "+cmtLikeCount);
		  communityService.updateLike(cmtId);   //좋아요 갯수 증가
		}else{
		  likeService.like_check_cancel(like);
		  likeCheck="F";
		  cmtLikeCount--;
		  System.out.println("들어간 후 댓글 추천수 : "+cmtLikeCount);
		  communityService.updateUnlike(cmtId);   //좋아요 갯수 감소
		}
		JSONObject obj = new JSONObject();
		obj.put("cmtId", like.getRefId());
		obj.put("likeCheck", likeCheck);
		obj.put("cmtLikeCount", cmtLikeCount);
		
		out.println(obj);
	}
	
	@RequestMapping(value="/json/addBookMark/{postId}", method=RequestMethod.GET )
	public void addBookMark(@PathVariable String postId, HttpSession session, HttpServletResponse response ) throws Exception {
	  
		System.out.println("/community/json/addBookMark : GET");
	
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		 
		Like like = new Like();
		User user=(User)session.getAttribute("user");
	    like.setLikeUserId(user.getUserId());
	    like.setRefId(postId);
	    like.setLikeType("B");
	    
	    if(likeService.countByLike(like)==0){
	    	likeService.addLike(like);
	    }
	    like=likeService.getLike(like);

		String likeCheck = like.getLikeCheck(); //좋아요 체크 값
		
		if(likeCheck.equals("F")) {
		  likeService.like_check(like);
		  likeCheck="T";
		}else{
		  likeService.like_check_cancel(like);
		  likeCheck="F";

		}
		JSONObject obj = new JSONObject();
		obj.put("postId", like.getRefId());
		obj.put("likeCheck", likeCheck);
		
		out.println(obj);
	}
	
	@RequestMapping( value="json/likeUpdate", method=RequestMethod.POST )
	public void likeUpdate( String postId, HttpServletResponse response, HttpSession session ) throws Exception {
	
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		Like like = new Like();
		User user=(User)session.getAttribute("user");
	    like.setLikeUserId(user.getUserId());
	    like.setRefId(postId);
	    like.setLikeType("A");
	    
	    if(likeService.countByLike(like)==0){
	    	
	    	likeService.addLike(like);
	    	communityService.updatePostLike(postId);
	    	
	    	int likes=communityService.selectLike(postId);
	    	
	    	JSONObject obj = new JSONObject();
	    	obj.put("like", likes);
	    	out.println(obj);
	    }else {
	    	
	    }	
	}
	
	@RequestMapping( value="json/addFile", method=RequestMethod.POST )
	public void addFile(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 업로드할 폴더 경로
		String realFolder = "C:\\Users\\User\\git\\Euroverse\\ksy\\WebContent\\resources\\images\\commImg\\";
		UUID uuid = UUID.randomUUID();

		// 업로드할 파일 이름
		String org_filename = file.getOriginalFilename();
		String str_filename = uuid.toString() + org_filename;

		System.out.println("원본 파일명 : " + org_filename);
		System.out.println("저장할 파일명 : " + str_filename);

		String filepath = realFolder + str_filename;
		System.out.println("파일경로 : " + filepath);

		File f = new File(filepath);
		if (!f.exists()) {
			f.mkdirs();
		}
		file.transferTo(f);
		Thread.sleep(5000);
		out.println("../../resources/images/commImg/" + str_filename);
		out.close();
	}
	
	@RequestMapping( value="json/addComment", method=RequestMethod.POST )
	public void addComment( Comment comment, HttpSession session, HttpServletResponse response ) throws Exception {
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter(); 
		
		System.out.println("/community/addComment : POST");
		
		User user = (User)session.getAttribute("user");
		comment.setCmtWriterId(user.getUserId());
		comment.setNickName(user.getNickname());
		
		if(comment.getSecret() == null) {
			comment.setSecret("F");
		}
		communityService.addComment(comment);
		
		String postWriterId = comment.getPostWriterId();
		String parentCmtWriterId ="";
		if( !postWriterId.equals(comment.getCmtWriterId()) ) {			// 글 작성자 =/= 댓글 작성자
			Push push = new Push();
			push.setRefId(comment.getPostId()+"");
			push.setPushType("C");
			push.setReceiverId(postWriterId);
			pushService.addPush(push);
			if(comment.getParentCmtId() != null) {			//부모 댓글이 있다면 = 대댓글이라면
				parentCmtWriterId = communityService.getComment(comment.getParentCmtId()).getCmtWriterId();
				if( !parentCmtWriterId.equals(comment.getCmtWriterId()) ) { 		//부모 댓글 작성자 =/= 대댓글 작성자
					push.setRefId(comment.getPostId()+"");
					push.setPushType("C");
					push.setReceiverId(parentCmtWriterId);
					pushService.addPush(push);
				}
			}
		}
		
		JSONObject obj = new JSONObject();
		obj.put("postWriterId", postWriterId);
		obj.put("parentCmtWriterId", parentCmtWriterId);
		out.println(obj);
	}
	
	@RequestMapping( value="json/getCommentList/{postId}/{currentPage}", method=RequestMethod.GET )
	public Map<String, Object> getCommentList( @PathVariable String postId, @PathVariable int currentPage, HttpSession session ) throws Exception{
		
		System.out.println("/community/json/getCommentList : GET");
		
		Search search = new Search();
		User user=(User)session.getAttribute("user");
	
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		System.out.println("currentPage : "+currentPage+" pageSize : "+pageSize);

		Map<String, Object> map = communityService.getCommentList(search, postId, user.getUserId());

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);

		map.put("totalCount", ((Integer)map.get("totalCount2")).intValue());
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("userId", user.getUserId());
		
		return map;
	}
	
	@RequestMapping( value="json/getRcmtList/{postId}", method=RequestMethod.GET )
	public Map<String, Object> getRcmtList( @PathVariable String postId, HttpServletResponse response, HttpSession session ) throws Exception{
		
		System.out.println("/community/json/getRcmtList : GET");
	
		User user = (User)session.getAttribute("user");
		
		List<Comment> list = communityService.rcmtNum(postId, user.getUserId());
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("userId", user.getUserId());
		
		return map;
	}
	
	@RequestMapping( value="json/getCommentList", method=RequestMethod.POST )
	public Map<String, Object> getCommentList( Search search, String postId, HttpSession session ) throws Exception{
		
		System.out.println("/community/json/getCommentList : POST");
		
		User user=(User)session.getAttribute("user");
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map=communityService.getCommentList(search, postId, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("postId", postId);
		
		return map;
	}
	
	@RequestMapping( value="json/getPostList", method=RequestMethod.GET )
	public Map<String, Object> getPostList( String boardName, Search search, HttpServletRequest request ) throws Exception{
		
		System.out.println("/community/getPostList : GET / POST");
		System.out.println("boardName : "+boardName);
		
		String bestPost = request.getParameter("bestPost");
		System.out.println(bestPost);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> map = new HashMap<String, Object>();
		
		if( boardName.equals("C") ) {
			if( search.getSorting() == null ) {
				search.setSorting("0");
			}
			map = communityService.getBestPostList(search, boardName);
		}else {
			map = communityService.getPostList(search, boardName);
		}
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("boardName", boardName);
		
		return map;
	}
}
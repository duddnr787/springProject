package com.myspring.springProWooks;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.myspring.springProWooks.entity.GoodsVO;
import com.myspring.springProWooks.entity.ImageFileVO;
import com.myspring.springProWooks.entity.MemberVO;
import com.myspring.springProWooks.service.AdminService;
import com.myspring.springProWooks.service.GoodsService;
import com.myspring.springProWooks.service.MemberService;

@Controller("AdminController")
@RequestMapping(value="/admin")
public class AdminController extends BaseController {
	
	@Autowired
	private AdminService adminService;

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private GoodsService goodsService;
	
	private static final String CURR_IMAGE_REPO_PATH = "/Users/kimyoungwook/Desktop/shopping/file_repo";
	
//	@RequestMapping(value = "/adminMainForm.do", method = RequestMethod.GET)
//	public String adminMainForm(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
//		
//		return "/admin/adminMain";
//	}
	
	@RequestMapping(value = "/goodsForm.do", method = RequestMethod.GET)
	public String goodsForm(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		return "/admin/registerGoods";
	}
	
	@RequestMapping(value="/inserNewGoods.do" ,method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addMember( MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		String imageFileName=null;
		
		Map<String, Object> newGoodsMap = new HashMap<String, Object>();
		
		Enumeration<String> enu = multipartRequest.getParameterNames(); //jsp?????? ?????? formData????????????. 
		while(enu.hasMoreElements()){ // ????????? ?????? ????????????.
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			newGoodsMap.put(name,value);
		}
		
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		
		String reg_id = memberVO.getMember_id();  //admin 
		
		List<ImageFileVO> imageFileList = upload(multipartRequest); //???????????? ????????? ?????? ?????? ??????. 
		if(imageFileList!= null && imageFileList.size()!=0) { //????????? admin?????? ????????????.
			for(ImageFileVO imageFileVO : imageFileList) {
				imageFileVO.setReg_id(reg_id);
			}
			newGoodsMap.put("imageFileList", imageFileList); //????????? ????????? ?????? ????????????.
		}
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			int goods_id = adminService.addNewGoods(newGoodsMap); // ????????? ?????? goods , image
			if(imageFileList!=null && imageFileList.size()!=0) { //????????? ?????? ????????????
				for(ImageFileVO  imageFileVO: imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"/"+"temp"+"/"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"/"+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
			result.put("status", true);
			result.put("message", "?????? ???????????????.");
			result.put("url", "/homeForm.do");
		} catch (Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) { //????????? ????????????
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"/"+"temp"+"/"+imageFileName);
					srcFile.delete();
				}
			}
			result.put("status", "false");
			result.put("message", "????????? ???????????????.");
			e.printStackTrace();
		}
		return result;
	}
	@ResponseBody
	@RequestMapping(value="/goodsList.do" ,method = RequestMethod.GET)
	public List<GoodsVO> goodsList(Model model){
		
		
		List<GoodsVO> goodslist = adminService.goodsList();
		model.addAttribute("goodslist", goodslist);
		
		return goodslist;
	}
	
	@RequestMapping(value = "/goodsListForm.do", method = RequestMethod.GET)
	public String goodsListForm(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		return "/admin/goodsList";
	}
	
	@RequestMapping(value = "/memberListForm.do", method = RequestMethod.GET)
	public String memberListForm(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		return "/admin/memberList";
	}
	
	@ResponseBody
	@RequestMapping(value="/memberList.do" ,method = RequestMethod.GET)
	public List<MemberVO> memberList(Model model){
		
		
		List<MemberVO> memberList = memberService.memberList();
		model.addAttribute("memberList", memberList);
		
		return memberList;
	}
	
	@RequestMapping(value="/permitUser.do" ,method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> permitUser(@RequestBody HashMap<String, String> member_id,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String permit = member_id.get("permit");
		
		
	
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(permit.equals("Y")) {
			member_id.put("permit", "N");
			memberService.permitUser(member_id);
			result.put("message", "????????? ?????? ??????");
			result.put("button", "????????? ??????");
		} else {
			member_id.put("permit", "Y");
			memberService.permitUser(member_id);
			result.put("message", "????????? ?????????");
			result.put("button", "????????? ??????");
		}
		return result;
	}
	
	@RequestMapping(value="/deleteGoods.do" ,method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteGoods(@RequestBody HashMap<String, String> goods_id,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {

		String goodsId = goods_id.get("goods_id");
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			goodsService.deleteGoods(goodsId);
			result.put("message", "?????? ???????????????.");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("message", "????????? ?????????????????????.");
		}
		
		return result;
	}
	
}

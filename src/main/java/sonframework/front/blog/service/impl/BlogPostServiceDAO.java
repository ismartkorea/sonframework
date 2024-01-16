package sonframework.front.blog.service.impl;

import java.util.Iterator;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import sonframework.front.blog.service.BlogPostInfo;
import sonframework.front.blog.service.BlogPostInfoVO;

@Repository("BlogPostServiceDAO")
public class BlogPostServiceDAO extends EgovAbstractMapper {

    /**
     * 게시판에 게시물을 등록 한다.
     *
     * @param BlogPost
     * @throws Exception
     */
    public void insertBlogPostArticle(BlogPostInfo post) throws Exception {
	long nttId = (Long)selectOne("PostServiceDAO.selectMaxNttId");
	post.setNttId(nttId);

	insert("PostServiceDAO.insertBlogPostArticle", post);
    }

    /**
     * 게시판에 답변 게시물을 등록 한다.
     *
     * @param BlogPost
     * @throws Exception
     */
    public long replyBlogPostArticle(BlogPostInfo post) throws Exception {
	long nttId = (Long)selectOne("PostServiceDAO.selectMaxNttId");
	post.setNttId(nttId);

	insert("PostServiceDAO.replyBlogPostArticle", post);

	//----------------------------------------------------------
	// 현재 글 이후 게시물에 대한 NTT_NO를 증가 (정렬을 추가하기 위해)
	//----------------------------------------------------------
	//String parentId = BlogPost.getParnts();
	long nttNo = (Long)selectOne("PostServiceDAO.getParentNttNo", post);

	post.setNttNo(nttNo);
	update("PostServiceDAO.updateOtherNttNo", post);

	post.setNttNo(nttNo + 1);
	update("PostServiceDAO.updateNttNo", post);

	return nttId;
    }

    /**
     * 게시물 한 건에 대하여 상세 내용을 조회 한다.
     *
     * @param BlogPostVO
     * @return
     * @throws Exception
     */
    public BlogPostInfoVO selectBlogPostArticle(BlogPostInfoVO postVO) throws Exception {
	return (BlogPostInfoVO)selectOne("PostServiceDAO.selectBlogPostArticle", postVO);
    }

    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     *
     * @param BlogPostVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BlogPostInfoVO> selectBlogPostArticleList(BlogPostInfoVO postVO) throws Exception {
	return (List<BlogPostInfoVO>) list("PostServiceDAO.selectBlogPostArticleList", postVO);
    }

    /**
     * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
     *
     * @param BlogPostVO
     * @return
     * @throws Exception
     */
    public int selectBlogPostArticleListCnt(BlogPostInfoVO postVO) throws Exception {
	return (Integer)selectOne("PostServiceDAO.selectBlogPostArticleListCnt", postVO);
    }

    /**
     * 게시물 한 건의 내용을 수정 한다.
     *
     * @param BlogPost
     * @throws Exception
     */
    public void updateBlogPostArticle(BlogPostInfo post) throws Exception {
	update("PostServiceDAO.updateBlogPostArticle", post);
    }

    /**
     * 게시물 한 건을 삭제 한다.
     *
     * @param BlogPost
     * @throws Exception
     */
    public void deleteBlogPostArticle(BlogPostInfo post) throws Exception {
	update("PostServiceDAO.deleteBlogPostArticle", post);
    }

    /**
     * 게시물에 대한 조회 건수를 수정 한다.
     *
     * @param BlogPost
     * @throws Exception
     */
    public void updateInqireCo(BlogPostInfoVO postVO) throws Exception {
	update("PostServiceDAO.updateInqireCo", postVO);
    }

    /**
     * 게시물에 대한 현재 조회 건수를 조회 한다.
     *
     * @param BlogPostVO
     * @return
     * @throws Exception
     */
    public int selectMaxInqireCo(BlogPostInfoVO postVO) throws Exception {
	return (Integer)selectOne("PostServiceDAO.selectMaxInqireCo", postVO);
    }

    /**
     * 게시판에 대한 목록을 정렬 순서로 조회 한다.
     *
     * @param BlogPostVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BlogPostInfoVO> selectNoticeListForSort(BlogPostInfo post) throws Exception {
	return (List<BlogPostInfoVO>) list("PostServiceDAO.selectNoticeListForSort", post);
    }

    /**
     * 게사판에 대한 정렬 순서를 수정 한다.
     *
     * @param sortList
     * @throws Exception
     */
    public void updateSortOrder(List<BlogPostInfoVO> sortList) throws Exception {
    BlogPostInfoVO vo;
	Iterator<BlogPostInfoVO> iter = sortList.iterator();
	while (iter.hasNext()) {
	    vo = (BlogPostInfoVO)iter.next();
	    update("PostServiceDAO.updateSortOrder", vo);
	}
    }

    /**
     * 게시판에 대한 현재 게시물 번호의 최대값을 구한다.
     *
     * @param BlogPostVO
     * @return
     * @throws Exception
     */
    public long selectNoticeItemForSort(BlogPostInfo post) throws Exception {
	return (Long)selectOne("PostServiceDAO.selectNoticeItemForSort", post);
    }

    /**
     * 방명록에 대한 목록을 조회 한다.
     *
     * @param BlogPostVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BlogPostInfoVO> selectGuestList(BlogPostInfoVO postVO) throws Exception {
	return (List<BlogPostInfoVO>) list("PostServiceDAO.selectGuestList", postVO);
    }

    /**
     * 방명록에 대한 목록 건수를 조회 한다.
     *
     * @param BlogPostVO
     * @return
     * @throws Exception
     */
    public int selectGuestListCnt(BlogPostInfoVO postVO) throws Exception {
	return (Integer)selectOne("PostServiceDAO.selectGuestListCnt", postVO);
    }

    /**
     * 방명록 내용을 삭제 한다.
     *
     * @param BlogPostVO
     * @throws Exception
     */
    public void deleteGuestList(BlogPostInfoVO postVO) throws Exception {
	update("PostServiceDAO.deleteGuestList", postVO);
    }

    /**
     * 방명록에 대한 패스워드를 조회 한다.
     *
     * @param BlogPostInfo
     * @return
     * @throws Exception
     */
    public String getPasswordInf(BlogPostInfo post) throws Exception {
	return (String)selectOne("PostServiceDAO.getPasswordInf", post);
    }
    
}

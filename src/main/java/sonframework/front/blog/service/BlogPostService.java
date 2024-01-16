package sonframework.front.blog.service;

import java.util.Map;

public interface BlogPostService {

    /**
     * 게시물 한 건을 삭제 한다.
     *
     */
    public void deleteBlogPostArticle(BlogPostInfo post) throws Exception;

    /**
     * 게시판에 게시물 또는 답변 게시물을 등록 한다.
     *
     */
    public void insertBlogPostArticle(BlogPostInfo post) throws Exception;

	/**
     * 게시물 대하여 상세 내용을 조회 한다.
     *
     */
    public BlogPostInfoVO selectBlogPostArticle(BlogPostInfoVO postVO) throws Exception;

	/**
     * 조건에 맞는 게시물 목록을 조회 한다.
     *
     */
    public Map<String, Object> selectBlogPostArticles(BlogPostInfoVO postVO) throws Exception;

    /**
     * 게시물 한 건의 내용을 수정 한다.
     *
     */
    public void updateBlogPostArticle(BlogPostInfo post) throws Exception;

    /**
     * 방명록 내용을 삭제 한다.
     *
     */
    public void deleteGuestList(BlogPostInfoVO postVO) throws Exception;

    /**
     * 방명록에 대한 목록을 조회 한다.
     *
     */
    public Map<String, Object> selectGuestList(BlogPostInfoVO postVO) throws Exception;

    /**
     * 방명록에 대한 패스워드를 조회 한다.
     *
     * @param board
     * @return
     * @throws Exception
     */
    public String getPasswordInf(BlogPostInfo post) throws Exception;
    
}

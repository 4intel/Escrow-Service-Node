package fouri.com.common.util;

/**
 * 리스트의 페이지이동 도구를 만들어 주는 유틸 클래스이다.
 * javascript page_util.js를 포함해야 한다.
 * @author xxx
 *
 */
public class ListPagingUtil {

	private String m_strScriptFunctionPrefix = "PageUtil";  // 첫번째 레코드의  번호가 0인가 여부
	private int m_nPageLinkPerDoc = 0;	// doc(html)에 표시되는  페이지 링크의 갯수 	
	private int m_nRecordPerPage = 0; 	// 한 페이지에 보여질 컨텐츠의 개수
	private int m_nDispPage = 0;			//현재 보여질 페이지(1 base)
	private int m_nTotalRecordCnt = 0;		//컨텐츠의 전체 개수
	private int m_nTotalPageCnt = 0;	//페이지 전체 개수
	private int m_nStartRecordNoOfThisPage = 0;		//보여질 리스트의 시작번호
	private boolean m_bFirstRecordNoIsZero = false;  // 첫번째 레코드의  번호가 0인가 여부
	
	/**
	 * 생성자
	 * @param strScriptFunctionPrefix : 각 페이지 링크를 클릭했을 때 호출될 함수 명앞에 붙을 선행문자열
	 *             Prefix 문자열이 ####라면 각 스크립트 함수이름은  
	 *              ####_FirstPage(),   ####_LastPage(),    ####_SelectPage(nPage) 형식이 된다.  
	 * @param nPageLinkPerDoc	doc(html)에 표시되는  페이지 링크의 갯수 	
	 * @param nRecordPerPage    한 페이지에 보여질 컨텐츠의 개수
	 * @param nDispPage         현재 보여질 페이지(1 base)
	 * @param nTotalPageCnt     페이지 전체 개수
	 * @param bFirstRecordNoIsZero 첫번째 레코드의  번호가 0인가 여부
	 */
	public ListPagingUtil(String strScriptFunctionPrefix, int nPageLinkPerDoc, int nRecordPerPage, int nDispPage, int nTotalRecordCnt,boolean bFirstRecordNoIsZero) {
		m_strScriptFunctionPrefix = strScriptFunctionPrefix;
		m_nPageLinkPerDoc = nPageLinkPerDoc;
		m_nRecordPerPage = nRecordPerPage;
		m_bFirstRecordNoIsZero = bFirstRecordNoIsZero;
		m_nTotalRecordCnt = nTotalRecordCnt;
		m_nTotalPageCnt = (m_nTotalRecordCnt / m_nRecordPerPage) + (m_nTotalRecordCnt % m_nRecordPerPage == 0 ? 0 : 1);
		
		setDispPage(nDispPage);

	}
	
	/**
	 * 
	 * @param nRecordNo
	 * @return  레코드의 페이지 번호(1 base)
	 */
	public int getPageNoByRecordNo(int nRecordNo) 
	{
		int nPageNo = 1;
		if(m_bFirstRecordNoIsZero)
			nPageNo =  nRecordNo / m_nRecordPerPage + 1;
		else
			nPageNo  = nRecordNo / m_nRecordPerPage + ( nRecordNo % m_nRecordPerPage == 0 ? 0 : 1);
		
		return nPageNo;
	}
	
	/**
	 * 현재 보여지는 페이지의 첫번째 레코드 번호를 조회
	 * @return
	 */
	public int getPageFirstRecordNo() 
	{
		return m_nStartRecordNoOfThisPage;
	}
	
	/**
	 * nPageNo의 첫번째 레코드 번호를 조회
	 * @param nPageNo ( 1 Base)
	 * @return
	 */
	public int getPageFirstRecordNo(int nPageNo) 
	{
		int nFristRecordNo = 0;
		if(m_bFirstRecordNoIsZero)
			nFristRecordNo =  (nPageNo-1) * m_nRecordPerPage;
		else
			nFristRecordNo = (nPageNo-1) * m_nRecordPerPage + 1;
		return nFristRecordNo;
	}
	/**
	 * 보여질 페이지 설정
	 * @param nDispPage
	 */
	public void setDispPage(int nDispPage) 
	{
		this.m_nDispPage = nDispPage;	
		if(m_bFirstRecordNoIsZero)
			m_nStartRecordNoOfThisPage =  (nDispPage-1) * m_nRecordPerPage;
		else
			m_nStartRecordNoOfThisPage = (nDispPage-1) * m_nRecordPerPage + 1;
	}
	/**
	 * 페이징 스타일 01
	 * @return
	 */
	public String getPagingStyle01() 
	{
		String sPF = m_strScriptFunctionPrefix;
		int nStartPage = ((m_nDispPage-1) / m_nPageLinkPerDoc) * m_nPageLinkPerDoc + 1;
		int nLastPage = nStartPage + m_nPageLinkPerDoc - 1;
		if(nLastPage > m_nTotalPageCnt) nLastPage = m_nTotalPageCnt;
		
		StringBuffer sbPageTemplate = new StringBuffer();
		sbPageTemplate.append("<div class='pu_listpaging'>");
		
		if(m_nDispPage > 1)
		{
			sbPageTemplate.append("<span class='pu_pagingstart'><a href='javascript:" + sPF + "_FirstPage();'>처음</a></span>");
			sbPageTemplate.append("<span class='pu_pagingprev'><a href='javascript:" + sPF + "_SelectPage(" + (m_nDispPage-1) + ");'>이전</a></span>");
		}
		else
		{
			sbPageTemplate.append("<span class='pu_pagingstart'>처음</span>");
			sbPageTemplate.append("<span class='pu_pagingprev'>이전</span>");
		}
		for(int i = nStartPage; i <= nLastPage; i++)
		{
			if(i != m_nDispPage)
				sbPageTemplate.append("<span class='pu_pagingpage'><a href='javascript:" + sPF + "_SelectPage(" + i + ");'>" + i + "</a></span>");
			else
				sbPageTemplate.append("<span class='pu_pagingselpage'>" + i + "</span>");
		}
		if(m_nDispPage < m_nTotalPageCnt)
		{
			sbPageTemplate.append("<span class='pu_pagingnext'><a href='javascript:" + sPF + "_SelectPage(" + (m_nDispPage+1) + ");'>다음</a></span>");
			sbPageTemplate.append("<span class='pu_pagingend'><a href='javascript:" + sPF + "_LastPage(" + m_nTotalPageCnt + ");'>끝</a></span>");
		}
		else
		{
			sbPageTemplate.append("<span class='pu_pagingnext'>다음</span>");
			sbPageTemplate.append("<span class='pu_pagingend'>끝</span>");
		}
		sbPageTemplate.append("</div>");
		return sbPageTemplate.toString();
	}
	
	
	/**
	 * 페이징 스타일 02
	 * @return
	 */
	public String getPagingStyle02() 
	{
		String sPF = m_strScriptFunctionPrefix;
		int nStartPage = ((m_nDispPage-1) / m_nPageLinkPerDoc) * m_nPageLinkPerDoc + 1;
		int nLastPage = nStartPage + m_nPageLinkPerDoc - 1;
		if(nLastPage > m_nTotalPageCnt) nLastPage = m_nTotalPageCnt;
		StringBuffer sbPageTemplate = new StringBuffer();
		if(m_nDispPage > 1)
			sbPageTemplate.append("<a class='pu_pagingprev' href='javascript:" + sPF + "_SelectPage(" + (m_nDispPage -1) + ");'>prev</a>&nbsp;");
		else
			sbPageTemplate.append("<span class='pu_pagingprev'>prev</span>&nbsp;");
		for(int i = nStartPage; i <= nLastPage; i++)
		{
			if(i != m_nDispPage)
				sbPageTemplate.append("<span class='pu_pagingpage'><a href='javascript:" + sPF + "_SelectPage(" + i + ");'>" + i + "</a></span>");
			else
				sbPageTemplate.append("<span class='pu_pagingselpage'><strong>" + i + "</strong></span>");
		}
		if(m_nDispPage < m_nTotalPageCnt)
			sbPageTemplate.append("<a class='pu_pagingnext' href='javascript:" + sPF + "_SelectPage(" + (m_nDispPage + 1) + ");'>next</a>");
		else
			sbPageTemplate.append("<span class='pu_pagingnext'>next</span>");
		return sbPageTemplate.toString();
	} 
	
	/**
	 * 페이징 스타일 03 (견태수 포맷)
	 * <div class="paging" style="float:right; margin-top:20px; width:50%; text-align:right; ">
	 * getPagingStyle03()
	 *  </div> 형식을 사용 
.paging ul {
	list-style:none;
	float:right;
	display:inline;
}
.paging ul li {
	float:left;
}
.paging ul li a {
	float:left;
	padding:4px;
	margin-right:3px;
	width:15px;
	font: 12px tahoma;
	border:1px solid #eee;
	text-align:center;
	text-decoration:none;
	background:#FFFFFF;

}
.paging ul li a:hover, ul li a:focus {
	color:#fff;
	border:1px solid #eee;
	background-color:#4e8fc6;
	font:bold 12px tahoma;
}

.paging .on  a:link {
	color:#fff;
	border:1px solid #eee;
	background-color:#4e8fc6;
	font:bold 12px tahoma;
}
	 * @return
	 */
	public String getPagingStyle03() 
	{
		String sPF = m_strScriptFunctionPrefix;
		int nStartPage = ((m_nDispPage-1) / m_nPageLinkPerDoc) * m_nPageLinkPerDoc + 1;
		int nLastPage = nStartPage + m_nPageLinkPerDoc - 1;
		if(nLastPage > m_nTotalPageCnt) nLastPage = m_nTotalPageCnt;
		
		StringBuffer sbPageTemplate = new StringBuffer();
		sbPageTemplate.append("<ul>");
		if(m_nDispPage > 1)
		{
			sbPageTemplate.append("<li><a href='javascript:" + sPF + "_FirstPage();'>≪</a></li>");
			sbPageTemplate.append("<li><a href='javascript:" + sPF + "_SelectPage(" + (m_nDispPage-1) + ");'>◀</a></li>");
		}
		else
		{
			sbPageTemplate.append("<li><a href='#'>≪</a></li>");
			sbPageTemplate.append("<li><a href='#'>◀</a></li>");
		}
		int i;
		for(i = nStartPage; i <= nLastPage; i++)
		{
			if(i != m_nDispPage)
				sbPageTemplate.append("<li><a href='javascript:" + sPF + "_SelectPage(" + i + ");'>" + i + "</a></li>");
			else
				sbPageTemplate.append("<li class='on'><a href='#'>" + i + "</a></li>");
		}

		if(m_nDispPage < m_nTotalPageCnt)
		{
			sbPageTemplate.append("<li><a href='javascript:" + sPF + "_SelectPage(" + (m_nDispPage+1) + ");'>▶</a></li>");
			sbPageTemplate.append("<li><a href='javascript:" + sPF + "_LastPage(" + m_nTotalPageCnt + ");'>≫</a></li>");
		}
		else
		{
			sbPageTemplate.append("<li><a href='#'>▶</a></li>");
			sbPageTemplate.append("<li><a href='#'>≫</a></li>");
		}
		sbPageTemplate.append("</ul>");
		return sbPageTemplate.toString();
	}
	
	/*************
	**
	 * 페이징 스타일 04 (견태수 포맷)
	** 페이징
	*		<div class='paging'>
	*       getPagingStyle04();
	*       </div>
	**
	.paging {text-align:center;font-size:13px;}
	.paging a {display:inline-block;width:30px;height:30px;line-height:28px;text-align:center;border:1px solid #ddd;border-left:none;margin-left:-3px;vertical-align: middle;}
	.paging a.on {background:#008fd4;color:#fff;}
	.paging a.pg-first {width:40px;border-left:1px solid #ddd;background:#f4f4f4 url('../images/list/pg_first.png') center center no-repeat;border-top-left-radius:5px;border-bottom-left-radius:5px;}
	.paging a.pg-prev {width:40px;background:#f4f4f4 url('../images/list/pg_prev.png') center center no-repeat;}
	.paging a.pg-next {width:40px;background:#f4f4f4 url('../images/list/pg_next.png') center center no-repeat;}
	.paging a.pg-last {width:40px;background:#f4f4f4 url('../images/list/pg_last.png') center center no-repeat;border-top-right-radius:5px;border-bottom-right-radius:5px;}
	**************/
	
	public String getPagingStyle04() 
	{
		String sPF = m_strScriptFunctionPrefix;
		int nStartPage = ((m_nDispPage-1) / m_nPageLinkPerDoc) * m_nPageLinkPerDoc + 1;
		int nLastPage = nStartPage + m_nPageLinkPerDoc - 1;
		if(nLastPage > m_nTotalPageCnt) nLastPage = m_nTotalPageCnt;
		
		StringBuffer sbPageTemplate = new StringBuffer();
//		sbPageTemplate.append("<div class='paging'>");
		if(m_nDispPage > 1)
		{
			sbPageTemplate.append("<a href='javascript:" + sPF + "_FirstPage();' class='pg-first'></a>");
			sbPageTemplate.append("<a href='javascript:" + sPF + "_SelectPage(" + (m_nDispPage-1) + ");' class='pg-prev'></a>");
		}
		else
		{
			sbPageTemplate.append("<a href='#' class='pg-first'></a>");
			sbPageTemplate.append("<a href='#' class='pg-prev'></a>");
		}
		int i;
		for(i = nStartPage; i <= nLastPage; i++)
		{
			if(i != m_nDispPage)
				sbPageTemplate.append("<a href='javascript:" + sPF + "_SelectPage(" + i + ");'>" + i + "</a>");
			else
				sbPageTemplate.append("<a href='#' class='on'>" + i + "</a>");
		}

		if(m_nDispPage < m_nTotalPageCnt)
		{
			sbPageTemplate.append("<a href='javascript:" + sPF + "_SelectPage(" + (m_nDispPage+1) + ");' class='pg-next'></a>");
			sbPageTemplate.append("<a href='javascript:" + sPF + "_LastPage(" + m_nTotalPageCnt + ");' class='pg-last'></a>");
		}
		else
		{
			sbPageTemplate.append("<a href='#' class='pg-nextt'></a>");
			sbPageTemplate.append("<a href='#' class='pg-last'></a>");
		}
//		sbPageTemplate.append("</div>");
		return sbPageTemplate.toString();
	}
}
	

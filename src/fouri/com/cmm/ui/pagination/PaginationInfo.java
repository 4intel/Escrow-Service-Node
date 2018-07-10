package fouri.com.cmm.ui.pagination;

public class PaginationInfo
{
  private int currentPageNo;
  private int recordCountPerPage;
  private int pageSize;
  private int totalRecordCount;
  private int totalPageCount;
  private int firstPageNoOnPageList;
  private int lastPageNoOnPageList;
  private int firstRecordIndex;
  private int lastRecordIndex;

  public int getRecordCountPerPage()
  {
    return this.recordCountPerPage;
  }

  public void setRecordCountPerPage(int recordCountPerPage) {
    this.recordCountPerPage = recordCountPerPage;
  }

  public int getPageSize() {
    return this.pageSize;
  }

  public void setPageSize(int pageSize) {
    this.pageSize = pageSize;
  }

  public int getCurrentPageNo() {
    return this.currentPageNo;
  }

  public void setCurrentPageNo(int currentPageNo) {
    this.currentPageNo = currentPageNo;
  }

  public void setTotalRecordCount(int totalRecordCount) {
    this.totalRecordCount = totalRecordCount;
  }

  public int getTotalRecordCount() {
    return this.totalRecordCount;
  }

  public int getTotalPageCount()
  {
    this.totalPageCount = ((getTotalRecordCount() - 1) / getRecordCountPerPage() + 1);
    return this.totalPageCount;
  }

  public int getFirstPageNo() {
    return 1;
  }

  public int getLastPageNo() {
    return getTotalPageCount();
  }

  public int getFirstPageNoOnPageList() {
    this.firstPageNoOnPageList = ((getCurrentPageNo() - 1) / getPageSize() * getPageSize() + 1);
    return this.firstPageNoOnPageList;
  }

  public int getLastPageNoOnPageList() {
    this.lastPageNoOnPageList = (getFirstPageNoOnPageList() + getPageSize() - 1);
    if (this.lastPageNoOnPageList > getTotalPageCount()) {
      this.lastPageNoOnPageList = getTotalPageCount();
    }
    return this.lastPageNoOnPageList;
  }

  public int getFirstRecordIndex() {
    this.firstRecordIndex = ((getCurrentPageNo() - 1) * getRecordCountPerPage());
    return this.firstRecordIndex;
  }

  public int getLastRecordIndex() {
    this.lastRecordIndex = (getCurrentPageNo() * getRecordCountPerPage());
    return this.lastRecordIndex;
  }
}
package fouri.com.cpwallet.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import fouri.com.cmm.service.impl.FouriComAbstractDAO;
import fouri.com.cpwallet.service.EscrowBoardVO;
import fouri.com.cpwallet.service.EscrowTrans;

@Repository("EscrowArticleDAO")
public class EscrowArticleDAO extends FouriComAbstractDAO {

	public int selectListCnt(String query, Object obj) {		
		return (Integer) selectOne("EscrowBBSArticle."+query, obj);
	}
	public List<HashMap> selectList(String query, Object obj) {		
		return (List<HashMap>) list("EscrowBBSArticle."+query, obj);
	}
	public HashMap selectView(String query, Object obj) {
		return (HashMap) selectOne("EscrowBBSArticle."+query, obj);
	}
	public int escrowInsert(String query, Object obj) {
		return insert("EscrowBBSArticle."+query, obj);
	}
	public int escrowUpdate(String query, Object obj) {
		return update("EscrowBBSArticle."+query, obj);
	}
	public int escrowDelete(String query, Object obj) {
		return delete("EscrowBBSArticle."+query, obj);
	}
	
	
	
	
	public int selectEscrowBbsArticleListCnt(EscrowBoardVO escrowBoardVO) {		
		return (Integer) selectOne("EscrowBBSArticle.escrowBbsListCnt", escrowBoardVO);
	}

	public List<HashMap> selectEscrowBbsArticleList(EscrowBoardVO escrowBoardVO) {		
		return (List<HashMap>) list("EscrowBBSArticle.escrowBbsList", escrowBoardVO);
	}
	public List<HashMap> selectEscrowTotalList(EscrowBoardVO escrowBoardVO) {		
		return (List<HashMap>) list("EscrowBBSArticle.escrowBbsTotalList", escrowBoardVO);
	}
	
	public HashMap selectEscrowBbsArticleView(EscrowBoardVO escrowBoardVO) {
		return (HashMap) selectOne("EscrowBBSArticle.escrowBbsView", escrowBoardVO);
	}
	
	public void selectEscrowBbsArticleInsert(EscrowBoardVO escrowBoardVO) {
		int BbsMaxNum = (Integer) selectOne("EscrowBBSArticle.escrowBbsMaxNum", escrowBoardVO);
		escrowBoardVO.setBoardNumCnt(BbsMaxNum);
		insert("EscrowBBSArticle.escrowBbsInsert", escrowBoardVO);
	}
	
	public void selectEscrowBbsArticleUpdate(EscrowBoardVO escrowBoardVO) {
		update("EscrowBBSArticle.escrowBbsUpdate", escrowBoardVO);
	}
	
	public void selectEscrowBbsArticleDelete(EscrowBoardVO escrowBoardVO) {
		delete("EscrowBBSArticle.escrowBbsDelete", escrowBoardVO);
	}    
	
	

	public void escrowTransInsert(EscrowTrans escrowBoardVO) {
		insert("EscrowBBSArticle.escrowTransInsert", escrowBoardVO);
	}
}

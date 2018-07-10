<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="nav-sidebar">
		<div class="nav-sidebar-inner-scroll">
		
			<ul class="sidebar-top-level-items">
				<li class="home active">
					<ul class="sidebar-sub-level-items">
					    
					    <!-- left menu -->
					    <li class="<%if((request.getRequestURI()).equals("/mgr/coin_list.jsp") || (request.getRequestURI()).equals("/mgr/coin_state.jsp")){%>active<%}%>"><a title="Cycle Analytics" class="shortcuts-project-cycle-analytics" href="coin_list.jsp"><span>코인 목록</span></a></li>
					    <li class="<%if((request.getRequestURI()).equals("/mgr/wallet_history.jsp")){%>active<%}%>"><a title="Cycle Analytics" class="shortcuts-project-cycle-analytics" href="wallet_history.jsp"><span>지갑 목록</span></a></li> 
					    
					</ul>
				</li>
			</ul>
		
		</div>
	</div>
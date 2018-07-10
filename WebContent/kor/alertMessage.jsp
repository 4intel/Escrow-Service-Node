<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function alertMassage(message) { //alert 대신 레이어 메시지창 호출
	$("#myModal").modal({backdrop: true}); //true:dark overlay, false:no overlay(transparent), static:no dark overlay close;
	$('#id_error_message').html(message); //넘겨받은 메세지 출력
}

function alertMassageCallBack(message) { //alert 대신 레이어 메시지창 호출
	$("#myModal").modal({backdrop: true}); //true:dark overlay, false:no overlay(transparent), static:no dark overlay close;
	$('#id_error_message').html(message); //넘겨받은 메세지 출력
	
	$("#myModal").on('hidden.bs.modal', function () { //메세지출력후 history.back 실행
		history.back(); //메세지닫기 후 실행함수
	});
}

function alertMassageUrl(message,url) { //alert 대신 레이어 메시지창 호출
	$("#myModal").modal({backdrop: true}); //true:dark overlay, false:no overlay(transparent), static:no dark overlay close;
	$('#id_error_message').html(message); //넘겨받은 메세지 출력
	
	$("#myModal").on('hidden.bs.modal', function () { //메세지출력후 history.back 실행
		location.href=url;
	});
}
</script>
	
	  <!-- Modal -->
	  <div class="modal fade" id="myModal" role="dialog" style="display:none;">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header">
	          <h4 class="modal-title">Coinpool Message</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <div class="modal-body" id='id_error_message'><!-- error message --></div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>
	  <!-- Modal -->

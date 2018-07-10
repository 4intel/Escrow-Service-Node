package fouri.com.cmm.service;

public class Globals {
	//OS 유형
    public static final String OS_TYPE = FouriProperties.getProperty("Globals.OsType");
    //DB 유형
    public static final String DB_TYPE = FouriProperties.getProperty("Globals.DbType");
    //메인 페이지
    public static final String MAIN_PAGE = FouriProperties.getProperty("Globals.MainPage");
    //ShellFile 경로
    public static final String SHELL_FILE_PATH = FouriProperties.getPathProperty("Globals.ShellFilePath");
    //퍼로퍼티 파일 위치
    public static final String CONF_PATH = FouriProperties.getPathProperty("Globals.ConfPath");
    //Server정보 프로퍼티 위치
    public static final String SERVER_CONF_PATH = FouriProperties.getPathProperty("Globals.ServerConfPath");
    //Client정보 프로퍼티 위치
    public static final String CLIENT_CONF_PATH = FouriProperties.getPathProperty("Globals.ClientConfPath");
    //파일포맷 정보 프로퍼티 위치
    public static final String FILE_FORMAT_PATH = FouriProperties.getPathProperty("Globals.FileFormatPath");

    //파일 업로드 원 파일명
	public static final String ORIGIN_FILE_NM = "originalFileName";
	//파일 확장자
	public static final String FILE_EXT = "fileExtension";
	//파일크기
	public static final String FILE_SIZE = "fileSize";
	//업로드된 파일명
	public static final String UPLOAD_FILE_NM = "uploadFileName";
	//파일경로
	public static final String FILE_PATH = "filePath";

	//메일발송요청 XML파일경로
	public static final String MAIL_REQUEST_PATH = FouriProperties.getPathProperty("Globals.MailRequestPath");
	//메일발송응답 XML파일경로
	public static final String MAIL_RESPONSE_PATH = FouriProperties.getPathProperty("Globals.MailRResponsePath");

	// G4C 연결용 IP (localhost)
	public static final String LOCAL_IP = FouriProperties.getProperty("Globals.LocalIp");



}

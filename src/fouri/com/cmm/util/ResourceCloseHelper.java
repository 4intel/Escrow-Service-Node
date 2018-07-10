package fouri.com.cmm.util;

import java.io.Closeable;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Wrapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ResourceCloseHelper {
	private static final Logger logger = LoggerFactory.getLogger(ResourceCloseHelper.class); 
	
	/**
	 * Resource close 처리.
	 * @param resources
	 */
	public static void close(Closeable  ... resources) {
		for (Closeable resource : resources) {
			if (resource != null) {
				try {
					resource.close();
				} catch (Exception ignore) {
					logger.error("Occurred Exception to close resource is ingored!!");
				}
			}
		}
	}
	
	/**
	 * JDBC 관련 resource 객체 close 처리
	 * @param objects
	 */
	public static void closeDBObjects(Wrapper ... objects) {
		for (Object object : objects) {
			if (object != null) {
				if (object instanceof ResultSet) {
					try {
						((ResultSet)object).close();
					} catch (Exception ignore) {
						logger.error("Occurred Exception to close resource is ingored!!");
					}
				} else if (object instanceof Statement) {
					try {
						((Statement)object).close();
					} catch (Exception ignore) {
						logger.error("Occurred Exception to close resource is ingored!!");
					}
				} else if (object instanceof Connection) {
					try {
						((Connection)object).close();
					} catch (Exception ignore) {
						logger.error("Occurred Exception to close resource is ingored!!");
					}
				} else {
					throw new IllegalArgumentException("Wrapper type is not found : " + object.toString());
				}
			}
		}
	}
	
	/**
	 * Socket 관련 resource 객체 close 처리
	 * @param objects
	 */
	public static void closeSocketObjects(Socket socket, ServerSocket server) {
		if (socket != null) {
			try {
				socket.shutdownOutput();
			} catch (Exception ignore) {
				logger.error("Occurred Exception to shutdown ouput is ignored!!");
			}
			
			try {
				socket.close();
			} catch (Exception ignore) {
				logger.error("Occurred Exception to close resource is ignored!!");
			}
		}
		
		if (server != null) {
			try {
				server.close();
			} catch (Exception ignore) {
				logger.error("Occurred Exception to close resource is ignored!!");
			}
		}
	}
	
	/**
	 *  Socket 관련 resource 객체 close 처리
	 *  
	 * @param sockets
	 */
	public static void closeSockets(Socket ... sockets) {
		for (Socket socket : sockets) {
			if (socket != null) {
				try {
					socket.shutdownOutput();
				} catch (Exception ignore) {
					logger.error("Occurred Exception to shutdown ouput is ignored!!");
				}
				
				try {
					socket.close();
				} catch (Exception ignore) {
					logger.error("Occurred Exception to close resource is ignored!!");
				}
			}
		}
	}
}
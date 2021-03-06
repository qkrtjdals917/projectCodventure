package com.lec.spring;

import static org.junit.jupiter.api.Assertions.fail;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;

import org.junit.jupiter.api.Test;

class DummyData {

	// JDBC 관련 기본 객체 변수들 선언
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;   // executeQuery(), SELECT 결과 
	int cnt = 0;           // executeUpdate(), DML 결과	
	
	// MySQL
	public static final String DRIVER = "com.mysql.cj.jdbc.Driver";  // JDBC 드라이버 클래스
	public static final String URL = "jdbc:mysql://localhost:3306/modaconDB";  // DB 서버 정보
	public static final String USERID = "md_root";   // DB 사용자 계정 정보
	public static final String USERPW = "codventure";

//	public static final String SQL_AUTH = 
//			"INSERT INTO mc_authority" +
//						"(authority, auth_name)" +
//						"VALUES(0, '회원')";
//	
//	
//	public static final String SQL_MEMBER_ROOT = 
//			"INSERT INTO mc_member" + 
//					"(email, password, nickname, phoneNumber, authority) " +
//					"VALUES( 'root@root.com', 'root', 'root', '010-1234-1234', 2)";	
	
	public static final String SQL_MEMBER_DUMMY = 
			"INSERT INTO mc_member" + 
					"(email, password, nickname, phoneNumber) " +
					"VALUES(?, ?, ?, ?)";	
	
	
	public static final String email = "testemail";
	public static final String emailend = "@test.com";
	public static final String [] password = {"1234", "1q2w3e4r", "asdf", "0000", "0917"};
	public static final String nickname = "Test";
	public static final String [] phoneNumber = {"010-8989-1714", "010-1234-4566", "010-757-1745"};
	
	public static final String SQL_BOARD_DUMMY = 
			"INSERT INTO mc_board" + 
					"(type, subject, tag, content, member_uid) " +
					"VALUES(?, ?, ?, ?, ?)";
	
	
	public static final String SQL_NOTICE_DUMMY = 
			"INSERT INTO mc_board (type, subject, content, member_uid)"
			+ "VALUES ('공지', ?, ?, 1)";
	
	public static final String SQL_REPORT_DUMMY =
			"INSERT INTO mc_report" +
					"(board_uid, report_uid, report_tag, report_content, member_uid)"
					+ "VALUES(?, ?, ?, ?, ?)";
	
	
	public static final String [] TYPE = {"자유", "정보"};
	public static final String SUBJECT = "Subject";
	public static final String [] TAG1 = {"유머","잡담","질문"};
	public static final String [] TAG2 = {"코인","뉴스","팁과노하우"};
	public static final String CONTENT = "content";
	
	
	
	@Test
	void test() {
		fail("Not yet implemented");
	}

	
	@Test
	void genData() {
		try {
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(URL, USERID, USERPW);

//			// 테스트용 dummy 데이터 만들기
//			pstmt = conn.prepareStatement(SQL_MEMBER_ROOT);
//			cnt = pstmt.executeUpdate();
//			
//			pstmt.close();
			
			pstmt = conn.prepareStatement(SQL_MEMBER_DUMMY);
			int num = 50;	// 많은 데이터
			Random rand = new Random();
			
			for(int i = 0; i < num; i++) {
				pstmt.setString(1, email + i + emailend );  // testmail1@test.com testmail2@test.com ...
				pstmt.setString(2, password[rand.nextInt(password.length)]);  // content0000, content0001, ...
				pstmt.setString(3, nickname + i);   // name0000, name0001, ....
				pstmt.setString(4, phoneNumber[rand.nextInt(phoneNumber.length)]);
				cnt += pstmt.executeUpdate();
			}
			System.out.println(cnt + "개 의 데이터가 INSERT 되었습니다");
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@Test
	void genBoardData() {
		try {
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(URL, USERID, USERPW);

			pstmt = conn.prepareStatement(SQL_BOARD_DUMMY);
			int num = 200;	// 많은 데이터
			Random rand = new Random();
			//(type, subject, tag, content, member_uid) 
			for(int i = 0; i < num; i++) {
				int typenumber = rand.nextInt(TYPE.length);
				pstmt.setString(1, TYPE[typenumber] );  // 자유, 정보
				pstmt.setString(2, SUBJECT + i);
				switch (typenumber) {
					case 0 :
						pstmt.setString(3, TAG1[rand.nextInt(TAG1.length)] );
						break;
					case 1 :
						pstmt.setString(3, TAG2[rand.nextInt(TAG2.length)] );
						break;
//					case 2 :
//						pstmt.setString(3, "" );
//						break;
				}

				pstmt.setString(4, CONTENT + i);   
				
				pstmt.setInt(5, rand.nextInt(50)+1);
				
				cnt += pstmt.executeUpdate();
			}
			System.out.println(cnt + "개 의 데이터가 INSERT 되었습니다");
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@Test
	void noticeData() {
		try {
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(URL, USERID, USERPW);
			pstmt = conn.prepareStatement(SQL_NOTICE_DUMMY);
			
			int num = 10;
			for (int i = 0; i < num; i++) {
				pstmt.setString(1, "noticesubject" + i);
				pstmt.setString(2, "noticeContent" + i);
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	@Test
	void reportData() {
		try {
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(URL, USERID, USERPW);
			pstmt = conn.prepareStatement(SQL_REPORT_DUMMY);
			
			int num = 10;
			for (int i = 0; i < num; i++) {
				pstmt.setString(1, "reportContent" + i);
				pstmt.setString(2, "reportContent" + i);
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
}

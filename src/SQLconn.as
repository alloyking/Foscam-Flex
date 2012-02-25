////NOT USED.  Could be used to store username password for a deployed application

package
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	public class SQLconn
	{
		private var sessionDBConn:SQLConnection;
		private var sessionDBFile:File
		private var selectStmt:SQLStatement;
		public var  result:SQLResult
		
		
		public function SQLconn()
		{
			sessionDBConn = new SQLConnection();
			sessionDBConn.addEventListener(SQLEvent.OPEN, openSessionSuccess);
			sessionDBConn.addEventListener(SQLErrorEvent.ERROR, openSessionFailure);
			
			var embededSessionDB:File = File.applicationDirectory.resolvePath("connect.db");
			sessionDBConn.openAsync(embededSessionDB);	
			
		}
		protected function openSessionSuccess(event:SQLEvent):void{
			sessionDBConn.removeEventListener(SQLEvent.OPEN, openSessionSuccess);
			sessionDBConn.removeEventListener(SQLErrorEvent.ERROR, openSessionFailure);
			
			selectStmt = new SQLStatement();
			selectStmt.sqlConnection = sessionDBConn;
			var sql:String = "SELECT * FROM user";
			selectStmt.text = sql;
			
			selectStmt.addEventListener(SQLEvent.RESULT, selectResult);
			selectStmt.addEventListener(SQLErrorEvent.ERROR, openSessionFailure);
			
			selectStmt.execute();				
		}	
		protected function openSessionFailure(event:SQLEvent):void{
			selectStmt.removeEventListener(SQLEvent.RESULT, selectResult);
			selectStmt.removeEventListener(SQLErrorEvent.ERROR, openSessionFailure);
			sessionDBConn.removeEventListener(SQLEvent.OPEN, openSessionSuccess);
			sessionDBConn.removeEventListener(SQLErrorEvent.ERROR, openSessionFailure);
				trace("this did not work");
			
		}
		
		protected function selectResult(event:SQLEvent):void{
			selectStmt.removeEventListener(SQLEvent.RESULT, selectResult);
			selectStmt.removeEventListener(SQLErrorEvent.ERROR, openSessionFailure);			
			result = selectStmt.getResult();
						
		}
	
	}
}
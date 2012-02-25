package
{
	public class Connection
	{
		public var httpUrl:String = "";  //yourIPDomain.com
		public var cgi:String = "/videostream.cgi?resolution=32&"; //?resolution=32& optional
		public var port:int = 8001;//your port
		public var userName:String = ""; //username
		public var password:String = ""; //password
		
		public function Connection()
		{
		}
	}
}
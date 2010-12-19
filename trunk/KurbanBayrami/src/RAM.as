package  
{
	import actors.Koyun;
	import actors.Kurbanlik;
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class RAM 
	{
		private static var _sacrificables:Vector.<Kurbanlik>;
		
		public static function addSacrificable(k:Kurbanlik):void {
			if (!_sacrificables) _sacrificables = new Vector.<Kurbanlik>();
			//
			_sacrificables.push(k);
			trace("added! population :", _sacrificables.length);
		}
		
		static public function get sacrificables():Vector.<Kurbanlik> {
			if (!_sacrificables) _sacrificables = new Vector.<Kurbanlik>();
			//
			return _sacrificables; 
		}
		
		
		
		
		
	}

}
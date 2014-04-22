package com.admod.ane 
{ 
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	/**
	 * 
	 * @author Rect  2014-4-21 
	 * 
	 */
	public class AdmodExtension extends EventDispatcher
	{ 
		//iOS api
		private static const ADMOD_FUNCTION_BANNER:String = "admod_function_banner";
		private static const ADMOD_FUNCTION_INTERSTITIAL:String = "admod_function_interstitial";
		
		private static const EXTENSION_ID:String = "com.admod.ane.AdmodsANE";//与extension.xml中的id标签一致
		private var extContext:ExtensionContext;
		
		/**单例的实例*/
		private static var _instance:AdmodExtension; 
		
		public function AdmodExtension(target:IEventDispatcher=null)
		{
			super(target);
			if(extContext == null) {
				extContext = ExtensionContext.createExtensionContext(EXTENSION_ID, "");
				extContext.addEventListener(StatusEvent.STATUS, statusHandler);
			}
		} 
		
		//iOS func
		public function AdmodBanner(admodAppKeyID:String):String{
			
			if(extContext ){
				return extContext.call(ADMOD_FUNCTION_BANNER,admodAppKeyID
				) as String;
			}
			return "call AdmodBanner failed";
		} 
		
		public function AdmodInterStatial(admodAppKeyID:String):String{
			
			if(extContext ){
				return extContext.call(ADMOD_FUNCTION_INTERSTITIAL,admodAppKeyID) as String;
			}
			return "call AdmodInterStatial failed";
		} 
		
		//第二个为参数，会传入java代码中的FREExtension的createContext方法
		/**
		 * 获取实例
		 * @return DLExtension 单例
		 */
		public static function getInstance():AdmodExtension
		{
			if(_instance == null) 
				_instance = new AdmodExtension();
			return _instance;
		}
		
		/**
		 * 转抛事件
		 * @param event 事件
		 */
		private function statusHandler(event:StatusEvent):void
		{
			dispatchEvent(event);
		}
	} 
}